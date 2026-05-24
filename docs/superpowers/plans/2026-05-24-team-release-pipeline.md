# Team Release Pipeline Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Move desktop releases off a single developer's local machine onto GitHub Actions, so any team member can release for any client without local Windows/token setup, while preserving per-client release repos and per-client submodule branches.

**Architecture:** A single workflow in `.github/workflows/release.yml` runs on `windows-latest`, triggered by tags shaped `<client>/v<version>` or via `workflow_dispatch`. The workflow reads `clients/<client>.json` to learn variant + submodule branches, mints a token from one shared GitHub App for both source-repo read and release-repo write, runs the existing `scripts/zota.js dist` pipeline with new `--version` and `--publish` flags, and lets electron-builder push the MSI + `latest.yml` + `.blockmap` to the client's release repo. All client release repos live under the `Zota-NexTech-Limited` org.

**Tech Stack:** Node.js 18+, GitHub Actions (windows-latest runner), `actions/create-github-app-token`, electron-builder, electron-updater, `node:test` (built-in) for script unit tests.

**Pre-flight (do these before Task 1):**

1. The in-flight variant refactor in this repo (`scripts/zota.js`, `scripts/check-builds.js`, modified `electron-builder.json`, `package.json`, `src/main/...`, `.gitmodules`) is still uncommitted. **Commit it first** on `main` (or a feature branch you intend to merge before doing releases). The plan assumes those files are in place.
2. The plan also assumes the client release repos (currently `zota-updates-acme` etc.) are owned by `Zota-NexTech-Limited` org. If any are still on a personal account, transfer them in the GitHub UI before Task 9.

**Spec:** `docs/superpowers/specs/2026-05-24-team-release-pipeline-design.md`

---

## File Structure

**New files:**
- `scripts/lib/parse-tag.js` — pure tag parser (`acme/v1.0.5` → `{ client, version }`)
- `scripts/lib/parse-tag.test.js`
- `scripts/lib/load-client-config.js` — reads + validates `clients/<name>.json`
- `scripts/lib/load-client-config.test.js`
- `scripts/lib/temp-version.js` — wraps a callback with a temporary `package.json` version
- `scripts/lib/temp-version.test.js`
- `.github/workflows/release.yml` — the workflow
- `docs/RELEASING.md` — team-facing release docs incl. GitHub App setup checklist

**Modified files:**
- `package.json` — adds `"test"` script
- `scripts/zota.js` — accepts `--version`, `--publish`; in CI mode reads variant/branches from client config
- `clients/acme-pharmacy.json` — adds `variant`, `backendBranch`, `frontendBranch`
- `clients/example-client.json` — adds same fields, becomes the schema reference
- `.gitmodules` + git index — submodules properly registered via `git submodule add` (Task 7)

**Why these boundaries:** Each `scripts/lib/*.js` does one thing and is a pure function over its inputs (file paths in / parsed object out, or wraps a callback). That keeps `scripts/zota.js` itself thin and lets each new module be unit-tested without spinning up Electron or hitting the network.

---

## Task 1: Add Node test runner to npm scripts

**Files:**
- Modify: `package.json`

- [ ] **Step 1: Add the test script**

Open `package.json` and locate the `scripts` section. Add a `test` entry. Final relevant slice:

```json
  "scripts": {
    "build:main": "tsc --project tsconfig.main.json",
    "build:preload": "esbuild src/main/preload.ts --bundle --outfile=dist/main/main/preload.js --platform=node --target=node18 --external:electron",
    "build:renderer": "esbuild src/renderer/index.tsx --bundle --outfile=dist/renderer/index.js --platform=browser --target=chrome108 --loader:.tsx=tsx --loader:.ts=ts && esbuild src/renderer/update-entry.tsx --bundle --outfile=dist/renderer/update.js --platform=browser --target=chrome108 --loader:.tsx=tsx --loader:.ts=ts",
    "build": "npm run build:main && npm run build:preload && npm run build:renderer && npm run copy-assets",
    "copy-assets": "shx cp src/renderer/index.html dist/renderer/ && shx cp src/renderer/update.html dist/renderer/ && shx cp src/renderer/styles.css dist/renderer/",
    "start": "npm run build && electron .",
    "dev": "concurrently \"tsc --project tsconfig.main.json -w\" \"electron .\"",
    "test": "node --test scripts/lib/",
    ...rest unchanged...
```

- [ ] **Step 2: Verify the script registered**

Run: `npm run test`
Expected: exits 0 with output similar to `# tests 0` / `# pass 0` (no test files yet, so it finds nothing — but the script itself works).

- [ ] **Step 3: Commit**

```bash
git add package.json
git commit -m "build: add node --test runner for script unit tests"
```

---

## Task 2: Tag parser module (TDD)

**Files:**
- Create: `scripts/lib/parse-tag.js`
- Create: `scripts/lib/parse-tag.test.js`

Tag format: `<client>/v<version>` — e.g., `acme/v1.0.5`. Refs from a tag push come in as `refs/tags/<tag>`; the parser accepts either form.

- [ ] **Step 1: Write the failing test**

Create `scripts/lib/parse-tag.test.js`:

