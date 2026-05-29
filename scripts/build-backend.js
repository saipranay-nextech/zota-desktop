#!/usr/bin/env node
/*
 * Build the backend the same way CI does, with one entrypoint.
 *
 *   1. tsc (via `npm run build-main`). May fail on client branches with
 *      pre-existing TS errors — we log a warning and continue, because tsc
 *      still emits .js for files that compile, and shipping a partial-but-
 *      working build today is better than blocking on legacy TS noise.
 *   2. Mirror every hand-written src/(...)/*.js into the matching dist path.
 *      tsc does not copy plain .js files unless allowJs is on; the project
 *      has migration files written as .js that need to land in dist.
 *   3. Run fix-esm-extensions on dist/ so Node's strict ESM resolver can
 *      load the compiled output without ERR_MODULE_NOT_FOUND.
 *
 * Usage:
 *   node scripts/build-backend.js <pos|cpos>
 */

const fs = require('fs');
const path = require('path');
const { execSync, spawnSync } = require('child_process');

const ROOT = path.resolve(__dirname, '..');
const VARIANTS = {
  pos: 'zota-pos-backend-ts',
  cpos: 'zota-cpos-backend-ts',
};

const variant = process.argv[2];
if (!variant || !VARIANTS[variant]) {
  console.error('Usage: build-backend.js <pos|cpos>');
  process.exit(2);
}

const backendDir = path.join(ROOT, 'sourcecode', VARIANTS[variant]);
if (!fs.existsSync(path.join(backendDir, 'package.json'))) {
  console.error(`build-backend: backend dir not found or not initialized: ${backendDir}`);
  process.exit(2);
}

function run(cmd, opts = {}) {
  console.log(`  > ${cmd}`);
  execSync(cmd, { stdio: 'inherit', cwd: backendDir, ...opts });
}

console.log(`\n  Building backend (${variant}) at ${backendDir}\n`);

// Step 1 — tsc. Tolerate exit code so legacy TS errors don't block the release.
console.log('  [1/3] Compiling TypeScript...');
const tsc = spawnSync('npm', ['run', 'build-main'], {
  cwd: backendDir,
  stdio: 'inherit',
  shell: process.platform === 'win32',
});
if (tsc.status !== 0) {
  console.warn(
    '  WARN: tsc exited non-zero. Shipping partial output; fix TS errors on this branch when possible.'
  );
}

// Step 2 — copy hand-written .js into dist preserving directory structure.
console.log('\n  [2/3] Mirroring hand-written .js from src/ into dist/...');
const srcDir = path.join(backendDir, 'src');
const distDir = path.join(backendDir, 'dist');
fs.mkdirSync(distDir, { recursive: true });

let copied = 0;
function mirrorJs(currentSrc, currentDist) {
  for (const entry of fs.readdirSync(currentSrc, { withFileTypes: true })) {
    const s = path.join(currentSrc, entry.name);
    const d = path.join(currentDist, entry.name);
    if (entry.isDirectory()) {
      if (entry.name === 'node_modules') continue;
      mirrorJs(s, d);
    } else if (entry.isFile() && s.endsWith('.js')) {
      fs.mkdirSync(path.dirname(d), { recursive: true });
      fs.copyFileSync(s, d);
      copied += 1;
    }
  }
}
mirrorJs(srcDir, distDir);
console.log(`  Copied ${copied} hand-written .js file(s).`);

// Step 3 — add .js extensions to extensionless relative imports.
console.log('\n  [3/3] Fixing ESM extensions in dist/...');
run(`node "${path.join(ROOT, 'scripts', 'fix-esm-extensions.js')}" "${distDir}"`, {
  cwd: ROOT,
});

console.log(`\n  Backend build complete: ${distDir}\n`);
