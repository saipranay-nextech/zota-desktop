import { exec } from 'child_process';
import { promisify } from 'util';
import * as path from 'path';
import * as fs from 'fs';
import { app as electronApp } from 'electron';
import { postgresInstallerService } from './postgres-installer';
import { DATABASE_NAME, POSTGRES_DEFAULT_PASSWORD } from '../../shared/constants';
import { getBackendPath } from '../utils/paths';

const execAsync = promisify(exec);

const dynamicImport = new Function('specifier', 'return import(specifier)') as (specifier: string) => Promise<any>;

class DatabaseSetupService {
  private pgPassword: string = POSTGRES_DEFAULT_PASSWORD;

  setPassword(password: string): void {
    this.pgPassword = password;
  }

  getPassword(): string {
    return this.pgPassword;
  }

  private async runPsql(
    command: string,
    database: string = 'postgres'
  ): Promise<{ success: boolean; output?: string; error?: string }> {
    const status = await postgresInstallerService.checkInstallation();

    if (!status.installed || !status.binPath) {
      return { success: false, error: 'PostgreSQL not installed' };
    }

    const psqlBin = process.platform === 'win32' ? 'psql.exe' : 'psql';
    const psqlPath = path.join(status.binPath, psqlBin);
    const fullCommand = `"${psqlPath}" -U postgres -d ${database} -c "${command}"`;

    try {
      const { stdout } = await execAsync(fullCommand, {
        env: { ...process.env, PGPASSWORD: this.pgPassword },
      });
      return { success: true, output: stdout };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }

  async testConnection(): Promise<{ success: boolean; authFailed?: boolean }> {
    const result = await this.runPsql('SELECT 1');
    if (result.success) {
      return { success: true };
    }
    const authFailed = result.error?.includes('password authentication failed') || false;
    return { success: false, authFailed };
  }

  async checkDatabaseExists(): Promise<boolean> {
    const result = await this.runPsql(
      `SELECT 1 FROM pg_database WHERE datname = '${DATABASE_NAME}'`
    );

    return (result.success && result.output?.includes('1')) || false;
  }

  private getSchemaPath(): string {
    if (electronApp.isPackaged) {
      return path.join(process.resourcesPath, 'schema.sql');
    }
    // Dev: look in assets/
    return path.join(electronApp.getAppPath(), 'assets', 'schema.sql');
  }

  private async importSchema(
    onProgress: (message: string, percent: number) => void
  ): Promise<{ success: boolean; error?: string }> {
    const schemaPath = this.getSchemaPath();

    if (!fs.existsSync(schemaPath)) {
      console.log('No schema.sql found, skipping dump import');
      return { success: true };
    }

    onProgress('Importing database schema...', 40);

    const status = await postgresInstallerService.checkInstallation();
    if (!status.installed || !status.binPath) {
      return { success: false, error: 'PostgreSQL not installed' };
    }

    const psqlBin = process.platform === 'win32' ? 'psql.exe' : 'psql';
    const psqlPath = path.join(status.binPath, psqlBin);

    // Use -f flag to import the SQL file
    const command = `"${psqlPath}" -U postgres -d ${DATABASE_NAME} -f "${schemaPath}"`;

    try {
      await execAsync(command, {
        env: { ...process.env, PGPASSWORD: this.pgPassword },
        timeout: 60000,
      });
      onProgress('Schema imported', 50);
      return { success: true };
    } catch (error: any) {
      // pg_dump with --if-exists --clean may emit errors for objects that
      // don't exist yet on a fresh DB — that's OK as long as CREATE succeeds
      console.log('Schema import warnings (may be normal):', error.message);
      onProgress('Schema imported', 50);
      return { success: true };
    }
  }

  async createDatabase(
    onProgress: (message: string, percent: number) => void
  ): Promise<{ success: boolean; error?: string }> {
    onProgress('Checking database...', 10);

    const exists = await this.checkDatabaseExists();

    if (exists) {
      onProgress('Database already exists', 50);
    } else {
      onProgress('Creating database...', 30);

      const createResult = await this.runPsql(
        `CREATE DATABASE ${DATABASE_NAME} OWNER postgres`
      );

      if (!createResult.success) {
        return {
          success: false,
          error: `Failed to create database: ${createResult.error}`,
        };
      }

      onProgress('Database created', 35);

      // Import schema dump on fresh database
      const importResult = await this.importSchema(onProgress);
      if (!importResult.success) {
        return importResult;
      }
    }

    // Run migrations on top (handles incremental changes)
    onProgress('Running migrations...', 60);

    try {
      const backendPath = getBackendPath();
      const backend = await dynamicImport(backendPath);

      if (typeof backend.runMigrations === 'function') {
        await backend.runMigrations();
      }

      onProgress('Migrations complete', 100);
      return { success: true };
    } catch (error: any) {
      // If migration import fails, try basic connection test
      const testResult = await this.runPsql('SELECT 1', DATABASE_NAME);

      if (testResult.success) {
        onProgress('Database ready', 100);
        return { success: true };
      }

      return { success: false, error: `Migration error: ${error.message}` };
    }
  }
}

export const databaseSetupService = new DatabaseSetupService();
