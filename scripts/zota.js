#!/usr/bin/env node

/**
 * Zota Desktop CLI
 *
 * Usage:
 *   node scripts/zota.js <command> [variant]
 *
 * Commands:
 *   run <pos|cpos>       — Preflight check + build desktop + run Electron
 *   build <pos|cpos>     — Preflight check + build desktop app
 *   dist <pos|cpos>      — Preflight check + build + package MSI installer
 *   check <pos|cpos>     — Run preflight checks only
 *   setup                — Initialize submodules + install all deps
 *
 * Examples:
 *   node scripts/zota.js run pos
 *   node scripts/zota.js dist cpos
 *   node scripts/zota.js setup
 */

const { execSync, spawn } = require('child_process');
const fs = require('fs');
const path = require('path');
const { loadClientConfig } = require('./lib/load-client-config');
const { withTemporaryVersion } = require('./lib/temp-version');

const ROOT = path.resolve(__dirname, '..');

const VARIANTS = {
  pos: {
    backendDir: 'zota-pos-backend-ts',
    appName: 'Zota POS',
    appId: 'com.zota.pos',
  },
  cpos: {
    backendDir: 'zota-cpos-backend-ts',
    appName: 'Zota CPOS',
    appId: 'com.zota.cpos',
  },
};

const command = process.argv[2];
let variant = process.argv[3];

function flagValue(name) {
  const idx = process.argv.indexOf(name);
  return idx !== -1 ? process.argv[idx + 1] : null;
}
function flagPresent(name) {
  return process.argv.includes(name);
}

const clientConfigPath = flagValue('--client');
const versionOverride = flagValue('--version');
const shouldPublish = flagPresent('--publish');

let _cachedClientConfig = undefined;
function getClientConfig() {
  if (!clientConfigPath) return null;
  if (_cachedClientConfig === undefined) {
    _cachedClientConfig = loadClientConfig(clientConfigPath);
  }
  return _cachedClientConfig;
}

// Resolve variant: positional arg wins; else fall back to client config (CI uses this).
function resolveVariant() {
  if (VARIANTS[variant]) return variant;
  const cfg = getClientConfig();
  if (cfg && VARIANTS[cfg.variant]) return cfg.variant;
  console.error(`\n  Error: variant must be "pos" or "cpos" (provide as positional arg or via --client config)\n`);
  usage();
  process.exit(1);
}

function usage() {
  console.log(`
  Zota Desktop CLI

  Usage: node scripts/zota.js <command> [variant] [options]

  Commands:
    run <pos|cpos>                          Run the desktop app locally
    build <pos|cpos>                        Build the desktop app
    dist <pos|cpos> [options]               Build + package MSI installer
    check <pos|cpos>                        Run preflight checks only
    setup                                   Initialize submodules + install all deps

  Options:
    --client <path>     Client config file for dist (sets publish repo, app name)
    --version <x.y.z>   Override package.json version for the duration of the build (does not commit)
    --publish           Publish the built MSI to the configured GitHub release repo

  Examples:
    node scripts/zota.js run pos
    node scripts/zota.js dist cpos --client clients/acme-pharmacy.json
    node scripts/zota.js dist pos --client clients/acme-pharmacy.json --version 1.0.5 --publish
    node scripts/zota.js setup
  `);
}

function run(cmd, opts = {}) {
  console.log(`  > ${cmd}`);
  execSync(cmd, { stdio: 'inherit', cwd: ROOT, ...opts });
}

function preflight(v) {
  console.log(`\n  Running preflight checks for ${v.toUpperCase()}...\n`);
  execSync(`node scripts/check-builds.js ${v}`, { stdio: 'inherit', cwd: ROOT });
}

function setVariantConfig(v) {
  const config = VARIANTS[v];
  const clientConfig = getClientConfig();
  if (clientConfig) {
    console.log(`  Client: ${clientConfig.clientName} (${clientConfig.clientId})`);
  }

  // Write variant.json that backend-runner.ts reads at runtime
  const variantConfig = {
    variant: v,
    appName: config.appName,
    appId: config.appId,
    backendDir: path.join('sourcecode', config.backendDir),
    frontendDir: path.join('sourcecode', 'zota-react-frontend', 'build'),
  };
  fs.writeFileSync(
    path.join(ROOT, 'dist', 'variant.json'),
    JSON.stringify(variantConfig, null, 2)
  );
  console.log(`  Variant set to: ${config.appName}`);

  // Update electron-builder.json for packaging
  const builderPath = path.join(ROOT, 'electron-builder.json');
  const builder = JSON.parse(fs.readFileSync(builderPath, 'utf8'));
  builder.productName = config.appName;
  builder.appId = config.appId;
  builder.extraResources = [
    { from: path.join('sourcecode', 'zota-react-frontend', 'build'), to: 'frontend' },
    { from: 'assets/schema.sql', to: 'schema.sql' },
  ];

  if (clientConfig) {
    if (clientConfig.productName) {
      builder.productName = clientConfig.productName;
    }
    builder.publish = {
      provider: 'github',
      owner: clientConfig.github.owner,
      repo: clientConfig.github.repo,
      private: clientConfig.github.private !== false,
    };
  }

  fs.writeFileSync(builderPath, JSON.stringify(builder, null, 2) + '\n');
}

