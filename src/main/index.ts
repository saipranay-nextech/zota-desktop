import { app, BrowserWindow, ipcMain, globalShortcut, Menu } from 'electron';
import {
  createSetupWindow,
  createMainWindow,
  closeSetupWindow,
  createUpdateWindow,
  getMainWindow,
  getSetupWindow,
} from './window';
import { configService } from './services/config';
import { activationService } from './services/activation';
import { postgresInstallerService } from './services/postgres-installer';
import { databaseSetupService } from './services/database-setup';
import { backendRunnerService } from './services/backend-runner';
import { updaterService } from './services/updater';
import { IPC_CHANNELS, DATABASE_NAME } from '../shared/constants';
import { SetupProgress } from '../shared/types';

// Prevent multiple instances
const gotTheLock = app.requestSingleInstanceLock();

if (!gotTheLock) {
  app.quit();
} else {
  app.on('second-instance', () => {
    const mainWindow = getMainWindow();
    if (mainWindow) {
      if (mainWindow.isMinimized()) mainWindow.restore();
      mainWindow.focus();
    }
  });

  app.whenReady().then(async () => {
    registerIpcHandlers();
    await startApp();
  });
}

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('before-quit', async () => {
  await backendRunnerService.stop();
});

async function startApp(): Promise<void> {
  const config = await configService.load();

  // If setup was already completed before, do a quick launch
  // (skip setup window, just start backend directly)
  if (config.activated && config.setupComplete) {
    await quickLaunch();
    return;
  }

  // First-time setup: show setup window
  const setupWindow = createSetupWindow();

  await new Promise<void>((resolve) => {
    setupWindow.webContents.once('did-finish-load', resolve);
  });

  if (!config.activated) {
    // Will wait for activation via IPC
    return;
  }

  // Run full setup (PostgreSQL + Database + Backend)
  await runSetup(setupWindow);
}

async function quickLaunch(): Promise<void> {
  // Restore saved PostgreSQL password
  const config = await configService.load();
  if (config.pgPassword) {
    databaseSetupService.setPassword(config.pgPassword);
  }

  // Set DB env vars
  process.env.DB_HOST = 'localhost';
  process.env.DB_USER = 'postgres';
  process.env.DB_PASSWORD = databaseSetupService.getPassword();
  process.env.DB_NAME = DATABASE_NAME;
  process.env.db_port = '5432';

  // Start backend directly (skip migrations — already done)
  const backendResult = await backendRunnerService.start(
    (message, percent) => {
      console.log(`Backend: ${message} (${percent}%)`);
    }
  );

  if (!backendResult.success) {
    // If quick launch fails, fall back to full setup
    console.error('Quick launch failed, falling back to setup:', backendResult.error);
    await configService.save({ setupComplete: false });
    const setupWindow = createSetupWindow();
    await new Promise<void>((resolve) => {
      setupWindow.webContents.once('did-finish-load', resolve);
    });
    await runSetup(setupWindow);
    return;
  }

  // Open main window directly
  const mainWindow = createMainWindow();
  updaterService.initialize(mainWindow);
  setupMenu();
}

async function runSetup(setupWindow: BrowserWindow): Promise<void> {
  const sendProgress = (progress: SetupProgress) => {
    if (!setupWindow.isDestroyed()) {
      setupWindow.webContents.send(IPC_CHANNELS.SETUP_PROGRESS, progress);
    }
  };

  try {
    // Step 1: Check PostgreSQL
    sendProgress({ step: 'checking', message: 'Checking system...', percent: 5 });
    const pgStatus = await postgresInstallerService.checkInstallation();

    // Step 2: If PostgreSQL not found, prompt user to download
    if (!pgStatus.installed) {
      sendProgress({
        step: 'postgres-not-found',
        message: 'PostgreSQL is not installed. It is required for Zota CPOS.',
        percent: 5,
      });
      // Wait for user to confirm download via IPC
      return;
    }

    // Test connection with default password
    sendProgress({ step: 'checking', message: 'Testing database connection...', percent: 10 });
    const connTest = await databaseSetupService.testConnection();

    if (!connTest.success && connTest.authFailed) {
      // Password doesn't match — ask user
      sendProgress({
        step: 'postgres-password',
        message: 'PostgreSQL requires authentication. Please enter your PostgreSQL password.',
        percent: 10,
      });
      return;
    }

    // Continue with post-postgres setup
    await continueSetupAfterPostgres(setupWindow, sendProgress);
  } catch (error: any) {
    sendProgress({
      step: 'failed',
      message: error.message,
      percent: 0,
      error: error.message,
    });
  }
}

