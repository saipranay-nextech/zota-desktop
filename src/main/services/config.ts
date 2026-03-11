import * as path from 'path';
import * as fs from 'fs-extra';
import { app } from 'electron';
import { AppConfig } from '../../shared/types';
import { CONFIG_FILE_NAME } from '../../shared/constants';

const DEFAULT_CONFIG: AppConfig = {
  activated: false,
  customerId: '',
  customerName: '',
  activatedAt: null,
  version: '1.0.0',
};

class ConfigService {
  private config: AppConfig | null = null;
  private configPath: string;

  constructor() {
    this.configPath = path.join(app.getPath('userData'), CONFIG_FILE_NAME);
  }

  async load(): Promise<AppConfig> {
    if (this.config) {
      return this.config;
    }

    try {
      if (await fs.pathExists(this.configPath)) {
        const data = await fs.readJson(this.configPath);
        this.config = { ...DEFAULT_CONFIG, ...data };
      } else {
        this.config = { ...DEFAULT_CONFIG };
      }
    } catch (error) {
      console.error('Error loading config:', error);
      this.config = { ...DEFAULT_CONFIG };
    }

    return this.config!;
  }

  async save(updates: Partial<AppConfig>): Promise<void> {
    const current = await this.load();
    this.config = { ...current, ...updates };
    await fs.writeJson(this.configPath, this.config, { spaces: 2 });
  }

  async isActivated(): Promise<boolean> {
    const config = await this.load();
    return config.activated;
  }

  getConfigPath(): string {
    return this.configPath;
  }
}

export const configService = new ConfigService();
