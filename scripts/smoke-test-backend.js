#!/usr/bin/env node
/*
 * Smoke-test the built backend by importing dist/server.js with Node ESM.
 *
 * The goal is fast feedback on import errors (ERR_MODULE_NOT_FOUND etc.)
 * without needing PostgreSQL or a real environment. If the import chain
 * resolves cleanly, the test passes — any runtime failure that happens
 * AFTER imports complete (DB connection failure, missing env vars, etc.)
 * is treated as success for the purpose of this test.
 *
 * Usage:
 *   node scripts/smoke-test-backend.js <pos|cpos>
 *
 * Exit codes:
 *   0  imports resolved (or failed for non-resolution reasons)
 *   1  ERR_MODULE_NOT_FOUND or similar resolution failure
 *   2  bad arguments / missing dist
 */

const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');

const ROOT = path.resolve(__dirname, '..');
const VARIANTS = {
  pos: 'zota-pos-backend-ts',
  cpos: 'zota-cpos-backend-ts',
};

const variant = process.argv[2];
if (!variant || !VARIANTS[variant]) {
  console.error('Usage: smoke-test-backend.js <pos|cpos>');
  process.exit(2);
}

const backendDir = path.join(ROOT, 'sourcecode', VARIANTS[variant]);
const serverPath = path.join(backendDir, 'dist', 'server.js');
if (!fs.existsSync(serverPath)) {
  console.error(`smoke-test: dist/server.js missing — run build-backend.js first: ${serverPath}`);
  process.exit(2);
}

console.log(`\n  Smoke-testing ${path.relative(ROOT, serverPath)}\n`);

// We boot the backend just long enough to confirm imports resolve, then kill it.
// The backend may try to bind a port and connect to PostgreSQL — both can fail
// without invalidating the smoke test. The ONLY failure we care about is
// ERR_MODULE_NOT_FOUND (and friends), which means the build is shipping a
// broken import graph.
const env = {
  ...process.env,
  DB_HOST: process.env.DB_HOST || 'localhost',
  DB_USER: process.env.DB_USER || 'smoke',
  DB_PASSWORD: process.env.DB_PASSWORD || 'smoke',
  DB_NAME: process.env.DB_NAME || 'smoke',
  db_port: process.env.db_port || '5432',
  TOKEN_SECRET: process.env.TOKEN_SECRET || 'smoke',
  PORT: process.env.PORT || '0', // 0 = OS-assigned, won't collide with anything
};

const child = spawn(process.execPath, [serverPath], {
  cwd: backendDir,
  env,
});

const RESOLUTION_ERRORS = [
  'ERR_MODULE_NOT_FOUND',
  'ERR_UNSUPPORTED_DIR_IMPORT',
  'ERR_UNKNOWN_FILE_EXTENSION',
  'ERR_PACKAGE_PATH_NOT_EXPORTED',
];

let stderrBuf = '';
let stdoutBuf = '';
let resolved = false;

child.stdout.on('data', (chunk) => {
  const s = chunk.toString();
  stdoutBuf += s;
  process.stdout.write(s);
});

child.stderr.on('data', (chunk) => {
  const s = chunk.toString();
  stderrBuf += s;
  process.stderr.write(s);
});

// Give the import chain 5 seconds to either fail with a resolution error
// or get past it. If neither has happened, we assume imports succeeded.
const timer = setTimeout(() => {
  resolved = true;
  child.kill('SIGTERM');
}, 5000);

child.on('exit', (code, signal) => {
  clearTimeout(timer);
  const all = stderrBuf + '\n' + stdoutBuf;
  const hit = RESOLUTION_ERRORS.find((err) => all.includes(err));
  if (hit) {
    console.error(`\n  FAIL: ${hit} detected — the build is shipping a broken import graph.\n`);
    process.exit(1);
  }
  if (resolved || signal === 'SIGTERM') {
    console.log('\n  PASS: import chain resolved cleanly (process killed after 5s).\n');
    process.exit(0);
  }
  // Process exited on its own before timeout — could be a DB error, port issue, etc.
  // No resolution-error markers means imports were fine.
  console.log(`\n  PASS: imports resolved (process exited code=${code} signal=${signal} before timeout — not an ESM resolution failure).\n`);
  process.exit(0);
});
