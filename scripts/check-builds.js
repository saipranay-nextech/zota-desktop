#!/usr/bin/env node

/**
 * Preflight check: verifies that frontend and backend builds exist.
 * Usage:
 *   node scripts/check-builds.js <variant>
 *   variant: "pos" or "cpos"
 *
 * Checks:
 *   1. sourcecode/zota-react-frontend/build/index.html exists
 *   2. sourcecode/zota-<variant>-backend-ts/dist/server.js exists
 *   3. Node.js and npm are available
 *   4. Submodules are initialized
 *
 * If builds are missing, prompts user to build now or exit.
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const readline = require('readline');

const ROOT = path.resolve(__dirname, '..');
const variant = process.argv[2]; // "pos" or "cpos"

if (!variant || !['pos', 'cpos'].includes(variant)) {
  console.error('Usage: node scripts/check-builds.js <pos|cpos>');
  process.exit(1);
}

const BACKEND_DIR = path.join(ROOT, 'sourcecode', `zota-${variant === 'pos' ? 'pos' : 'cpos'}-backend-ts`);
const FRONTEND_DIR = path.join(ROOT, 'sourcecode', 'zota-react-frontend');

const ADMIN_DIR = path.join(BACKEND_DIR, 'src', 'administrativesettings');

const checks = {
  submodules: {
    label: 'Submodules initialized',
    test: () => fs.existsSync(path.join(BACKEND_DIR, 'package.json')) && fs.existsSync(path.join(FRONTEND_DIR, 'package.json')),
    fix: () => {
      console.log('  Initializing submodules...');
      execSync('git submodule update --init --recursive', { cwd: ROOT, stdio: 'inherit' });
    },
  },
  adminSettings: {
    label: `Admin settings submodule (inside ${variant}-backend)`,
    test: () => fs.existsSync(path.join(ADMIN_DIR, 'package.json')),
    fix: () => {
      console.log('  Initializing admin settings submodule...');
      execSync('git submodule update --init --recursive', { cwd: BACKEND_DIR, stdio: 'inherit' });
    },
  },
  backendNodeModules: {
    label: `Backend (${variant}) dependencies installed`,
    test: () => fs.existsSync(path.join(BACKEND_DIR, 'node_modules')),
    fix: () => {
      console.log(`  Installing backend dependencies (including admin settings)...`);
      execSync('npm run install-all', { cwd: BACKEND_DIR, stdio: 'inherit' });
    },
  },
  adminNodeModules: {
    label: `Admin settings dependencies installed`,
    test: () => fs.existsSync(path.join(ADMIN_DIR, 'node_modules')),
    fix: () => {
      console.log('  Installing admin settings dependencies...');
      execSync('npm install', { cwd: ADMIN_DIR, stdio: 'inherit' });
    },
  },
  frontendNodeModules: {
    label: 'Frontend dependencies installed',
    test: () => fs.existsSync(path.join(FRONTEND_DIR, 'node_modules')),
    fix: () => {
      console.log('  Installing frontend dependencies...');
      execSync('npm install', { cwd: FRONTEND_DIR, stdio: 'inherit' });
    },
  },
  backendBuild: {
    label: `Backend (${variant}) build`,
    test: () => fs.existsSync(path.join(BACKEND_DIR, 'dist', 'server.js')),
    fix: () => {
      console.log(`  Building backend (${variant})...`);
      execSync('npm run build-main', { cwd: BACKEND_DIR, stdio: 'inherit' });
    },
  },
  frontendBuild: {
    label: 'Frontend build',
    test: () => fs.existsSync(path.join(FRONTEND_DIR, 'build', 'index.html')),
    fix: () => {
      console.log('  Building frontend (this may take a few minutes)...');
      execSync('npm run build', { cwd: FRONTEND_DIR, stdio: 'inherit' });
    },
  },
};

function prompt(question) {
  const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
  return new Promise((resolve) => {
    rl.question(question, (answer) => {
      rl.close();
      resolve(answer.trim().toLowerCase());
    });
  });
}

async function main() {
  console.log(`\n  Zota Desktop — Preflight Check (${variant.toUpperCase()} variant)\n`);
  console.log('  Checking prerequisites...\n');

  // Check Node.js
  try {
    const nodeVersion = execSync('node --version', { encoding: 'utf8' }).trim();
    console.log(`  ✓ Node.js ${nodeVersion}`);
  } catch {
    console.error('  ✗ Node.js not found. Please install Node.js 18+');
    process.exit(1);
  }

  // Check Git
  try {
    const gitVersion = execSync('git --version', { encoding: 'utf8' }).trim();
    console.log(`  ✓ ${gitVersion}`);
  } catch {
    console.error('  ✗ Git not found. Please install Git.');
    process.exit(1);
  }

  console.log('');

  const failures = [];

  for (const [key, check] of Object.entries(checks)) {
    if (check.test()) {
      console.log(`  ✓ ${check.label}`);
    } else {
      console.log(`  ✗ ${check.label} — MISSING`);
      failures.push({ key, ...check });
    }
  }

  if (failures.length === 0) {
    console.log('\n  All checks passed! Ready to run.\n');
    process.exit(0);
  }

  console.log(`\n  ${failures.length} issue(s) found.`);
  const answer = await prompt('  Fix now? (Y/n): ');

  if (answer === 'n' || answer === 'no') {
    console.log('  Exiting. Fix the issues manually and try again.');
    process.exit(1);
  }

  for (const failure of failures) {
    try {
      failure.fix();
      if (failure.test()) {
        console.log(`  ✓ ${failure.label} — FIXED`);
      } else {
        console.log(`  ✗ ${failure.label} — still failing after fix attempt`);
        process.exit(1);
      }
    } catch (error) {
      console.error(`  ✗ Failed to fix "${failure.label}": ${error.message}`);
      process.exit(1);
    }
  }

  console.log('\n  All checks passed! Ready to run.\n');
}

main().catch((err) => {
  console.error('Preflight check failed:', err.message);
  process.exit(1);
});
