import { autoUpdater, UpdateInfo as ElectronUpdateInfo } from 'electron-updater';
import { BrowserWindow } from 'electron';
import { UpdateProgress, UpdateInfo } from '../../shared/types';
import { IPC_CHANNELS } from '../../shared/constants';

class UpdaterService {
  private targetWindow: BrowserWindow | null = null;
  private mainWindow: BrowserWindow | null = null;
  private updateInfo: UpdateInfo | null = null;
  private initialized = false;
  private updateAvailable = false;

  /**
   * Initialize with the main window. Call once on app start.
   */
  initialize(mainWindow: BrowserWindow): void {
    this.mainWindow = mainWindow;
    this.targetWindow = mainWindow;

    if (this.initialized) return;
    this.initialized = true;

    // Manual download, auto-install on quit if already downloaded
    autoUpdater.autoDownload = false;
    autoUpdater.autoInstallOnAppQuit = true;

    // Set GH_TOKEN for private repos
    const token = process.env.GH_TOKEN || process.env.GITHUB_TOKEN;
    if (token) {
      autoUpdater.requestHeaders = { Authorization: `token ${token}` };
    }

    autoUpdater.on('checking-for-update', () => {
      this.sendProgress({ status: 'checking', percent: 0 });
    });

    autoUpdater.on('update-available', (info: ElectronUpdateInfo) => {
      this.updateAvailable = true;
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

  /**
   * Set a different window to receive update progress events
   * (e.g., the dedicated update window).
   */
  setTargetWindow(window: BrowserWindow): void {
    this.targetWindow = window;
  }

  /**
   * Reset target back to main window (e.g., when update window closes).
   */
  resetTargetWindow(): void {
    this.targetWindow = this.mainWindow;
  }

  /**
   * Silent check on startup — only opens update window if update is available.
   */
  async silentCheckForUpdates(): Promise<void> {
    if (!this.mainWindow) return;

    try {
      const result = await autoUpdater.checkForUpdates();
      if (result?.updateInfo && result.updateInfo.version !== autoUpdater.currentVersion.version) {
        // Update available — the 'update-available' event handler will fire
        // and send progress to whatever window is currently targeted.
        // The caller (index.ts) can open the update window if needed.
      }
    } catch (error: any) {
      // Silent check — don't show errors to user
      console.log('Silent update check failed:', error.message);
    }
  }

  /**
   * Returns true if an update was found during the last check.
   */
  isUpdateAvailable(): boolean {
    return this.updateAvailable;
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
    const window = this.targetWindow || this.mainWindow;
    if (window && !window.isDestroyed()) {
      window.webContents.send(IPC_CHANNELS.UPDATE_PROGRESS, progress);
    }
  }
}

export const updaterService = new UpdaterService();