async function downloadAndInstallPostgres(
  setupWindow: BrowserWindow,
  sendProgress: (progress: SetupProgress) => void
): Promise<void> {
  try {
    // Download
    sendProgress({
      step: 'downloading-postgres',
      message: 'Downloading PostgreSQL...',
      percent: 10,
    });
    const downloadResult = await postgresInstallerService.download(
      (message, percent) => {
        sendProgress({
          step: 'downloading-postgres',
          message,
          percent: 10 + percent * 0.3,
        });
      }
    );

    if (!downloadResult.success || !downloadResult.installerPath) {
      sendProgress({
        step: 'failed',
        message: downloadResult.error || 'PostgreSQL download failed',
        percent: 0,
        error: downloadResult.error,
      });
      return;
    }

    // Install
    sendProgress({
      step: 'installing-postgres',
      message: 'Installing PostgreSQL...',
      percent: 40,
    });
    const installResult = await postgresInstallerService.install(
      downloadResult.installerPath,
      (message, percent) => {
        sendProgress({
          step: 'installing-postgres',
          message,
          percent: 40 + percent * 0.15,
        });
      }
    );

    if (!installResult.success) {
      sendProgress({
        step: 'failed',
        message: installResult.error || 'PostgreSQL installation failed',
        percent: 0,
        error: installResult.error,
      });
      return;
    }

    // Continue with rest of setup
    await continueSetupAfterPostgres(setupWindow, sendProgress);
  } catch (error: any) {
    sendProgress({
      step: 'failed',
      message: error.message,
      percent: 0,
      error: error.message,
    });
  }
}

async function continueSetupAfterPostgres(
  setupWindow: BrowserWindow,
  sendProgress: (progress: SetupProgress) => void
): Promise<void> {
  // Set DB env vars BEFORE any backend import
  process.env.DB_HOST = 'localhost';
  process.env.DB_USER = 'postgres';
  process.env.DB_PASSWORD = databaseSetupService.getPassword();
  process.env.DB_NAME = DATABASE_NAME;
  process.env.db_port = '5432';

  // Step 3: Create database (always runs)
  sendProgress({
    step: 'creating-database',
    message: 'Setting up database...',
    percent: 60,
  });
  const dbResult = await databaseSetupService.createDatabase(
    (message, percent) => {
      sendProgress({
        step: 'creating-database',
        message,
        percent: 60 + percent * 0.15,
      });
    }
  );

  if (!dbResult.success) {
    sendProgress({
      step: 'failed',
      message: dbResult.error || 'Database setup failed',
      percent: 0,
      error: dbResult.error,
    });
    return;
  }

  // Step 4: Start backend
  sendProgress({
    step: 'starting-backend',
    message: 'Starting application...',
    percent: 80,
  });
  const backendResult = await backendRunnerService.start(
    (message, percent) => {
      sendProgress({
        step: 'starting-backend',
        message,
        percent: 80 + percent * 0.15,
      });
    }
  );

  if (!backendResult.success) {
    sendProgress({
      step: 'failed',
      message: backendResult.error || 'Failed to start application',
      percent: 0,
      error: backendResult.error,
    });
    return;
  }

  // Step 5: Complete - save setup state and open main window
  await configService.save({
    setupComplete: true,
    pgPassword: databaseSetupService.getPassword(),
  });

  sendProgress({ step: 'complete', message: 'Ready!', percent: 100 });

  await new Promise((resolve) => setTimeout(resolve, 500));

  closeSetupWindow();
  const mainWindow = createMainWindow();
  updaterService.initialize(mainWindow);
  setupMenu();
}

function setupMenu(): void {
  globalShortcut.register('CommandOrControl+Shift+U', openUpdateWindow);

  const menuTemplate: Electron.MenuItemConstructorOptions[] = [
    {
      label: 'File',
      submenu: [
        {
          label: 'Print',
          accelerator: 'CommandOrControl+P',
          click: () => {
            const win = BrowserWindow.getFocusedWindow();
            if (win) win.webContents.executeJavaScript('window.print()');
          },
        },
        { type: 'separator' },
        { role: 'quit' },
      ],
    },
    {
      label: 'View',
      submenu: [
        { role: 'toggleDevTools', accelerator: 'F12' },
        { role: 'reload' },
        { type: 'separator' },
        { role: 'zoomIn' },
        { role: 'zoomOut' },
        { role: 'resetZoom' },
      ],
    },
    {
      label: 'Help',
      submenu: [
        {
          label: 'Check for Updates...',
          click: openUpdateWindow,
        },
        { type: 'separator' },
        {
          label: `Version ${app.getVersion()}`,
          enabled: false,
        },
      ],
    },
  ];

  Menu.setApplicationMenu(Menu.buildFromTemplate(menuTemplate));
}

