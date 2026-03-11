import { autoUpdater, UpdateInfo as ElectronUpdateInfo } from 'electron-updater';
import { BrowserWindow } from 'electron';
import { UpdateProgress, UpdateInfo } from '../../shared/types';
import { IPC_CHANNELS } from '../../shared/constants';

class UpdaterService {
  private mainWindow: BrowserWindow | null = null;
  private updateInfo: UpdateInfo | null = null;
  private initialized = false;

  initialize(mainWindow: BrowserWindow): void {
    this.mainWindow = mainWindow;

    // Only register listeners once to prevent accumulation
    if (this.initialized) return;
    this.initialized = true;

    // Configure auto-updater - manual only
    autoUpdater.autoDownload = false;
    autoUpdater.autoInstallOnAppQuit = false;

    autoUpdater.on('checking-for-update', () => {
      this.sendProgress({ status: 'checking', percent: 0 });
    });

    autoUpdater.on('update-available', (info: ElectronUpdateInfo) => {
      this.updateInfo = {
        version: info.version,
        releaseNotes:
          typeof info.releaseNotes === 'string'
            ? info.releaseNotes
            : 'No release notes available',
        releaseDate: info.releaseDate || new Date().toISOString(),
      };
      this.sendProgress({
        status: 'available',
        percent: 0,
        updateInfo: this.updateInfo,
      });
    });

    autoUpdater.on('update-not-available', () => {
      this.sendProgress({ status: 'idle', percent: 0 });
    });

    autoUpdater.on('download-progress', (progress) => {
      this.sendProgress({
        status: 'downloading',
        percent: Math.round(progress.percent),
        updateInfo: this.updateInfo || undefined,
      });
    });

    autoUpdater.on('update-downloaded', () => {
      this.sendProgress({
        status: 'downloaded',
        percent: 100,
        updateInfo: this.updateInfo || undefined,
      });
    });

    autoUpdater.on('error', (error) => {
      this.sendProgress({
        status: 'error',
        percent: 0,
        error: error.message,
      });
    });
  }

  async checkForUpdates(): Promise<void> {
    try {
      await autoUpdater.checkForUpdates();
    } catch (error: any) {
      this.sendProgress({
        status: 'error',
        percent: 0,
        error: error.message,
      });
    }
  }

  async downloadUpdate(): Promise<void> {
    try {
      await autoUpdater.downloadUpdate();
    } catch (error: any) {
      this.sendProgress({
        status: 'error',
        percent: 0,
        error: error.message,
      });
    }
  }

  installUpdate(): void {
    autoUpdater.quitAndInstall(false, true);
  }

  private sendProgress(progress: UpdateProgress): void {
    if (this.mainWindow && !this.mainWindow.isDestroyed()) {
      this.mainWindow.webContents.send(IPC_CHANNELS.UPDATE_PROGRESS, progress);
    }
  }
}

export const updaterService = new UpdaterService();
