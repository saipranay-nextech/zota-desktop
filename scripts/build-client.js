#!/usr/bin/env node

/**
 * Build script for client-specific Zota CPOS installers.
 *
 * Usage:
 *   node scripts/build-client.js <client-config-file>
 *
 * Example:
 *   node scripts/build-client.js clients/acme-pharmacy.json
 *
 * The script:
 * 1. Reads client config (GitHub repo, name, etc.)
 * 2. Updates electron-builder.json with client-specific publish settings
 * 3. Generates an activation code for the client
 * 4. Runs the full build (main + renderer + electron-builder)
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const clientConfigPath = process.argv[2];

if (!clientConfigPath) {
  console.error('Usage: node scripts/build-client.js <client-config-file>');
  console.error('Example: node scripts/build-client.js clients/acme-pharmacy.json');
  process.exit(1);
}

// Read client config
const fullPath = path.resolve(clientConfigPath);
if (!fs.existsSync(fullPath)) {
  console.error(`Client config not found: ${fullPath}`);
  process.exit(1);
}

const clientConfig = JSON.parse(fs.readFileSync(fullPath, 'utf8'));

console.log(`\n========================================`);
console.log(`Building for: ${clientConfig.clientName}`);
console.log(`Client ID: ${clientConfig.clientId}`);
console.log(`GitHub: ${clientConfig.github.owner}/${clientConfig.github.repo}`);
console.log(`========================================\n`);

// Update electron-builder.json with client-specific settings
const builderConfigPath = path.resolve(__dirname, '..', 'electron-builder.json');
const builderConfig = JSON.parse(fs.readFileSync(builderConfigPath, 'utf8'));

builderConfig.publish = {
  provider: 'github',
  owner: clientConfig.github.owner,
  repo: clientConfig.github.repo,
  private: clientConfig.github.private !== false,
};

// Optionally customize product name per client
if (clientConfig.productName) {
  builderConfig.productName = clientConfig.productName;
}

fs.writeFileSync(builderConfigPath, JSON.stringify(builderConfig, null, 2) + '\n');
console.log('Updated electron-builder.json with client config');

// Generate activation code
console.log('\nGenerating activation code...');
try {
  const result = execSync(
    `npx ts-node scripts/generate-activation.ts --customer-id "${clientConfig.clientId}" --customer-name "${clientConfig.clientName}"`,
    { encoding: 'utf8', cwd: path.resolve(__dirname, '..') }
  );
  console.log(result);
} catch (error) {
  console.warn('Could not generate activation code (ts-node may not be configured). Generate manually later.');
}

// Build
console.log('Building application...');
try {
  execSync('npm run build', {
    stdio: 'inherit',
    cwd: path.resolve(__dirname, '..'),
  });
  console.log('\nBuild complete!');
} catch (error) {
  console.error('Build failed:', error.message);
  process.exit(1);
}

// Package (only on Windows)
if (process.platform === 'win32') {
  console.log('\nPackaging installer...');
  try {
    execSync('npx electron-builder --win', {
      stdio: 'inherit',
      cwd: path.resolve(__dirname, '..'),
    });
    console.log(`\nInstaller created in release/ folder`);
  } catch (error) {
    console.error('Packaging failed:', error.message);
    process.exit(1);
  }
} else {
  console.log('\nSkipping packaging (not on Windows). Run on Windows to create .exe installer.');
  console.log('Or run: npx electron-builder --win  (may work with Wine on macOS/Linux)');
}

console.log(`\n========================================`);
console.log(`Build complete for: ${clientConfig.clientName}`);
console.log(`========================================\n`);
