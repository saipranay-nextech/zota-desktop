import * as path from 'path';
import { app as electronApp } from 'electron';
import { BACKEND_PORT, BACKEND_URL, DATABASE_NAME } from '../../shared/constants';
import { databaseSetupService } from './database-setup';
import { getBackendPath } from '../utils/paths';

// Use Function constructor to preserve dynamic import() in CommonJS output
// TypeScript compiles import() to require() which can't load ES modules
const dynamicImport = new Function('specifier', 'return import(specifier)') as (specifier: string) => Promise<any>;

interface BackendInstance {
  httpServer: any;
  io: any;
  app: any;
}

class BackendRunnerService {
  private instance: BackendInstance | null = null;
  private isRunning = false;

  async start(
    onProgress: (message: string, percent: number) => void
  ): Promise<{ success: boolean; error?: string }> {
    if (this.isRunning) {
      return { success: true };
    }

    // If instance exists from a previous failed attempt, the server is already
    // listening but health check failed. Just retry the health check.
    if (this.instance) {
      onProgress('Retrying health check...', 70);
      console.log('Backend instance already exists, retrying health check...');
      const isReady = await this.waitForReady(30000);
      if (isReady) {
        this.isRunning = true;
        onProgress('Backend server running', 100);
        return { success: true };
      }
      return {
        success: false,
        error: 'Backend started but health check failed on retry',
      };
    }

    onProgress('Starting backend server...', 10);

    // Set DB env vars so backend can connect
    process.env.DB_HOST = 'localhost';
    process.env.DB_USER = 'postgres';
    process.env.DB_PASSWORD = databaseSetupService.getPassword();
    process.env.DB_NAME = DATABASE_NAME;
    process.env.db_port = '5432';

    try {
      const backendPath = getBackendPath();
      const backend = await dynamicImport(backendPath);

      if (typeof backend.startServer !== 'function') {
        return {
          success: false,
          error: 'Backend does not export startServer function',
        };
      }

      onProgress('Initializing Express server...', 30);

      this.instance = await backend.startServer({ port: BACKEND_PORT });

      // Serve frontend build through the backend's Express app
      // so the page has an HTTP origin (file:// breaks Razorpay, fetch, etc.)
      // In packaged app: frontend is in extraResources/frontend
      // In dev: find project root by looking for package.json up from __dirname
      let frontendPath: string;
      if (electronApp.isPackaged) {
        frontendPath = path.join(process.resourcesPath, 'frontend');
      } else {
        // __dirname is dist/main/main/services, walk up to zota-desktop/
        const desktopRoot = path.resolve(__dirname, '..', '..', '..', '..');
        frontendPath = path.join(desktopRoot, '..', 'zota-react-frontend', 'build');
      }

      // Remove backend's catch-all "Page not found" middleware FIRST
      // before registering any new routes/middleware
      const stack = this.instance!.app._router?.stack;
      if (stack && stack.length > 0) {
        const lastLayer = stack[stack.length - 1];
        if (!lastLayer.route && lastLayer.name !== 'router') {
          stack.pop();
        }
      }

      // API endpoint to get app version
      this.instance!.app.get('/api/desktop/version', (_req: any, res: any) => {
        res.json({
          version: electronApp.getVersion(),
          name: electronApp.getName(),
        });
      });

      // Resolve express from backend's node_modules (it's not hoisted to top level)
      const backendDir = path.dirname(require.resolve('@zota/backend'));
      const expressPath = require.resolve('express', { paths: [backendDir] });
      const express = require(expressPath);
      this.instance!.app.use(express.static(frontendPath));

      // Catch-all for React Router — only for non-API routes
      // Inject a script that patches hardcoded localhost URLs to use actual origin
      // so LAN clients (http://192.168.x.x:8000) work without frontend code changes
      const fs = require('fs');
      const indexHtml = fs.readFileSync(path.join(frontendPath, 'index.html'), 'utf8');
      // This script runs before React loads and:
      // 1. Sets localIP in localStorage so Socket.io connects to LAN IP
      // 2. Sets window.__API_ORIGIN__ so we can patch axios after it loads
      const lanPatchScript = `<script>
        (function() {
          var origin = window.location.origin;
          if (origin !== 'http://localhost:8000') {
            localStorage.setItem('localIP', window.location.hostname);
            window.__API_ORIGIN__ = origin;
          } else {
            localStorage.removeItem('localIP');
          }
          // Sanitize: if localIP was set to "undefined" or empty by backend, remove it
          var lip = localStorage.getItem('localIP');
          if (!lip || lip === 'undefined' || lip === 'null' || lip === '') {
            localStorage.removeItem('localIP');
          }
          // Patch Storage.setItem to prevent "undefined" from being stored as localIP
          var origSetItem = Storage.prototype.setItem;
          Storage.prototype.setItem = function(key, value) {
            if (key === 'localIP' && (!value || value === 'undefined' || value === 'null')) {
              return;
            }
            return origSetItem.call(this, key, value);
          };
        })();
      </script>`;
      // This script runs after React bundle and patches axios baseURL
      const axiosPatchScript = `<script>
        (function patchAxios() {
          if (!window.__API_ORIGIN__) return;
          var origin = window.__API_ORIGIN__;
          // Poll until axios instances are available on the module scope
          var interval = setInterval(function() {
            // axios stores defaults on each instance; patch via interceptor
            if (window.__axios_patched__) { clearInterval(interval); return; }
            try {
              // Patch XMLHttpRequest.open to rewrite localhost URLs
              var origOpen = XMLHttpRequest.prototype.open;
              XMLHttpRequest.prototype.open = function(method, url) {
                if (typeof url === 'string' && url.indexOf('http://localhost:8000') === 0) {
                  url = url.replace('http://localhost:8000', origin);
                }
                return origOpen.apply(this, [method, url].concat(Array.prototype.slice.call(arguments, 2)));
              };
              window.__axios_patched__ = true;
              clearInterval(interval);
            } catch(e) {}
          }, 50);
        })();
      </script>`;
      const patchedHtml = indexHtml
        .replace('<head>', '<head>' + lanPatchScript)
        .replace('</body>', axiosPatchScript + '</body>');

      this.instance!.app.get('*', (req: any, res: any) => {
        if (req.path.startsWith('/api/') || req.path.startsWith('/socket.io/')) {
          return res.status(404).json({ error: 'Not found' });
        }
        res.type('html').send(patchedHtml);
      });

      onProgress('Waiting for server to be ready...', 70);

      // Server is already listening (startServer resolved), mark as running.
      // Do a quick health check but don't fail hard — the server IS up.
      this.isRunning = true;
      const isReady = await this.waitForReady(15000);

      if (!isReady) {
        console.warn('Health check did not pass, but server is listening. Continuing anyway.');
      }

      onProgress('Backend server running', 100);

      return { success: true };
    } catch (error: any) {
      console.error('Failed to start backend:', error);
      return {
        success: false,
        error: `Failed to start backend: ${error.message}`,
      };
    }
  }

