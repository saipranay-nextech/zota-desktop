import * as path from 'path';
import { existsSync, readFileSync } from 'fs';
import { pathToFileURL } from 'url';
import { app } from 'electron';

interface VariantConfig {
  variant: string;
  appName: string;
  appId: string;
  backendDir: string;
  frontendDir: string;
}

let cachedVariant: VariantConfig | null = null;

/**
 * Reads variant.json to determine which backend/frontend to use.
 */
export function getVariantConfig(): VariantConfig {
  if (cachedVariant) return cachedVariant;

  // In packaged app, variant.json is bundled in dist/
  // In dev, it's written by scripts/zota.js into dist/
  const candidates = [
    path.join(__dirname, '..', '..', 'variant.json'),  // dist/variant.json from dist/main/main/
    path.join(__dirname, '..', '..', '..', 'dist', 'variant.json'),  // from src during dev
  ];

  for (const p of candidates) {
    if (existsSync(p)) {
      cachedVariant = JSON.parse(readFileSync(p, 'utf8'));
      return cachedVariant!;
    }
  }

  // Fallback: default to pos
  console.warn('variant.json not found, defaulting to POS variant');
  cachedVariant = {
    variant: 'pos',
    appName: 'Zota POS',
    appId: 'com.zota.pos',
    backendDir: 'sourcecode/zota-pos-backend-ts',
    frontendDir: 'sourcecode/zota-react-frontend/build',
  };
  return cachedVariant;
}

/**
 * Returns the file:// URL for the backend entry point.
 * Resolves from variant config instead of @zota/backend npm link.
 */
export function getBackendPath(): string {
  const config = getVariantConfig();

  // In packaged app: backend is in node_modules/@zota/backend (asar)
  // In dev: backend is in sourcecode/<variant>/dist/server.js
  let backendEntry: string;

  if (app.isPackaged) {
    backendEntry = require.resolve('@zota/backend');
  } else {
    // Walk up from dist/main/main/utils/ to zota-desktop root
    const desktopRoot = path.resolve(__dirname, '..', '..', '..', '..');
    backendEntry = path.join(desktopRoot, config.backendDir, 'dist', 'server.js');

    if (!existsSync(backendEntry)) {
      throw new Error(
        `Backend build not found at ${backendEntry}. Run: node scripts/zota.js check ${config.variant}`
      );
    }
  }

  return pathToFileURL(backendEntry).href;
}

/**
 * Returns the path to the frontend build directory.
 */
export function getFrontendPath(): string {
  const config = getVariantConfig();

  if (app.isPackaged) {
    return path.join(process.resourcesPath, 'frontend');
  }

  // Walk up from dist/main/main/utils/ to zota-desktop root
  const desktopRoot = path.resolve(__dirname, '..', '..', '..', '..');
  const frontendPath = path.join(desktopRoot, config.frontendDir);

  if (!existsSync(path.join(frontendPath, 'index.html'))) {
    throw new Error(
      `Frontend build not found at ${frontendPath}. Run: node scripts/zota.js check ${config.variant}`
    );
  }

  return frontendPath;
}