```js
const test = require('node:test');
const assert = require('node:assert/strict');
const { parseReleaseTag } = require('./parse-tag');

test('parses a bare tag', () => {
  assert.deepEqual(parseReleaseTag('acme/v1.0.5'), { client: 'acme', version: '1.0.5' });
});

test('parses a refs/tags/ tag ref', () => {
  assert.deepEqual(parseReleaseTag('refs/tags/acme/v1.0.5'), { client: 'acme', version: '1.0.5' });
});

test('accepts semver pre-release and build metadata', () => {
  assert.deepEqual(
    parseReleaseTag('acme/v1.0.5-beta.1'),
    { client: 'acme', version: '1.0.5-beta.1' }
  );
});

test('rejects tag without v prefix on version', () => {
  assert.throws(() => parseReleaseTag('acme/1.0.5'), /tag must match/i);
});

test('rejects tag without client segment', () => {
  assert.throws(() => parseReleaseTag('v1.0.5'), /tag must match/i);
});

test('rejects empty input', () => {
  assert.throws(() => parseReleaseTag(''), /tag must match/i);
});

test('rejects client names with slashes', () => {
  assert.throws(() => parseReleaseTag('zota/acme/v1.0.5'), /tag must match/i);
});
```

- [ ] **Step 2: Run test to verify it fails**

Run: `npm run test`
Expected: FAIL with `Cannot find module './parse-tag'`.

- [ ] **Step 3: Implement the parser**

Create `scripts/lib/parse-tag.js`:

```js
const TAG_PATTERN = /^([a-z0-9][a-z0-9-]*)\/v(\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?(?:\+[0-9A-Za-z.-]+)?)$/;

function parseReleaseTag(input) {
  if (typeof input !== 'string') {
    throw new Error('tag must be a string');
  }
  const stripped = input.startsWith('refs/tags/') ? input.slice('refs/tags/'.length) : input;
  const match = TAG_PATTERN.exec(stripped);
  if (!match) {
    throw new Error(
      `tag must match "<client>/v<semver>" (got "${input}"). Example: "acme/v1.0.5"`
    );
  }
  return { client: match[1], version: match[2] };
}

module.exports = { parseReleaseTag };
```

- [ ] **Step 4: Run test to verify it passes**

Run: `npm run test`
Expected: PASS, 7 tests pass.

- [ ] **Step 5: Commit**

```bash
git add scripts/lib/parse-tag.js scripts/lib/parse-tag.test.js
git commit -m "feat(release): add release tag parser"
```

---

## Task 3: Client config loader module (TDD)

**Files:**
- Create: `scripts/lib/load-client-config.js`
- Create: `scripts/lib/load-client-config.test.js`

Loads a client JSON, validates the new schema (`variant`, `backendBranch`, `frontendBranch`, plus existing `clientId`, `clientName`, `github.{owner,repo}`), and returns it. Throws descriptive errors on each missing field — release manager should never have to guess what's wrong.

- [ ] **Step 1: Write the failing tests**

Create `scripts/lib/load-client-config.test.js`:

```js
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const os = require('os');
const { loadClientConfig } = require('./load-client-config');

function tempConfig(contents) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'zota-client-cfg-'));
  const filePath = path.join(dir, 'client.json');
  fs.writeFileSync(filePath, typeof contents === 'string' ? contents : JSON.stringify(contents));
  return filePath;
}

const validConfig = {
  clientId: 'acme-001',
  clientName: 'ACME Pharmacy',
  variant: 'pos',
  backendBranch: 'client-acme',
  frontendBranch: 'client-acme',
  github: { owner: 'Zota-NexTech-Limited', repo: 'zota-updates-acme', private: true },
};

test('loads and returns a valid config', () => {
  const result = loadClientConfig(tempConfig(validConfig));
  assert.equal(result.clientId, 'acme-001');
  assert.equal(result.variant, 'pos');
  assert.equal(result.backendBranch, 'client-acme');
  assert.equal(result.github.repo, 'zota-updates-acme');
});

test('rejects nonexistent file', () => {
  assert.throws(
    () => loadClientConfig('/nonexistent/path/foo.json'),
    /client config not found/i
  );
});

test('rejects malformed JSON', () => {
  assert.throws(
    () => loadClientConfig(tempConfig('{ not json')),
    /failed to parse/i
  );
});

test('rejects missing variant', () => {
  const cfg = { ...validConfig };
  delete cfg.variant;
  assert.throws(() => loadClientConfig(tempConfig(cfg)), /missing required field "variant"/i);
});

test('rejects invalid variant value', () => {
  assert.throws(
    () => loadClientConfig(tempConfig({ ...validConfig, variant: 'foo' })),
    /variant must be "pos" or "cpos"/i
  );
});

test('rejects missing backendBranch', () => {
  const cfg = { ...validConfig };
  delete cfg.backendBranch;
  assert.throws(() => loadClientConfig(tempConfig(cfg)), /missing required field "backendBranch"/i);
});

test('rejects missing frontendBranch', () => {
  const cfg = { ...validConfig };
  delete cfg.frontendBranch;
  assert.throws(() => loadClientConfig(tempConfig(cfg)), /missing required field "frontendBranch"/i);
});

test('rejects missing github.owner', () => {
  const cfg = { ...validConfig, github: { repo: 'x' } };
  assert.throws(() => loadClientConfig(tempConfig(cfg)), /missing required field "github.owner"/i);
});

test('rejects missing github.repo', () => {
  const cfg = { ...validConfig, github: { owner: 'x' } };
  assert.throws(() => loadClientConfig(tempConfig(cfg)), /missing required field "github.repo"/i);
});
```

