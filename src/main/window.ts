import { app, BrowserWindow, screen } from 'electron';
import * as path from 'path';

const isDev = !app.isPackaged;

let mainWindow: BrowserWindow | null = null;
let setupWindow: BrowserWindow | null = null;
let updateWindow: BrowserWindow | null = null;

export function createSetupWindow(): BrowserWindow {
  const preloadPath = path.join(__dirname, 'preload.js');
  const htmlPath = path.join(__dirname, '../../renderer/index.html');

  setupWindow = new BrowserWindow({
    width: 500,
    height: 400,
    resizable: false,
    center: true,
    frame: false,
    transparent: false,
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      preload: preloadPath,
    },
  });

  if (isDev) {
    setupWindow.webContents.openDevTools({ mode: 'detach' });
  }

  // Always load built HTML file (no dev server needed)
  setupWindow.loadFile(htmlPath);

  setupWindow.on('closed', () => {
    setupWindow = null;
  });

  return setupWindow;
}

export function createMainWindow(): BrowserWindow {
  const { width, height } = screen.getPrimaryDisplay().workAreaSize;

  mainWindow = new BrowserWindow({
    width,
    height,
    show: false,
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      preload: path.join(__dirname, 'preload.js'),
    },
  });

  mainWindow.setMenuBarVisibility(false);

  const backendUrl = 'http://localhost:8000';
  let totalRetries = 0;
  const MAX_TOTAL_RETRIES = 5;

  const loadApp = () => {
    if (!mainWindow || mainWindow.isDestroyed()) return;
    if (totalRetries >= MAX_TOTAL_RETRIES) {
      console.error('Max retries reached, giving up.');
      return;
    }
    totalRetries++;

    const url = isDev ? 'http://localhost:3000' : backendUrl;

    mainWindow.loadURL(url).catch(() => {
      if (isDev) {
        mainWindow?.loadURL(backendUrl).catch(() => {
          setTimeout(() => loadApp(), 2000);
        });
      } else {
        console.log(`Failed to load, retrying in 2s... (${MAX_TOTAL_RETRIES - totalRetries} left)`);
        setTimeout(() => loadApp(), 2000);
      }
    });
  };

  loadApp();

  // Detect page load failure and retry (with global limit)
  mainWindow.webContents.on('did-fail-load', (_event, errorCode, errorDescription) => {
    console.error(`Page load failed: ${errorCode} ${errorDescription}`);
    if (mainWindow && !mainWindow.isDestroyed()) {
      setTimeout(() => loadApp(), 2000);
    }
  });

  // Detect blank page and retry once
  let blankRetried = false;
  mainWindow.webContents.on('did-finish-load', () => {
    if (!mainWindow || mainWindow.isDestroyed() || blankRetried) return;
    mainWindow.webContents.executeJavaScript(
      `document.body ? document.body.innerHTML.trim().length : -1`
    ).then((length: number) => {
      if (length === 0) {
        console.log('Blank page detected, reloading once...');
        blankRetried = true;
        setTimeout(() => loadApp(), 2000);
      }
    }).catch(() => {});
  });

  mainWindow.once('ready-to-show', () => {
    mainWindow?.show();
  });

  mainWindow.on('closed', () => {
    mainWindow = null;
  });

  return mainWindow;
}

export function getMainWindow(): BrowserWindow | null {
  return mainWindow;
}

export function getSetupWindow(): BrowserWindow | null {
  return setupWindow;
}

export function closeSetupWindow(): void {
  if (setupWindow && !setupWindow.isDestroyed()) {
    setupWindow.close();
    setupWindow = null;
  }
}

export function createUpdateWindow(): BrowserWindow {
  // If already open, just focus it
  if (updateWindow && !updateWindow.isDestroyed()) {
    updateWindow.focus();
    return updateWindow;
  }

  const preloadPath = path.join(__dirname, 'preload.js');
  const htmlPath = path.join(__dirname, '../../renderer/update.html');

  updateWindow = new BrowserWindow({
    width: 450,
    height: 350,
    resizable: false,
    center: true,
    parent: mainWindow || undefined,
    modal: false,
    title: 'Software Updates',
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      preload: preloadPath,
    },
  });

  updateWindow.setMenuBarVisibility(false);
  updateWindow.loadFile(htmlPath);

  updateWindow.on('closed', () => {
    updateWindow = null;
  });

  return updateWindow;
}

export function getUpdateWindow(): BrowserWindow | null {
  return updateWindow;
}
