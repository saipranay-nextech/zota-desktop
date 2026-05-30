import { autoUpdater, UpdateInfo as ElectronUpdateInfo } from 'electron-updater';
import { BrowserWindow } from 'electron';
import { UpdateProgress, UpdateInfo } from '../../shared/types';
import { IPC_CHANNELS } from '../../shared/constants';
import { BUILD_TIME_UPDATE_TOKEN } from '../build-token';

// ------------------------------------------------------------
// Patch electron-updater's GitHubProvider so it works with private repos.
//
// In electron-updater 6.x, GitHubProvider.getLatestTagName intentionally
// hits the HTML route github.com/{owner}/{repo}/releases/latest (rather
// than api.github.com) to dodge rate limits. That route returns 404 on
// every private repo, regardless of whether the request is authenticated
// — verified against the test repo with a full-scope token. The result
// is that every "Check for Updates" against a private update repo fails
// with ERR_UPDATER_LATEST_VERSION_NOT_FOUND, even though the release
// exists and the token has access.
//
// This monkey-patch routes the request through api.github.com instead.
// The api endpoint honors the Authorization header set by autoUpdater
// .requestHeaders (where we put BUILD_TIME_UPDATE_TOKEN), so private
// repos resolve correctly. GitHub Enterprise hosts fall through to the
// original implementation because they already use the API path.
// ------------------------------------------------------------
const GitHubProviderModule = require('electron-updater/out/providers/GitHubProvider');
const GitHubProvider = GitHubProviderModule.GitHubProvider;
const originalGetLatestTagName = GitHubProvider.prototype.getLatestTagName;
GitHubProvider.prototype.getLatestTagName = async function (cancellationToken: unknown) {
  const opts = this.options;
  // Custom hosts (Enterprise) already use the API endpoint upstream.
  if (opts.host != null && opts.host !== 'github.com') {
    return originalGetLatestTagName.call(this, cancellationToken);
  }
  const apiUrl = new URL(`https://api.github.com/repos/${opts.owner}/${opts.repo}/releases/latest`);
  try {
    const rawData = await this.httpRequest(apiUrl, { Accept: 'application/json' }, cancellationToken);
    if (rawData == null) return null;
    return JSON.parse(rawData).tag_name;
  } catch (e: any) {
    throw new Error(
      `Unable to find latest version on GitHub (${apiUrl}): ${e.stack || e.message}`
    );
  }
};

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

    // Auth for private update repos.
    // Order: runtime env (dev/CI) > token baked into the build at release time.
    // In packaged customer builds env is empty so the baked token is what's used.
    const token =
      process.env.GH_TOKEN || process.env.GITHUB_TOKEN || BUILD_TIME_UPDATE_TOKEN;
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