  private async waitForReady(timeout: number): Promise<boolean> {
    const startTime = Date.now();
    const healthUrl = `${BACKEND_URL}/health`;

    while (Date.now() - startTime < timeout) {
      try {
        const response = await fetch(healthUrl);
        console.log(`Health check: ${response.status}`);
        if (response.ok) {
          return true;
        }
      } catch (err: any) {
        console.log(`Health check error: ${err.message}`);
      }

      await new Promise((resolve) => setTimeout(resolve, 500));
    }

    return false;
  }

  async stop(): Promise<void> {
    if (this.instance?.httpServer) {
      await new Promise<void>((resolve) => {
        const timeout = setTimeout(() => {
          console.log('Backend stop timed out, forcing shutdown');
          this.isRunning = false;
          this.instance = null;
          resolve();
        }, 5000);

        // Close all open connections so .close() callback fires
        if (this.instance!.httpServer.closeAllConnections) {
          this.instance!.httpServer.closeAllConnections();
        }

        this.instance!.httpServer.close(() => {
          clearTimeout(timeout);
          this.isRunning = false;
          this.instance = null;
          resolve();
        });
      });
    }
  }

  isBackendRunning(): boolean {
    return this.isRunning;
  }
}

export const backendRunnerService = new BackendRunnerService();