function buildBackend(v) {
  console.log(`\n  Building backend (${v})...\n`);
  run(`node scripts/build-backend.js ${v}`);
}

function buildFrontend() {
  // Wraps the React build so committed prod URLs in src/redux/config.js
  // get rewritten to localhost for the duration of the build (and restored
  // immediately after). Without this, installers ship with the cloud API
  // URL baked into the bundle. Not in run/build because CRA rebuilds are
  // slow and most local iteration doesn't touch the frontend; explicit
  // `npm run build-frontend` covers that case.
  console.log('\n  Building frontend (with local-backend config)...\n');
  run('node scripts/build-frontend.js');
}

function buildDesktop() {
  console.log('\n  Building desktop app...\n');
  run('npm run build');
}

function runElectron() {
  console.log('\n  Starting Electron...\n');
  const electron = require(path.join(ROOT, 'node_modules', 'electron'));
  const child = spawn(electron, ['.'], {
    cwd: ROOT,
    stdio: 'inherit',
    env: { ...process.env },
  });
  child.on('close', (code) => process.exit(code));
}

function buildMSI() {
  console.log('\n  Packaging installer...\n');
  const publishFlag = shouldPublish ? ' --publish always' : '';
  run(`npx electron-builder${publishFlag}`);
  console.log('\n  Installer created in release/ folder\n');
}

function setup() {
  console.log('\n  Zota Desktop — Setup\n');

  // Init submodules
  console.log('  Initializing submodules...');
  run('git submodule update --init --recursive');

  // Install desktop deps
  console.log('\n  Installing desktop dependencies...');
  run('npm install');

  // Install backend deps (install-all also installs admin settings)
  for (const v of ['pos', 'cpos']) {
    const dir = path.join(ROOT, 'sourcecode', VARIANTS[v].backendDir);
    if (fs.existsSync(path.join(dir, 'package.json'))) {
      // Init nested submodules (admin settings)
      console.log(`\n  Initializing ${v}-backend submodules (admin settings)...`);
      run('git submodule update --init --recursive', { cwd: dir });
      console.log(`  Installing ${v}-backend dependencies...`);
      run('npm run install-all', { cwd: dir });
    }
  }

  // Install frontend deps
  const frontendDir = path.join(ROOT, 'sourcecode', 'zota-react-frontend');
  if (fs.existsSync(path.join(frontendDir, 'package.json'))) {
    console.log('\n  Installing frontend dependencies...');
    run('npm install', { cwd: frontendDir });
  }

  console.log('\n  Setup complete! Run: node scripts/zota.js run pos\n');
}

// --- Main ---

if (!command) {
  usage();
  process.exit(0);
}

if (command === 'setup') {
  setup();
  process.exit(0);
}

// Resolve variant once, used by all variant-aware commands
const resolvedVariant = resolveVariant();

// Ensure dist/ exists for variant.json
fs.mkdirSync(path.join(ROOT, 'dist'), { recursive: true });

async function main() {
  switch (command) {
    case 'check':
      preflight(resolvedVariant);
      break;

    case 'build':
      preflight(resolvedVariant);
      setVariantConfig(resolvedVariant);
      buildBackend(resolvedVariant);
      buildDesktop();
      console.log('\n  Build complete!\n');
      break;

    case 'run':
      preflight(resolvedVariant);
      setVariantConfig(resolvedVariant);
      buildBackend(resolvedVariant);
      buildDesktop();
      runElectron();
      break;

    case 'dist': {
      preflight(resolvedVariant);
      setVariantConfig(resolvedVariant);
      const runBuild = () => {
        buildFrontend();
        buildBackend(resolvedVariant);
        buildDesktop();
        buildMSI();
      };
      if (versionOverride) {
        await withTemporaryVersion(path.join(ROOT, 'package.json'), versionOverride, () => {
          runBuild();
        });
      } else {
        runBuild();
      }
      break;
    }

    default:
      console.error(`\n  Unknown command: ${command}\n`);
      usage();
      process.exit(1);
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
