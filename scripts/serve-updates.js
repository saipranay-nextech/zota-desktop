#!/usr/bin/env node
/*
 * Local update server for testing electron-updater without publishing to
 * GitHub. Serves whatever's in release/ (or a custom dir) over HTTP.
 *
 *   The packaged app, when configured via dev-app-update.yml to point at
 *   http://localhost:8765, will:
 *     1. fetch /latest-mac.yml (or latest.yml / latest-linux.yml)
 *     2. compare its version against app.getVersion()
 *     3. if newer, download the artifact referenced by that yml
 *     4. run the install on quit (or now, via the UI button)
 *
 *   Typical loop:
 *     1. Build app v1.0.0:  npm run dist:mac  (or dist:pos on Windows)
 *     2. Install it
 *     3. Bump version, build v1.0.1
 *     4. node scripts/serve-updates.js
 *     5. Open the installed v1.0.0 — it'll see v1.0.1 and offer to update.
 *
 * Usage:
 *   node scripts/serve-updates.js              # serves ./release on :8765
 *   node scripts/serve-updates.js --dir <dir> --port <n>
 */

const http = require('http');
const fs = require('fs');
const path = require('path');

const args = process.argv.slice(2);
const argMap = {};
for (let i = 0; i < args.length; i += 2) argMap[args[i]] = args[i + 1];

const dir = path.resolve(argMap['--dir'] || 'release');
const port = parseInt(argMap['--port'] || '8765', 10);

if (!fs.existsSync(dir)) {
  console.error(`  Update directory does not exist: ${dir}`);
  console.error('  Run a build first (e.g. `npx electron-builder --mac --publish=never`).');
  process.exit(1);
}

const MIME = {
  '.yml': 'text/yaml',
  '.yaml': 'text/yaml',
  '.json': 'application/json',
  '.exe': 'application/octet-stream',
  '.msi': 'application/octet-stream',
  '.dmg': 'application/octet-stream',
  '.zip': 'application/zip',
  '.blockmap': 'application/octet-stream',
  '.AppImage': 'application/octet-stream',
};

const server = http.createServer((req, res) => {
  // Strip query string; electron-updater appends cache-busters
  const urlPath = decodeURIComponent((req.url || '/').split('?')[0]);
  const filePath = path.join(dir, urlPath);

  // Defense against path traversal
  if (!filePath.startsWith(dir)) {
    res.writeHead(403);
    res.end('Forbidden');
    return;
  }

  fs.stat(filePath, (err, stat) => {
    if (err || !stat.isFile()) {
      console.log(`  404 ${urlPath}`);
      res.writeHead(404);
      res.end('Not found');
      return;
    }
    const ext = path.extname(filePath).toLowerCase();
    res.writeHead(200, {
      'Content-Type': MIME[ext] || 'application/octet-stream',
      'Content-Length': stat.size,
      'Cache-Control': 'no-store',
    });
    console.log(`  200 ${urlPath} (${stat.size} bytes)`);
    fs.createReadStream(filePath).pipe(res);
  });
});

server.listen(port, () => {
  console.log(`\n  Serving ${dir} at http://localhost:${port}\n`);
  console.log('  Make sure dev-app-update.yml points at this URL:');
  console.log('    provider: generic');
  console.log(`    url: http://localhost:${port}`);
  console.log('\n  Ctrl+C to stop.\n');
});