- [ ] **Step 2: Run test to verify it fails**

Run: `npm run test`
Expected: FAIL with `Cannot find module './load-client-config'`.

- [ ] **Step 3: Implement the loader**

Create `scripts/lib/load-client-config.js`:

```js
const fs = require('fs');
const path = require('path');

const ALLOWED_VARIANTS = new Set(['pos', 'cpos']);

function requireField(cfg, fieldPath) {
  const segments = fieldPath.split('.');
  let cursor = cfg;
  for (const seg of segments) {
    if (cursor == null || typeof cursor !== 'object' || !(seg in cursor)) {
      throw new Error(`client config: missing required field "${fieldPath}"`);
    }
    cursor = cursor[seg];
  }
  if (cursor === '' || cursor == null) {
    throw new Error(`client config: missing required field "${fieldPath}"`);
  }
  return cursor;
}

function loadClientConfig(configPath) {
  const abs = path.resolve(configPath);
  if (!fs.existsSync(abs)) {
    throw new Error(`client config not found: ${abs}`);
  }
  let raw;
  try {
    raw = fs.readFileSync(abs, 'utf8');
  } catch (err) {
    throw new Error(`failed to read ${abs}: ${err.message}`);
  }
  let cfg;
  try {
    cfg = JSON.parse(raw);
  } catch (err) {
    throw new Error(`failed to parse ${abs}: ${err.message}`);
  }

  requireField(cfg, 'clientId');
  requireField(cfg, 'clientName');
  const variant = requireField(cfg, 'variant');
  if (!ALLOWED_VARIANTS.has(variant)) {
    throw new Error(`client config: variant must be "pos" or "cpos" (got "${variant}")`);
  }
  requireField(cfg, 'backendBranch');
  requireField(cfg, 'frontendBranch');
  requireField(cfg, 'github.owner');
  requireField(cfg, 'github.repo');

  return cfg;
}

module.exports = { loadClientConfig };
```

- [ ] **Step 4: Run test to verify it passes**

Run: `npm run test`
Expected: PASS, all 9 new tests pass (plus the 7 from Task 2 = 16 total).

- [ ] **Step 5: Commit**

```bash
git add scripts/lib/load-client-config.js scripts/lib/load-client-config.test.js
git commit -m "feat(release): add client config loader with schema validation"
```

---

## Task 4: Temporary version writer module (TDD)

**Files:**
- Create: `scripts/lib/temp-version.js`
- Create: `scripts/lib/temp-version.test.js`

Used by CI to override `package.json#version` for the duration of a build, without committing the bump. Restores the original on completion (success or failure).

- [ ] **Step 1: Write the failing tests**

Create `scripts/lib/temp-version.test.js`:

```js
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const os = require('os');
const { withTemporaryVersion } = require('./temp-version');

function tempPkg(version) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'zota-pkg-'));
  const filePath = path.join(dir, 'package.json');
  fs.writeFileSync(filePath, JSON.stringify({ name: 'test', version }, null, 2) + '\n');
  return filePath;
}

function readVersion(pkgPath) {
  return JSON.parse(fs.readFileSync(pkgPath, 'utf8')).version;
}

test('writes new version during callback, restores after', async () => {
  const pkgPath = tempPkg('1.0.0');
  let seenInside;
  await withTemporaryVersion(pkgPath, '1.0.5', async () => {
    seenInside = readVersion(pkgPath);
  });
  assert.equal(seenInside, '1.0.5');
  assert.equal(readVersion(pkgPath), '1.0.0');
});

test('restores original version even if callback throws', async () => {
  const pkgPath = tempPkg('1.0.0');
  await assert.rejects(
    withTemporaryVersion(pkgPath, '2.0.0', async () => {
      throw new Error('boom');
    }),
    /boom/
  );
  assert.equal(readVersion(pkgPath), '1.0.0');
});

test('preserves trailing newline in package.json', async () => {
  const pkgPath = tempPkg('1.0.0');
  await withTemporaryVersion(pkgPath, '1.0.5', async () => {
    const contents = fs.readFileSync(pkgPath, 'utf8');
    assert.ok(contents.endsWith('\n'), 'expected trailing newline');
  });
});

test('rejects empty version string', async () => {
  const pkgPath = tempPkg('1.0.0');
  await assert.rejects(
    withTemporaryVersion(pkgPath, '', async () => {}),
    /version must be a non-empty string/i
  );
  assert.equal(readVersion(pkgPath), '1.0.0');
});
```

- [ ] **Step 2: Run test to verify it fails**

Run: `npm run test`
Expected: FAIL with `Cannot find module './temp-version'`.

- [ ] **Step 3: Implement the helper**

Create `scripts/lib/temp-version.js`:

