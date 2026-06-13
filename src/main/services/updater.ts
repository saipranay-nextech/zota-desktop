import { autoUpdater, UpdateInfo as ElectronUpdateInfo } from 'electron-updater';
import { BrowserWindow } from 'electron';
import { UpdateProgress, UpdateInfo } from '../../shared/types';
import { IPC_CHANNELS } from '../../shared/constants';
import { BUILD_TIME_UPDATE_TOKEN } from '../build-token';

// ------------------------------------------------------------
// Patch electron-updater's GitHubProvider so it works with private repos.
//
// In electron-updater 6.x, GitHubProvider uses github.com HTML routes
// throughout (both /releases/latest for the version check and
// /releases/download/{tag}/{file} for asset downloads) "to avoid API
// rate limits" per the upstream code comment. Those HTML routes return
// 404 on every private repo regardless of authentication — verified
// against the test repo with a full-scope token. Result: "Check for
// Updates" against any private update repo throws either
// ERR_UPDATER_LATEST_VERSION_NOT_FOUND or
// ERR_UPDATER_CHANNEL_FILE_NOT_FOUND, even though the release exists
// and the token has access.
//
// This monkey-patch routes everything through api.github.com:
//   1. getLatestTagName fetches the release via API and caches the
//      asset URL map on the provider instance.
//   2. getBaseDownloadPath returns the cached absolute API asset URL
//      when one exists for the requested filename. URL constructor
//      treats absolute URLs as-is, so the base github.com host is
//      effectively bypassed.
//   3. createRequestOptions adds Accept: application/octet-stream for
//      api.github.com asset URLs so GitHub responds with a 302 to the
//      signed download URL (the executor follows the redirect, strips
//      auth on the cross-domain hop, and pulls the actual bytes).
//
// GitHub Enterprise hosts fall through to the original implementation
// because they already use the API path correctly upstream.
// ------------------------------------------------------------
const GitHubProviderModule = require('electron-updater/out/providers/GitHubProvider');
const GitHubProvider = GitHubProviderModule.GitHubProvider;

const originalGetLatestTagName = GitHubProvider.prototype.getLatestTagName;
const originalGetBaseDownloadPath = GitHubProvider.prototype.getBaseDownloadPath;
const originalCreateRequestOptions = GitHubProvider.prototype.createRequestOptions;

GitHubProvider.prototype.getLatestTagName = async function (cancellationToken: unknown) {
  const opts = this.options;
  if (opts.host != null && opts.host !== 'github.com') {
    return originalGetLatestTagName.call(this, cancellationToken);
  }
  const apiUrl = new URL(`https://api.github.com/repos/${opts.owner}/${opts.repo}/releases/latest`);
  try {
    const rawData = await this.httpRequest(apiUrl, { Accept: 'application/json' }, cancellationToken);
    if (rawData == null) return null;
    const release = JSON.parse(rawData);
    // Cache the API asset URLs by filename so getBaseDownloadPath can
    // serve absolute URLs for latest.yml, the installer, and blockmap.
    const map: Record<string, string> = {};
    for (const asset of release.assets || []) {
      map[asset.name] = asset.url;
    }
    this._privateAssetUrlMap = map;
    return release.tag_name;
  } catch (e: any) {
    throw new Error(
      `Unable to find latest version on GitHub (${apiUrl}): ${e.stack || e.message}`
    );
  }
};

GitHubProvider.prototype.getBaseDownloadPath = function (tag: string, fileName: string) {
  const map = this._privateAssetUrlMap;
  if (map && map[fileName]) {
    // Returning an absolute URL — newUrlFromBase (new URL(input, base))
    // ignores the base when the input is absolute, so this effectively
    // routes the request to api.github.com.
    return map[fileName];
  }
  return originalGetBaseDownloadPath.call(this, tag, fileName);
};

GitHubProvider.prototype.createRequestOptions = function (url: URL, headers?: Record<string, string>) {
  // For api.github.com asset URLs, add Accept: application/octet-stream
  // so GitHub serves the file bytes (via 302 redirect to a signed S3
  // URL) instead of the JSON asset metadata.
  const isApiAssetUrl =
    url && url.host === 'api.github.com' && url.pathname.includes('/releases/assets/');
  if (isApiAssetUrl) {
    const merged = { ...(headers || {}), Accept: 'application/octet-stream' };
    return originalCreateRequestOptions.call(this, url, merged);
  }
  return originalCreateRequestOptions.call(this, url, headers);
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
