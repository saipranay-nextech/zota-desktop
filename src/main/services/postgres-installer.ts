import * as path from 'path';
import * as fs from 'fs-extra';
import * as https from 'https';
import { exec, spawn } from 'child_process';
import { promisify } from 'util';
import { app } from 'electron';
import { POSTGRES_PATHS, POSTGRES_DOWNLOAD_URL } from '../../shared/constants';

const execAsync = promisify(exec);

export interface PostgresStatus {
  installed: boolean;
  binPath: string | null;
  version: string | null;
}

class PostgresInstallerService {
  private downloadDir: string;

  constructor() {
    this.downloadDir = path.join(app.getPath('temp'), 'zota-postgres');
  }

  async checkInstallation(): Promise<PostgresStatus> {
    for (const binPath of POSTGRES_PATHS) {
      const psqlBin = process.platform === 'win32' ? 'psql.exe' : 'psql';
      const psqlPath = path.join(binPath, psqlBin);

      if (await fs.pathExists(psqlPath)) {
        try {
          const { stdout } = await execAsync(`"${psqlPath}" --version`);
          const versionMatch = stdout.match(/psql \(PostgreSQL\) (\d+\.\d+)/);
          return {
            installed: true,
            binPath,
            version: versionMatch ? versionMatch[1] : 'unknown',
          };
        } catch {
          return { installed: true, binPath, version: null };
        }
      }
    }

    return { installed: false, binPath: null, version: null };
  }

  async download(
    onProgress: (message: string, percent: number) => void
  ): Promise<{ success: boolean; installerPath?: string; error?: string }> {
    await fs.ensureDir(this.downloadDir);
    const installerPath = path.join(this.downloadDir, 'postgresql-installer.exe');

    // If already downloaded, skip
    if (await fs.pathExists(installerPath)) {
      const stats = await fs.stat(installerPath);
      if (stats.size > 100 * 1024 * 1024) {
        // > 100MB means likely complete
        onProgress('PostgreSQL installer already downloaded', 100);
        return { success: true, installerPath };
      }
      // Incomplete download, remove and retry
      await fs.remove(installerPath);
    }

    onProgress('Downloading PostgreSQL...', 0);

    return new Promise((resolve) => {
      const followRedirect = (url: string) => {
        https.get(url, (response) => {
          if (response.statusCode === 301 || response.statusCode === 302) {
            const redirectUrl = response.headers.location;
            if (redirectUrl) {
              followRedirect(redirectUrl);
            } else {
              resolve({ success: false, error: 'Redirect without location header' });
            }
            return;
          }

          if (response.statusCode !== 200) {
            resolve({ success: false, error: `Download failed with status ${response.statusCode}` });
            return;
          }

          const totalSize = parseInt(response.headers['content-length'] || '0', 10);
          let downloadedSize = 0;
          const file = fs.createWriteStream(installerPath);

          response.on('data', (chunk: Buffer) => {
            downloadedSize += chunk.length;
            if (totalSize > 0) {
              const percent = Math.round((downloadedSize / totalSize) * 100);
              const mb = (downloadedSize / 1024 / 1024).toFixed(0);
              const totalMb = (totalSize / 1024 / 1024).toFixed(0);
              onProgress(`Downloading PostgreSQL... ${mb}/${totalMb} MB`, percent);
            }
          });

          response.pipe(file);

          file.on('finish', () => {
            file.close();
            onProgress('Download complete', 100);
            resolve({ success: true, installerPath });
          });

          file.on('error', (err) => {
            fs.removeSync(installerPath);
            resolve({ success: false, error: `File write error: ${err.message}` });
          });
        }).on('error', (err) => {
          if (fs.existsSync(installerPath)) fs.removeSync(installerPath);
          resolve({ success: false, error: `Download error: ${err.message}` });
        });
      };

      followRedirect(POSTGRES_DOWNLOAD_URL);
    });
  }

  async install(
    installerPath: string,
    onProgress: (message: string, percent: number) => void
  ): Promise<{ success: boolean; error?: string }> {
    if (!(await fs.pathExists(installerPath))) {
      return {
        success: false,
        error: 'PostgreSQL installer not found.',
      };
    }

    onProgress('Starting PostgreSQL installation...', 10);

    return new Promise((resolve) => {
      const args = [
        '--mode', 'unattended',
        '--unattendedmodeui', 'minimal',
        '--superpassword', 'postgres',
        '--servicename', 'postgresql-14',
        '--servicepassword', 'postgres',
      ];

      const installer = spawn(installerPath, args, {
        stdio: 'pipe',
      });

      let progressPercent = 10;
      const progressInterval = setInterval(() => {
        if (progressPercent < 90) {
          progressPercent += 5;
          onProgress('Installing PostgreSQL...', progressPercent);
        }
      }, 3000);

      installer.on('close', async (code) => {
        clearInterval(progressInterval);

        if (code === 0) {
          onProgress('PostgreSQL installation complete', 100);

          // Clean up downloaded installer
          try {
            await fs.remove(this.downloadDir);
          } catch {
            // ignore cleanup errors
          }

          const status = await this.checkInstallation();
          if (status.installed) {
            resolve({ success: true });
          } else {
            resolve({
              success: false,
              error: 'Installation completed but PostgreSQL not found',
            });
          }
        } else {
          resolve({
            success: false,
            error: `Installation failed with exit code ${code}`,
          });
        }
      });

      installer.on('error', (err) => {
        clearInterval(progressInterval);
        resolve({
          success: false,
          error: `Installation error: ${err.message}`,
        });
      });
    });
  }
}

export const postgresInstallerService = new PostgresInstallerService();
