#!/usr/bin/env node
/*
 * One-shot Mac dev bootstrap: make `npm run pos` Just Work.
 *
 * What it does:
 *   1. Verifies PostgreSQL is reachable at localhost:5432 as user "postgres"
 *      with password "postgres", and that database "customer" exists. If
 *      anything's missing, prints exact remediation steps and exits — does
 *      NOT silently try to fix infra it doesn't own.
 *   2. Writes a pre-activated config.json into Electron's userData dir so
 *      the app skips activation + setup windows and goes straight to
 *      quickLaunch() on `npm run pos`.
 *
 * Why it exists:
 *   The desktop wrapper auto-installs PG on Windows but expects an existing
 *   install elsewhere. The activation flow requires running the activation-
 *   code generator and pasting the result on every fresh launch. Together
 *   these turn a "run the app" loop into a 5-minute ceremony. This script
 *   collapses it.
 *
 * Usage:
 *   node scripts/dev-up.js
 *   npm run pos
 *
 * Teardown:
 *   node scripts/dev-down.js
 */

const { spawnSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const os = require('os');

const PG_USER = 'postgres';
const PG_PASS = 'postgres';
const PG_HOST = 'localhost';
const PG_PORT = '5432';
const DB_NAME = 'customer';

// Candidate psql locations — same set the desktop searches at runtime, so if
// we find it here the desktop will find it too.
const PSQL_CANDIDATES = [
  '/opt/homebrew/opt/postgresql@16/bin/psql',
  '/opt/homebrew/opt/postgresql@15/bin/psql',
  '/opt/homebrew/opt/postgresql@14/bin/psql',
  '/usr/local/opt/postgresql@16/bin/psql',
  '/usr/local/opt/postgresql@15/bin/psql',
  '/usr/local/opt/postgresql@14/bin/psql',
  '/Applications/Postgres.app/Contents/Versions/latest/bin/psql',
];

function findPsql() {
  for (const p of PSQL_CANDIDATES) {
    if (fs.existsSync(p)) return p;
  }
  const which = spawnSync('which', ['psql'], { encoding: 'utf8' });
  if (which.status === 0 && which.stdout.trim()) return which.stdout.trim();
  return null;
}

function psqlQuery(psql, db, sql) {
  return spawnSync(
    psql,
    ['-U', PG_USER, '-h', PG_HOST, '-p', PG_PORT, '-d', db, '-tAc', sql],
    { encoding: 'utf8', env: { ...process.env, PGPASSWORD: PG_PASS } }
  );
}

function fail(msg) {
  console.error(`\n  ${msg}\n`);
  process.exit(1);
}

console.log('\n  Zota dev bootstrap (Mac)\n');

// --- 1. Find psql ----------------------------------------------------------
const psql = findPsql();
if (!psql) {
  fail(
    'Could not find psql on this Mac. Install Postgres 15 with:\n' +
    '    brew install postgresql@15\n' +
    '    brew services start postgresql@15\n' +
    '  …then rerun this script.'
  );
}
console.log(`  Using psql at: ${psql}`);

// --- 2. Verify connection --------------------------------------------------
const ping = psqlQuery(psql, 'postgres', 'SELECT 1');
if (ping.status !== 0) {
  const auth = (ping.stderr || '').includes('password authentication failed');
  if (auth) {
    fail(
      'Postgres is reachable but the "postgres" user does not accept password "postgres".\n' +
      '  The desktop expects user=postgres password=postgres (POSTGRES_DEFAULT_PASSWORD).\n' +
      '  Either set that password on your existing role, or run a dedicated dev instance.\n' +
      '  Reset the password with (as a superuser):\n' +
      `    ${psql} -c "ALTER USER postgres WITH PASSWORD 'postgres';"`
    );
  }
  fail(
    `Postgres is not reachable at ${PG_HOST}:${PG_PORT} as user "postgres".\n` +
    `  psql said:\n${(ping.stderr || ping.stdout).trim().split('\n').map(l => '    ' + l).join('\n')}\n` +
    '  Start Postgres (e.g. `brew services start postgresql@15`) and rerun.'
  );
}
console.log('  PostgreSQL connection OK.');

// --- 3. Ensure the customer DB exists --------------------------------------
const dbCheck = psqlQuery(psql, 'postgres', `SELECT 1 FROM pg_database WHERE datname='${DB_NAME}'`);
if (dbCheck.status === 0 && dbCheck.stdout.trim() === '1') {
  console.log(`  Database "${DB_NAME}" exists.`);
} else {
  console.log(`  Creating database "${DB_NAME}"...`);
  const create = psqlQuery(psql, 'postgres', `CREATE DATABASE ${DB_NAME} OWNER ${PG_USER}`);
  if (create.status !== 0) {
    fail(`Failed to create database "${DB_NAME}":\n${create.stderr || create.stdout}`);
  }
}

// --- 4. Seed pre-activated config.json -------------------------------------
function userDataDir(appName) {
  if (process.platform === 'darwin') {
    return path.join(os.homedir(), 'Library', 'Application Support', appName);
  }
  if (process.platform === 'win32') {
    return path.join(process.env.APPDATA || path.join(os.homedir(), 'AppData', 'Roaming'), appName);
  }
  return path.join(process.env.XDG_CONFIG_HOME || path.join(os.homedir(), '.config'), appName);
}

// Electron's app.getName() returns package.json "name" for unpackaged dev
// runs and the productName from electron-builder.json for packaged builds.
// We seed both so the same script bootstraps every variant.
const SEED_APP_NAMES = [
  'zota-desktop',     // package.json name (dev mode)
  'Zota CPOS',        // default productName
  'Zota POS',
  'Zota Test POS',    // test client
  'Zota Demo POS',
];

const seed = {
  activated: true,
  customerId: 'DEV-MAC',
  customerName: 'Local Mac Dev',
  activatedAt: new Date().toISOString(),
  version: '1.0.0',
  setupComplete: true,
  pgPassword: PG_PASS,
};

for (const name of SEED_APP_NAMES) {
  const dir = userDataDir(name);
  fs.mkdirSync(dir, { recursive: true });
  fs.writeFileSync(path.join(dir, 'config.json'), JSON.stringify(seed, null, 2));
}
console.log(`  Seeded pre-activated config.json in ${SEED_APP_NAMES.length} userData dirs.`);

console.log(
  '\n  Done. Next:\n' +
  '    npm run smoke:pos   # 5-sec backend-imports check\n' +
  '    npm run pos         # full Electron app on Mac\n' +
  '\n  Teardown:\n' +
  '    node scripts/dev-down.js              # leaves DB intact\n' +
  '    node scripts/dev-down.js --wipe-config  # also removes seeded config\n'
);