```js
const fs = require('fs');

async function withTemporaryVersion(packageJsonPath, newVersion, callback) {
  if (typeof newVersion !== 'string' || newVersion.length === 0) {
    throw new Error('version must be a non-empty string');
  }
  const originalRaw = fs.readFileSync(packageJsonPath, 'utf8');
  const trailingNewline = originalRaw.endsWith('\n') ? '\n' : '';
  const pkg = JSON.parse(originalRaw);
  const originalVersion = pkg.version;
  pkg.version = newVersion;
  fs.writeFileSync(packageJsonPath, JSON.stringify(pkg, null, 2) + trailingNewline);
  try {
    return await callback();
  } finally {
    pkg.version = originalVersion;
    fs.writeFileSync(packageJsonPath, JSON.stringify(pkg, null, 2) + trailingNewline);
  }
}

module.exports = { withTemporaryVersion };
```

- [ ] **Step 4: Run test to verify it passes**

Run: `npm run test`
Expected: PASS, all 4 new tests pass (20 total).

- [ ] **Step 5: Commit**

```bash
git add scripts/lib/temp-version.js scripts/lib/temp-version.test.js
git commit -m "feat(release): add temporary package.json version writer"
```

---

## Task 5: Update client config schema (data change)

**Files:**
- Modify: `clients/acme-pharmacy.json`
- Modify: `clients/example-client.json`

Add the three new fields. The loader (Task 3) now requires them; build-client.js consumers will keep working because they ignore unknown fields.

- [ ] **Step 1: Update `clients/acme-pharmacy.json`**

Replace the entire file contents with:

```json
{
  "clientId": "acme-001",
  "clientName": "ACME Pharmacy",
  "variant": "pos",
  "backendBranch": "client-acme",
  "frontendBranch": "client-acme",
  "github": {
    "owner": "Zota-NexTech-Limited",
    "repo": "zota-updates-acme",
    "private": true
  }
}
```

Note: `github.owner` is updated from `saipranay-nextech` to `Zota-NexTech-Limited`. If ACME's release repo hasn't been transferred to the org yet, do that in the GitHub UI first (Settings → Transfer ownership on `zota-updates-acme`).

- [ ] **Step 2: Update `clients/example-client.json` as the schema reference**

Replace the entire file contents with:

```json
{
  "clientId": "example-client",
  "clientName": "Example Pharmacy",
  "productName": "Example POS",
  "variant": "pos",
  "backendBranch": "client-example",
  "frontendBranch": "client-example",
  "github": {
    "owner": "Zota-NexTech-Limited",
    "repo": "zota-updates-example",
    "private": true
  }
}
```

- [ ] **Step 3: Verify configs load**

