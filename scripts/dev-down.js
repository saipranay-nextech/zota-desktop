#!/usr/bin/env node
/*
 * Tear down the Mac dev environment. Does NOT touch Postgres — that's
 * yours to manage (Postgres.app, brew services, etc.). This only undoes
 * what dev-up.js created: the seeded config.json that bypassed activation.
 *
 * Usage:
 *   node scripts/dev-down.js              # no-op (dev-up only writes config)
 *   node scripts/dev-down.js --wipe-config
 */

const fs = require('fs');
const path = require('path');
const os = require('os');

const wipe = process.argv.includes('--wipe-config');

const SEED_APP_NAMES = [
  'zota-desktop',
  'Zota CPOS',
  'Zota POS',
  'Zota Test POS',
  'Zota Demo POS',
];

function userDataDir(appName) {
  if (process.platform === 'darwin') {
    return path.join(os.homedir(), 'Library', 'Application Support', appName);
  }
  if (process.platform === 'win32') {
    return path.join(process.env.APPDATA || path.join(os.homedir(), 'AppData', 'Roaming'), appName);
  }
  return path.join(process.env.XDG_CONFIG_HOME || path.join(os.homedir(), '.config'), appName);
}

if (wipe) {
  let removed = 0;
  for (const name of SEED_APP_NAMES) {
    const file = path.join(userDataDir(name), 'config.json');
    if (fs.existsSync(file)) {
      fs.unlinkSync(file);
      removed += 1;
    }
  }
  console.log(`\n  Removed ${removed} seeded config.json file(s).\n`);
} else {
  console.log(
    '\n  Nothing to do (dev-up only writes config files; Postgres is yours).\n' +
    '  To also remove the seeded configs: node scripts/dev-down.js --wipe-config\n'
  );
}
