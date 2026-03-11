import { pathToFileURL } from 'url';

/**
 * Returns the file:// URL for @zota/backend entry point.
 * dynamic import() on Windows needs a file:// URL for ESM modules.
 */
export function getBackendPath(): string {
  const backendEntry = require.resolve('@zota/backend');
  return pathToFileURL(backendEntry).href;
}