Create a one-off check script (run inline, don't commit it):

```bash
node -e "console.log(require('./scripts/lib/load-client-config').loadClientConfig('clients/acme-pharmacy.json'))"
```
Expected: prints the parsed config object with no errors.

```bash
node -e "console.log(require('./scripts/lib/load-client-config').loadClientConfig('clients/example-client.json'))"
```
Expected: prints the parsed config object with no errors.

- [ ] **Step 4: Commit**

```bash
git add clients/acme-pharmacy.json clients/example-client.json
git commit -m "feat(release): extend client config schema with variant and submodule branches"
```

---

## Task 6: Wire new modules into `scripts/zota.js`

**Files:**
- Modify: `scripts/zota.js`

Adds: `--version <x.y.z>` (temporarily overrides `package.json#version`), `--publish` (passes `--publish always` to electron-builder), CI-mode behavior (when `process.env.GITHUB_ACTIONS === 'true'`, read variant + branches from client config instead of CLI args).

- [ ] **Step 1: Replace the top-of-file constants block**

Open `scripts/zota.js`. The current file (post-Pre-flight) declares `ROOT`, `command`, `variant`, `clientFlag`, `clientConfigPath` near the top (lines ~26-31), then declares `VARIANTS` further down (lines ~33-44). Replace BOTH blocks with this single consolidated block at the top, right after the `require` lines:

```js
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
const isCI = process.env.GITHUB_ACTIONS === 'true';
```

Confirm `VARIANTS` is now declared only once in the file. Delete the original lower-down `VARIANTS = { ... };` block if it's still there.

Also add these new requires at the top alongside the existing `child_process`/`fs`/`path` requires:

```js
const { loadClientConfig } = require('./lib/load-client-config');
const { withTemporaryVersion } = require('./lib/temp-version');
```

- [ ] **Step 2: Add a single variant-resolution helper used by all commands**

Below the parsing block (and before `function usage()`), add:

```js
// Resolve variant: positional arg wins; else fall back to client config (CI uses this).
function resolveVariant() {
  if (VARIANTS[variant]) return variant;
  if (clientConfigPath) {
    const cfg = loadClientConfig(clientConfigPath);
    if (VARIANTS[cfg.variant]) return cfg.variant;
  }
  console.error(`\n  Error: variant must be "pos" or "cpos" (provide as positional arg or via --client config)\n`);
  usage();
  process.exit(1);
}
```

- [ ] **Step 3: Rewrite `setVariantConfig` to use the loader and take a pre-resolved variant**

Locate `setVariantConfig` (around line 79). Replace the entire function with:

```js
function setVariantConfig(v) {
  const config = VARIANTS[v];
  let clientConfig = null;
  if (clientConfigPath) {
    clientConfig = loadClientConfig(clientConfigPath);
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
```

- [ ] **Step 4: Add `--publish` support to `buildMSI`**

Locate `buildMSI` (around line 153). Replace it with:

```js
function buildMSI() {
  console.log('\n  Packaging installer...\n');
  const publishFlag = shouldPublish ? ' --publish always' : '';
  run(`npx electron-builder${publishFlag}`);
  console.log('\n  Installer created in release/ folder\n');
}
```

- [ ] **Step 5: Replace the bottom switch block to use `resolveVariant()` and `--version`**

Locate the variant-required check + `switch (command)` block near the bottom of the file (the existing pattern is roughly lines 199-243). Replace the whole bottom section starting from `if (!command) {` with:

```js
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
      buildDesktop();
      console.log('\n  Build complete!\n');
      break;

    case 'run':
      preflight(resolvedVariant);
      setVariantConfig(resolvedVariant);
      buildDesktop();
      runElectron();
      break;

    case 'dist': {
      preflight(resolvedVariant);
      setVariantConfig(resolvedVariant);
      const runBuild = () => {
        buildDesktop();
        buildMSI();
      };
      if (versionOverride) {
        await withTemporaryVersion(path.join(ROOT, 'package.json'), versionOverride, async () => {
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
```

Also update the `preflight` function (around line 74) to require an explicit variant:

```js
function preflight(v) {
  console.log(`\n  Running preflight checks for ${v.toUpperCase()}...\n`);
  execSync(`node scripts/check-builds.js ${v}`, { stdio: 'inherit', cwd: ROOT });
}
```

- [ ] **Step 6: Smoke test locally — non-CI dist still works unchanged**

Run: `node scripts/zota.js check pos`
Expected: preflight runs to completion (it may prompt to install/build if anything is missing — that's fine, exit if needed).

Run: `node scripts/zota.js dist pos --client clients/acme-pharmacy.json` (without `--version` or `--publish`)
Expected: runs through the full build, produces `release/Zota POS Setup 1.0.0.msi` (or whatever version is in package.json). Should NOT publish to GitHub.

If you don't have time for a full build right now, skip this step — Task 10's end-to-end test covers it.

- [ ] **Step 7: Commit**

```bash
git add scripts/zota.js
git commit -m "feat(release): wire --version, --publish flags and CI variant resolution into zota.js"
```

---

## Task 7: Register submodules properly in git

**Files:**
- Modify: `.gitmodules` (already exists)
- Modify: git index

Currently `.gitmodules` declares the three submodules but `git status` shows `sourcecode/` as one untracked directory — the submodules were cloned but never `git submodule add`-ed. CI's `git submodule update --init` won't work in this state.

- [ ] **Step 1: Inspect current state**

Run: `git status sourcecode/ && cat .gitmodules`
Expected: `sourcecode/` is untracked, `.gitmodules` lists three submodules.

- [ ] **Step 2: Properly register each submodule**

The submodule directories exist as clones already, so use `git submodule add` with the same URLs and paths. Git will detect the existing clone and just register them in the index.

```bash
git submodule add git@github.com-zota:Zota-NexTech-Limited/zota-pos-backend-ts.git sourcecode/zota-pos-backend-ts
git submodule add git@github.com-zota:Zota-NexTech-Limited/zota-cpos-backend-ts.git sourcecode/zota-cpos-backend-ts
git submodule add git@github.com-zota:Zota-NexTech-Limited/zota-react-frontend.git sourcecode/zota-react-frontend
```

If any of these say "already exists in the index", run `git rm --cached sourcecode/<that-one>` and try again.

- [ ] **Step 3: Verify status**

Run: `git status`
Expected: `.gitmodules` is modified (or new), each `sourcecode/zota-*` shows as a new file pointing at a commit SHA, no plain `sourcecode/` dir untracked.

- [ ] **Step 4: Commit**

```bash
git add .gitmodules sourcecode/
git commit -m "build: register sourcecode submodules in git index"
```

- [ ] **Step 5: Verify a clean clone would work**

Run: `git ls-tree HEAD sourcecode/`
Expected: each submodule appears as a `commit` entry (160000 mode), not a directory.

---

## Task 8: Create the release workflow

**Files:**
- Create: `.github/workflows/release.yml`

- [ ] **Step 1: Create the workflow file**

Create `.github/workflows/release.yml`:

```yaml
name: Release

on:
  push:
    tags:
      - '*/v*'
  workflow_dispatch:
    inputs:
      client:
        description: 'Client name (must match clients/<name>.json without extension)'
        required: true
        type: string
      version:
        description: 'Version (e.g., 1.0.5)'
        required: true
        type: string
      create_tag:
        description: 'Also create and push the git tag <client>/v<version>'
        required: false
        type: boolean
        default: true

concurrency:
  group: release-${{ github.event.inputs.client || github.ref_name }}
  cancel-in-progress: false

jobs:
  release:
    runs-on: windows-latest
    timeout-minutes: 60
    permissions:
      contents: write

    steps:
      - name: Checkout zota-desktop (no submodules yet)
        uses: actions/checkout@v4
        with:
          submodules: false

      - name: Parse inputs (tag or dispatch)
        id: inputs
        shell: bash
        run: |
          if [ "${{ github.event_name }}" = "workflow_dispatch" ]; then
            CLIENT="${{ github.event.inputs.client }}"
            VERSION="${{ github.event.inputs.version }}"
          else
            # Use the JS parser so the format is enforced in exactly one place
            PARSED=$(node -e "
              const { parseReleaseTag } = require('./scripts/lib/parse-tag');
              const p = parseReleaseTag(process.argv[1]);
              console.log(p.client + '|' + p.version);
            " "${GITHUB_REF}")
            CLIENT="${PARSED%%|*}"
            VERSION="${PARSED##*|}"
          fi
          if [ -z "$CLIENT" ] || [ -z "$VERSION" ]; then
            echo "::error::Could not parse client/version from tag or inputs"
            exit 1
          fi
          # Find the client config file matching the parsed client name.
          # Match by file basename, clientId field, or basename-contains.
          CONFIG_PATH=$(node -e "
            const fs = require('fs'), path = require('path');
            const want = process.argv[1];
            const files = fs.readdirSync('clients').filter(f => f.endsWith('.json'));
            for (const f of files) {
              const base = path.basename(f, '.json');
              const cfg = JSON.parse(fs.readFileSync(path.join('clients', f), 'utf8'));
              if (base === want || cfg.clientId === want || base.includes(want)) {
                console.log(path.join('clients', f));
                process.exit(0);
              }
            }
            process.exit(2);
          " "$CLIENT") || {
            echo "::error::No client config found matching '$CLIENT' in clients/*.json"
            exit 1
          }
          echo "client=$CLIENT" >> "$GITHUB_OUTPUT"
          echo "version=$VERSION" >> "$GITHUB_OUTPUT"
          echo "config_path=$CONFIG_PATH" >> "$GITHUB_OUTPUT"
          echo "Resolved: client=$CLIENT version=$VERSION config=$CONFIG_PATH"

      - name: Mint GitHub App token
        id: app_token
        uses: actions/create-github-app-token@v1
        with:
          app-id: ${{ secrets.ZOTA_BOT_APP_ID }}
          private-key: ${{ secrets.ZOTA_BOT_PRIVATE_KEY }}
          owner: Zota-NexTech-Limited

      - name: Rewrite submodule URLs to HTTPS with app token
        shell: bash
        run: |
          TOKEN="${{ steps.app_token.outputs.token }}"
          git config --global url."https://x-access-token:${TOKEN}@github.com/".insteadOf "git@github.com-zota:"
          git config --global url."https://x-access-token:${TOKEN}@github.com/".insteadOf "git@github.com:"

      - name: Read variant + branches from client config
        id: cfg
        shell: bash
        run: |
          CONFIG="${{ steps.inputs.outputs.config_path }}"
          VARIANT=$(node -e "console.log(JSON.parse(require('fs').readFileSync('$CONFIG','utf8')).variant)")
          BACKEND_BRANCH=$(node -e "console.log(JSON.parse(require('fs').readFileSync('$CONFIG','utf8')).backendBranch)")
          FRONTEND_BRANCH=$(node -e "console.log(JSON.parse(require('fs').readFileSync('$CONFIG','utf8')).frontendBranch)")
          BACKEND_DIR="sourcecode/zota-${VARIANT}-backend-ts"
          echo "variant=$VARIANT" >> "$GITHUB_OUTPUT"
          echo "backend_branch=$BACKEND_BRANCH" >> "$GITHUB_OUTPUT"
          echo "frontend_branch=$FRONTEND_BRANCH" >> "$GITHUB_OUTPUT"
          echo "backend_dir=$BACKEND_DIR" >> "$GITHUB_OUTPUT"

      - name: Init the right submodules at the right branches
        shell: bash
        run: |
          # Only init the variant we need (skip the other backend variant)
          git submodule update --init --depth 1 "${{ steps.cfg.outputs.backend_dir }}"
          git submodule update --init --depth 1 sourcecode/zota-react-frontend

          # Switch each to the client's branch
          ( cd "${{ steps.cfg.outputs.backend_dir }}" && git fetch origin "${{ steps.cfg.outputs.backend_branch }}" --depth 1 && git checkout "${{ steps.cfg.outputs.backend_branch }}" )
          ( cd sourcecode/zota-react-frontend && git fetch origin "${{ steps.cfg.outputs.frontend_branch }}" --depth 1 && git checkout "${{ steps.cfg.outputs.frontend_branch }}" )

          # Init nested submodules (backend admin settings)
          ( cd "${{ steps.cfg.outputs.backend_dir }}" && git submodule update --init --recursive --depth 1 )

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      - name: Install desktop deps
        run: npm ci

      - name: Install backend deps
        shell: bash
        run: |
          cd "${{ steps.cfg.outputs.backend_dir }}"
          npm run install-all

      - name: Install frontend deps
        shell: bash
        run: |
          cd sourcecode/zota-react-frontend
          npm install

      - name: Build frontend
        shell: bash
        run: |
          cd sourcecode/zota-react-frontend
          npm run build

      - name: Build backend
        shell: bash
        run: |
          cd "${{ steps.cfg.outputs.backend_dir }}"
          npm run build-main

      - name: Run release (build + publish)
        env:
          GH_TOKEN: ${{ steps.app_token.outputs.token }}
        run: node scripts/zota.js dist ${{ steps.cfg.outputs.variant }} --client ${{ steps.inputs.outputs.config_path }} --version ${{ steps.inputs.outputs.version }} --publish

      - name: Tag the commit (if dispatch requested it)
        if: ${{ github.event_name == 'workflow_dispatch' && github.event.inputs.create_tag == 'true' }}
        shell: bash
        env:
          GH_TOKEN: ${{ steps.app_token.outputs.token }}
        run: |
          TAG="${{ steps.inputs.outputs.client }}/v${{ steps.inputs.outputs.version }}"
          git config user.name "zota-release-bot"
          git config user.email "release-bot@zota.local"
          git tag "$TAG"
          git push origin "$TAG"

      - name: Summary
        if: always()
        shell: bash
        run: |
          echo "### Release Summary" >> "$GITHUB_STEP_SUMMARY"
          echo "- Client: \`${{ steps.inputs.outputs.client }}\`" >> "$GITHUB_STEP_SUMMARY"
          echo "- Version: \`${{ steps.inputs.outputs.version }}\`" >> "$GITHUB_STEP_SUMMARY"
          echo "- Variant: \`${{ steps.cfg.outputs.variant }}\`" >> "$GITHUB_STEP_SUMMARY"
          echo "- Backend branch: \`${{ steps.cfg.outputs.backend_branch }}\`" >> "$GITHUB_STEP_SUMMARY"
          echo "- Frontend branch: \`${{ steps.cfg.outputs.frontend_branch }}\`" >> "$GITHUB_STEP_SUMMARY"
```

- [ ] **Step 2: Verify YAML is valid**

Run: `node -e "require('js-yaml')"` first to check if `js-yaml` is available; if not, install it as a one-shot:
```bash
npx --yes js-yaml .github/workflows/release.yml > /dev/null && echo "YAML OK"
```
Expected: `YAML OK` (or no error). If `js-yaml` isn't installed and you don't want to install, just visually inspect indentation.

- [ ] **Step 3: Commit**

```bash
git add .github/workflows/release.yml
git commit -m "ci: add release workflow for per-client tagged + manual builds"
```

---

## Task 9: Create RELEASING.md with GitHub App setup checklist

**Files:**
- Create: `docs/RELEASING.md`

- [ ] **Step 1: Write the doc**

Create `docs/RELEASING.md`:

````markdown
# Releasing Zota Desktop

Releases are built and published by GitHub Actions, not on a developer laptop. This doc covers normal releases and the one-time setup.

## Quick reference

**Cut a release:**
```bash
# Make sure you're on main with the submodules pointing at the right commits
git tag acme/v1.0.5
git push origin acme/v1.0.5
```
Then watch the run at: `https://github.com/<owner>/zota-desktop/actions`

**Or via the UI:** Go to Actions → Release → Run workflow → fill in `client` and `version`.

## Tag format

`<client>/v<semver>` — examples: `acme/v1.0.5`, `acme/v1.0.5-beta.1`

The `<client>` segment must match a client config in `clients/`. The matcher accepts:
- the file basename (`acme-pharmacy.json` → `acme-pharmacy`)
- the `clientId` field inside the config
- a substring match of the basename (so `acme` matches `acme-pharmacy.json`)

## Adding a new client

1. Create `clients/<short-name>.json` modeled after `clients/example-client.json`.
2. Make sure the release repo at `Zota-NexTech-Limited/<repo>` exists (create it as a private empty repo if not).
3. Create client-specific branches in the backend and frontend submodules (e.g., `client-acme`) — see git history of existing client branches for the pattern.
4. Commit and push the new client config to `main`.
5. Cut a test release: push `<client>/v0.0.1`.

## How per-client divergence works

- The desktop wrapper (this repo) is single-branch, shared by all clients.
- Per-client code lives on branches inside the backend and frontend submodules (e.g., `client-acme`).
- `clients/<name>.json` records which branches belong to that client.
- CI checks out the right branches and builds with the right variant (`pos` or `cpos`).

## One-time setup (already done; documented for reference)

### 1. Create the GitHub App

1. Org Settings → Developer settings → GitHub Apps → New GitHub App.
2. Name: `Zota Release Bot` (or similar).
3. Homepage URL: anything (e.g., the org URL). Webhook: disable.
4. Permissions:
   - **Repository → Contents: Read & write** (read for source repos, write for release repos).
   - **Repository → Metadata: Read** (auto-included).
5. Where can this be installed: Only on this account.
6. Generate a private key (PEM file) — download it.

### 2. Install the App

1. From the App's page, click Install → choose `Zota-NexTech-Limited` org.
2. Select repos: `zota-pos-backend-ts`, `zota-cpos-backend-ts`, `zota-react-frontend`, and **every** `zota-updates-*` repo.
3. Re-visit and add new release repos here as you onboard new clients.

### 3. Store secrets in `zota-desktop`

1. zota-desktop repo → Settings → Secrets and variables → Actions → New repository secret.
2. Add `ZOTA_BOT_APP_ID` — the App ID shown on the App's settings page (a number).
3. Add `ZOTA_BOT_PRIVATE_KEY` — paste the full contents of the downloaded PEM file (including `-----BEGIN/END-----` lines).

## Hotfix flow

1. Cherry-pick the fix onto the client's branch in the affected submodule, push.
2. Update this repo's submodule pointer to the new SHA, commit, push.
3. Tag a new patch version: `git tag acme/v1.0.6 && git push origin acme/v1.0.6`.

## When a release fails

- **"No client config found matching ..."** — your tag's client segment doesn't match anything in `clients/`. Check the tag format.
- **Submodule checkout fails** — the branch named in `clients/<name>.json#backendBranch` (or `frontendBranch`) doesn't exist on the remote. Create it.
- **electron-builder publish fails midway** — re-run the workflow with the same inputs. electron-builder is idempotent and will overwrite the draft release. Or delete the partial release in the GitHub UI and re-run.

## Local release (emergency only)

If GitHub Actions is down, you can still release from a Windows laptop:
```bash
export GH_TOKEN=<token-with-write-on-the-release-repo>
node scripts/zota.js dist pos --client clients/acme-pharmacy.json --version 1.0.5 --publish
```
This is the same code path the CI runs.
````

- [ ] **Step 2: Commit**

```bash
git add docs/RELEASING.md
git commit -m "docs: add team release guide with GitHub App setup checklist"
```

---

## Task 10: End-to-end verification on a throwaway client

**Files:**
- Create: `clients/test-client.json` (will be deleted after verification)
- Modify: backend + frontend submodules (create `client-test` branches)

The point of this task is to prove the full pipeline works end-to-end without risking a real client release.

- [ ] **Step 1: Complete the GitHub App setup**

Follow the one-time setup section of `docs/RELEASING.md`:
- Create + install the GitHub App on `Zota-NexTech-Limited` org with access to source repos + the throwaway release repo (next step creates it).
- Add `ZOTA_BOT_APP_ID` and `ZOTA_BOT_PRIVATE_KEY` secrets to the `zota-desktop` repo.

- [ ] **Step 2: Create a throwaway release repo**

On GitHub UI: create `Zota-NexTech-Limited/zota-updates-test` as a private empty repo. Make sure the GitHub App's installation grants it access.

- [ ] **Step 3: Create throwaway submodule branches**

For each of `sourcecode/zota-pos-backend-ts` and `sourcecode/zota-react-frontend`:
```bash
cd sourcecode/zota-pos-backend-ts
git checkout -b client-test
git push origin client-test
cd -

cd sourcecode/zota-react-frontend
git checkout -b client-test
git push origin client-test
cd -
```

- [ ] **Step 4: Create the throwaway client config**

Create `clients/test-client.json`:

```json
{
  "clientId": "test-client",
  "clientName": "Zota Test Client",
  "productName": "Zota Test POS",
  "variant": "pos",
  "backendBranch": "client-test",
  "frontendBranch": "client-test",
  "github": {
    "owner": "Zota-NexTech-Limited",
    "repo": "zota-updates-test",
    "private": true
  }
}
```

Commit and push:
```bash
git add clients/test-client.json
git commit -m "test: add throwaway client for pipeline verification"
git push
```

- [ ] **Step 5: Trigger a release via tag**

```bash
git tag test-client/v0.0.1
git push origin test-client/v0.0.1
```

Watch the run in the Actions tab.

Expected: workflow completes successfully (10-20 min on first run). A new release `v0.0.1` appears in `Zota-NexTech-Limited/zota-updates-test` with three assets: the MSI, `latest.yml`, and the `.blockmap`.

If it fails, read the failing step's logs, fix, push, re-tag with `test-client/v0.0.2` and retry.

- [ ] **Step 6: Install the v0.0.1 MSI on a Windows machine**

Download the MSI from the release and run it. Confirm the app launches and reaches the main window. Quit it.

- [ ] **Step 7: Cut v0.0.2 and verify the update flow**

```bash
git tag test-client/v0.0.2
git push origin test-client/v0.0.2
```

Wait for the workflow to complete. Re-launch the installed v0.0.1 app on the Windows machine.

Expected: ~5 seconds after the main window appears, the update window pops up showing v0.0.2. Click download, then quit-and-install. Re-launch — app should now report v0.0.2.

For the update to fetch from the private release repo, the launching shell needs `GH_TOKEN` in env (current `updater.ts:18` behavior). Confirm with a token that has read access to `zota-updates-test`.

- [ ] **Step 8: Trigger the same flow via the manual button**

In the Actions UI, click "Run workflow" on the Release workflow. Inputs: `client=test-client`, `version=0.0.3`, `create_tag=true`. Run it.

Expected: same outcome as Step 7, plus a new tag `test-client/v0.0.3` appears in the repo.

- [ ] **Step 9: Negative test — bad client name**

```bash
git tag bogus-client/v0.0.4
git push origin bogus-client/v0.0.4
```

Expected: workflow fails fast at the "Parse inputs" step with `No client config found matching 'bogus-client'`.

Clean up:
```bash
git push --delete origin bogus-client/v0.0.4
git tag -d bogus-client/v0.0.4
```

- [ ] **Step 10: Tear down the throwaway**

Once verification is complete:

```bash
git rm clients/test-client.json
git commit -m "test: remove throwaway client config after pipeline verification"
git push

# Optional: delete the test release repo and the client-test branches in the submodules
```

- [ ] **Step 11: Document any deviations**

If anything in the workflow needed tweaking during verification, fix it in `release.yml`/`zota.js` and commit. Don't leave the pipeline in a working-but-different-from-spec state.

---

## Done criteria

- All 10 tasks complete.
- `npm run test` passes (20 tests).
- A real release for one existing client (e.g., ACME) cut via tag push lands successfully in the client's update repo, and an installed older version updates to it.
- `docs/RELEASING.md` is the single source any team member needs to cut a release.