function openUpdateWindow(): void {
  const updateWin = createUpdateWindow();
  updaterService.initialize(updateWin);
}

function registerIpcHandlers(): void {
  // Activation handlers
  ipcMain.handle(IPC_CHANNELS.IS_ACTIVATED, async () => {
    return activationService.isActivated();
  });

  ipcMain.handle(IPC_CHANNELS.ACTIVATE, async (_event, code: string) => {
    const result = await activationService.activate(code);

    if (result.success) {
      const setupWindow = getSetupWindow();
      if (setupWindow) {
        await runSetup(setupWindow);
      }
    }

    return result;
  });

  ipcMain.handle(IPC_CHANNELS.GET_CONFIG, async () => {
    return configService.load();
  });

  // Setup handlers
  ipcMain.handle(IPC_CHANNELS.GET_SETUP_STATUS, async () => {
    const pgStatus = await postgresInstallerService.checkInstallation();
    const dbExists = pgStatus.installed
      ? await databaseSetupService.checkDatabaseExists()
      : false;
    const backendRunning = backendRunnerService.isBackendRunning();

    return {
      needsSetup: !pgStatus.installed || !dbExists || !backendRunning,
      step: !pgStatus.installed
        ? 'postgres'
        : !dbExists
          ? 'database'
          : !backendRunning
            ? 'backend'
            : 'complete',
    };
  });

  ipcMain.handle(IPC_CHANNELS.START_SETUP, async () => {
    const setupWindow = getSetupWindow();
    if (setupWindow) {
      await runSetup(setupWindow);
    }
  });

  ipcMain.handle(IPC_CHANNELS.SUBMIT_POSTGRES_PASSWORD, async (_event, password: string) => {
    try {
      databaseSetupService.setPassword(password);

      const connTest = await databaseSetupService.testConnection();
      if (!connTest.success) {
        return { success: false, error: 'Invalid password. Please try again.' };
      }

      // Password works — continue setup
      const setupWindow = getSetupWindow();
      if (setupWindow) {
        const sendProgress = (progress: SetupProgress) => {
          if (!setupWindow.isDestroyed()) {
            setupWindow.webContents.send(IPC_CHANNELS.SETUP_PROGRESS, progress);
          }
        };
        await continueSetupAfterPostgres(setupWindow, sendProgress);
      }

      return { success: true };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  });

  ipcMain.handle(IPC_CHANNELS.CONFIRM_POSTGRES_DOWNLOAD, async () => {
    try {
      const setupWindow = getSetupWindow();
      if (setupWindow) {
        const sendProgress = (progress: SetupProgress) => {
          if (!setupWindow.isDestroyed()) {
            setupWindow.webContents.send(IPC_CHANNELS.SETUP_PROGRESS, progress);
          }
        };
        await downloadAndInstallPostgres(setupWindow, sendProgress);
      }
    } catch (error: any) {
      console.error('PostgreSQL download/install failed:', error);
    }
  });

  // Update handlers
  ipcMain.handle(IPC_CHANNELS.CHECK_UPDATE, async () => {
    await updaterService.checkForUpdates();
  });

  ipcMain.handle(IPC_CHANNELS.DOWNLOAD_UPDATE, async () => {
    await updaterService.downloadUpdate();
  });

  ipcMain.handle(IPC_CHANNELS.INSTALL_UPDATE, async () => {
    updaterService.installUpdate();
  });

  // App handlers
  ipcMain.handle(IPC_CHANNELS.GET_VERSION, () => {
    return app.getVersion();
  });

  ipcMain.handle(IPC_CHANNELS.QUIT_APP, () => {
    app.quit();
  });

  ipcMain.handle(IPC_CHANNELS.OPEN_UPDATE_WINDOW, () => {
    const updateWin = createUpdateWindow();
    updaterService.initialize(updateWin);
  });

  // Print handler — receives HTML from frontend and prints it
  ipcMain.on('print-html', (_event, htmlString: string) => {
    const printWindow = new BrowserWindow({
      width: 800,
      height: 600,
      show: false,
      webPreferences: {
        nodeIntegration: false,
        contextIsolation: true,
      },
    });

    printWindow.loadURL(`data:text/html;charset=utf-8,${encodeURIComponent(htmlString)}`);

    printWindow.webContents.on('did-finish-load', () => {
      // Use Chromium's print dialog (with preview) instead of system dialog
      printWindow.show();
      printWindow.webContents.executeJavaScript('window.print()');
      // Close window when print dialog is dismissed
      printWindow.webContents.on('did-finish-load', () => {
        printWindow.close();
      });
    });
  });
}
