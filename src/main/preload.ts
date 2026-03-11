import { contextBridge, ipcRenderer, IpcRendererEvent } from 'electron';
import { IPC_CHANNELS } from '../shared/constants';
import { SetupProgress, UpdateProgress, AppConfig } from '../shared/types';

contextBridge.exposeInMainWorld('electronAPI', {
  // Activation
  isActivated: (): Promise<boolean> =>
    ipcRenderer.invoke(IPC_CHANNELS.IS_ACTIVATED),

  activate: (code: string): Promise<{ success: boolean; error?: string }> =>
    ipcRenderer.invoke(IPC_CHANNELS.ACTIVATE, code),

  getConfig: (): Promise<AppConfig> =>
    ipcRenderer.invoke(IPC_CHANNELS.GET_CONFIG),

  // Setup
  getSetupStatus: (): Promise<{ needsSetup: boolean; step?: string }> =>
    ipcRenderer.invoke(IPC_CHANNELS.GET_SETUP_STATUS),

  startSetup: (): Promise<void> =>
    ipcRenderer.invoke(IPC_CHANNELS.START_SETUP),

  confirmPostgresDownload: (): Promise<void> =>
    ipcRenderer.invoke(IPC_CHANNELS.CONFIRM_POSTGRES_DOWNLOAD),

  submitPostgresPassword: (password: string): Promise<{ success: boolean; error?: string }> =>
    ipcRenderer.invoke(IPC_CHANNELS.SUBMIT_POSTGRES_PASSWORD, password),

  onSetupProgress: (
    callback: (progress: SetupProgress) => void
  ): (() => void) => {
    const handler = (_event: IpcRendererEvent, progress: SetupProgress) =>
      callback(progress);
    ipcRenderer.on(IPC_CHANNELS.SETUP_PROGRESS, handler);
    return () =>
      ipcRenderer.removeListener(IPC_CHANNELS.SETUP_PROGRESS, handler);
  },

  // Updates
  checkForUpdates: (): Promise<void> =>
    ipcRenderer.invoke(IPC_CHANNELS.CHECK_UPDATE),

  downloadUpdate: (): Promise<void> =>
    ipcRenderer.invoke(IPC_CHANNELS.DOWNLOAD_UPDATE),

  installUpdate: (): Promise<void> =>
    ipcRenderer.invoke(IPC_CHANNELS.INSTALL_UPDATE),

  onUpdateProgress: (
    callback: (progress: UpdateProgress) => void
  ): (() => void) => {
    const handler = (_event: IpcRendererEvent, progress: UpdateProgress) =>
      callback(progress);
    ipcRenderer.on(IPC_CHANNELS.UPDATE_PROGRESS, handler);
    return () =>
      ipcRenderer.removeListener(IPC_CHANNELS.UPDATE_PROGRESS, handler);
  },

  // App
  getVersion: (): Promise<string> =>
    ipcRenderer.invoke(IPC_CHANNELS.GET_VERSION),

  quitApp: (): Promise<void> => ipcRenderer.invoke(IPC_CHANNELS.QUIT_APP),
});

// TypeScript declaration for renderer
declare global {
  interface Window {
    electronAPI: {
      isActivated: () => Promise<boolean>;
      activate: (
        code: string
      ) => Promise<{ success: boolean; error?: string }>;
      getConfig: () => Promise<AppConfig>;
      getSetupStatus: () => Promise<{ needsSetup: boolean; step?: string }>;
      startSetup: () => Promise<void>;
      confirmPostgresDownload: () => Promise<void>;
      submitPostgresPassword: (password: string) => Promise<{ success: boolean; error?: string }>;
      onSetupProgress: (
        callback: (progress: SetupProgress) => void
      ) => () => void;
      checkForUpdates: () => Promise<void>;
      downloadUpdate: () => Promise<void>;
      installUpdate: () => Promise<void>;
      onUpdateProgress: (
        callback: (progress: UpdateProgress) => void
      ) => () => void;
      getVersion: () => Promise<string>;
      quitApp: () => Promise<void>;
    };
  }
}
