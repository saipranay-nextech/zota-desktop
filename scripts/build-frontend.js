#!/usr/bin/env node
/*
 * Build the React frontend with the local-backend config baked in.
 *
 *   The frontend's src/redux/config.js sources the API base URL and the
 *   isAdmin flag. The committed values point at a production backend
 *   (https://admindev.nextechltd.in/api) and isAdmin = true. When the
 *   desktop app ships, that's wrong on every count — the bundled backend
 *   lives at http://localhost:8000/api and isAdmin must be false for the
 *   POS experience.
 *
 *   This script:
 *     1. Reads src/redux/config.js
 *     2. If `url`, `adminUrl`, or `isAdmin` don't match the expected local
 *        values, snapshots the file and rewrites them. If they already
 *        match, leaves the file alone (idempotent).
 *     3. Runs `npm run build`.
 *     4. Restores the original file. Always — on success, on tsc/webpack
 *        failure, and on SIGINT/SIGTERM via process signal handlers.
 *        This keeps the source-of-truth committed values intact so a
 *        developer's git working tree stays clean after every release.
 *
 * Usage:
 *   node scripts/build-frontend.js
 *
 * Why we don't just commit localhost URLs to the frontend repo:
 *   The frontend is used by both the cloud-hosted product (which points at
 *   the real API) and the desktop installer (which points at localhost).
 *   Whoever owns the cloud build cares about the committed values; the
 *   desktop release lane has to override them for its own builds without
 *   forcing a long-lived "installer-only" branch to carry the override.
 */

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const ROOT = path.resolve(__dirname, '..');
const FRONTEND_DIR = path.join(ROOT, 'sourcecode', 'zota-react-frontend');
const CONFIG_PATH = path.join(FRONTEND_DIR, 'src', 'redux', 'config.js');

const EXPECTED = {
  url: 'http://localhost:8000/api',
  adminUrl: 'http://localhost:8000/api',
  isAdmin: false,
};

if (!fs.existsSync(CONFIG_PATH)) {
  console.error(`\n  build-frontend: config not found at ${CONFIG_PATH}\n`);
  process.exit(1);
}

const original = fs.readFileSync(CONFIG_PATH, 'utf8');

// Parse the three exports out of the file with anchored regexes. We only
// rewrite top-level `export const <name> = ...;` lines (allowing leading
// whitespace), to avoid touching comments or matching `export const url`
// nested inside a string. Multiline arrays/objects aren't supported because
// the file holds simple string + boolean literals — see the file itself.
const PATTERNS = {
  url: /^(\s*export\s+const\s+url\s*=\s*)["'][^"']*["'](\s*;?\s*)$/m,
  adminUrl: /^(\s*export\s+const\s+adminUrl\s*=\s*)["'][^"']*["'](\s*;?\s*)$/m,
  isAdmin: /^(\s*export\s+const\s+isAdmin\s*=\s*)(?:true|false)(\s*;?\s*)$/m,
};

function currentValues(src) {
  const out = {};
  const urlMatch = src.match(/^\s*export\s+const\s+url\s*=\s*["']([^"']*)["']/m);
  const adminUrlMatch = src.match(/^\s*export\s+const\s+adminUrl\s*=\s*["']([^"']*)["']/m);
  const isAdminMatch = src.match(/^\s*export\s+const\s+isAdmin\s*=\s*(true|false)/m);
  if (urlMatch) out.url = urlMatch[1];
  if (adminUrlMatch) out.adminUrl = adminUrlMatch[1];
  if (isAdminMatch) out.isAdmin = isAdminMatch[1] === 'true';
  return out;
}

function rewrite(src) {
  let out = src;
  out = out.replace(PATTERNS.url, `$1"${EXPECTED.url}"$2`);
  out = out.replace(PATTERNS.adminUrl, `$1"${EXPECTED.adminUrl}"$2`);
  out = out.replace(PATTERNS.isAdmin, `$1${EXPECTED.isAdmin}$2`);
  return out;
}

console.log('\n  Building frontend (desktop variant)\n');

const before = currentValues(original);
console.log('  Current frontend config:');
console.log(`    url       = ${JSON.stringify(before.url)}`);
console.log(`    adminUrl  = ${JSON.stringify(before.adminUrl)}`);
console.log(`    isAdmin   = ${JSON.stringify(before.isAdmin)}`);

const matchesExpected =
  before.url === EXPECTED.url &&
  before.adminUrl === EXPECTED.adminUrl &&
  before.isAdmin === EXPECTED.isAdmin;

let restored = false;
function restore() {
  if (restored) return;
  restored = true;
  fs.writeFileSync(CONFIG_PATH, original);
  console.log('\n  Restored original frontend config.');
}

if (matchesExpected) {
  console.log('\n  Config already matches expected local-backend values. No rewrite needed.');
} else {
  const rewritten = rewrite(original);
  // Sanity-check: confirm every replacement actually landed. If a regex
  // didn't match, the post-rewrite parse will reveal it and we abort
  // BEFORE running the build, so we don't ship the wrong URL silently.
  const after = currentValues(rewritten);
  for (const key of Object.keys(EXPECTED)) {
    if (after[key] !== EXPECTED[key]) {
      console.error(
        `\n  build-frontend: rewrite of "${key}" did not land — expected ` +
        `${JSON.stringify(EXPECTED[key])}, got ${JSON.stringify(after[key])}.\n` +
        '  The config.js layout has probably drifted from what this script expects.\n' +
        '  Inspect src/redux/config.js manually and update PATTERNS in this script.\n'
      );
      process.exit(2);
    }
  }
  fs.writeFileSync(CONFIG_PATH, rewritten);
  console.log('\n  Rewrote config.js to local-backend values (will restore after build).');

  // Restore on any abnormal termination so the working tree never ends up
  // with the desktop values lingering when the user expects the committed
  // ones. Cover the common exit paths.
  process.on('SIGINT', () => { restore(); process.exit(130); });
  process.on('SIGTERM', () => { restore(); process.exit(143); });
  process.on('exit', restore);
}

// Run the actual build.
const build = spawnSync('npm', ['run', 'build'], {
  cwd: FRONTEND_DIR,
  stdio: 'inherit',
  env: {
    ...process.env,
    // Create React App turns ESLint warnings into errors when CI=true; the
    // frontend has many pre-existing warnings so we explicitly disable that
    // gating for desktop builds. Matches the CI release workflow.
    CI: 'false',
    DISABLE_ESLINT_PLUGIN: 'true',
  },
  shell: process.platform === 'win32',
});

// Restore happens via process.on('exit') above, but call explicitly so the
// log line ordering is sensible.
restore();

if (build.status !== 0) {
  console.error(`\n  Frontend build failed with exit code ${build.status}\n`);
  process.exit(build.status || 1);
}

console.log('\n  Frontend build complete.\n');
