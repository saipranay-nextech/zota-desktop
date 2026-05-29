#!/usr/bin/env node
/*
 * Add .js extensions to extensionless relative imports/exports in compiled JS.
 *
 * Why this exists:
 *   The backend's tsconfig uses `module: "ESNext"` + `moduleResolution: "Node"`,
 *   and TS 5.3 emits relative imports verbatim — no .js appended. The backend's
 *   package.json declares `"type": "module"`, so Node loads dist/ as strict ESM,
 *   which requires explicit extensions on relative specifiers. Without this
 *   pass, the packaged app crashes on startup with ERR_MODULE_NOT_FOUND
 *   (see: dist/server.js -> "./migrations/insert_user_column_customization").
 *
 *   The proper fix is to upgrade TS and use `rewriteRelativeImportExtensions`,
 *   but that requires source-level changes across every client branch. This
 *   script is a post-build adapter that works for any branch, today.
 *
 * Usage:
 *   node scripts/fix-esm-extensions.js <distDir>
 *
 * Behavior:
 *   - Walks every .js file under distDir.
 *   - For each relative import/export specifier with no extension:
 *       * if <spec>.js exists on disk, rewrite to <spec>.js
 *       * else if <spec>/index.js exists, rewrite to <spec>/index.js
 *       * else leave alone (we can't invent files that aren't there)
 *   - Idempotent: any specifier that already has an extension is skipped.
 */

const fs = require('fs');
const path = require('path');

const distDir = process.argv[2];
if (!distDir) {
  console.error('Usage: fix-esm-extensions.js <distDir>');
  process.exit(2);
}
if (!fs.existsSync(distDir) || !fs.statSync(distDir).isDirectory()) {
  console.error(`fix-esm-extensions: distDir does not exist: ${distDir}`);
  process.exit(2);
}

function* walk(dir) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) yield* walk(full);
    else if (entry.isFile() && full.endsWith('.js')) yield full;
  }
}

// Three forms cover every relative specifier tsc emits:
//   1. `from "./foo"`         — static import / re-export
//   2. `import("./foo")`      — dynamic import
//   3. `import "./foo"`       — side-effect import (no `from`)
// Each captures: prefix | quote | path | quote
const PATTERNS = [
  /(\bfrom\s+)(["'])(\.{1,2}\/[^"']+)(["'])/g,
  /(\bimport\s*\(\s*)(["'])(\.{1,2}\/[^"']+)(["'])/g,
  /(\bimport\s+)(["'])(\.{1,2}\/[^"']+)(["'])/g,
];

// Only treat suffixes Node's ESM resolver actually recognizes as "already
// extensioned." Treating any dot as an extension is wrong — `./db.config`
// resolves to a file named `db.config.js` on disk, but a naive `.config`-is-
// an-extension check would skip it and Node would then refuse the import.
const NODE_ESM_EXTENSIONS = new Set(['js', 'mjs', 'cjs', 'json', 'node']);

function hasResolvableExtension(spec) {
  const last = spec.split('/').pop() || '';
  const dotIdx = last.lastIndexOf('.');
  if (dotIdx <= 0) return false; // no dot, or leading-dot (hidden file)
  const ext = last.slice(dotIdx + 1).toLowerCase();
  return NODE_ESM_EXTENSIONS.has(ext);
}

function resolveExtension(fileDir, spec) {
  const candidates = [`${spec}.js`, `${spec}/index.js`];
  for (const c of candidates) {
    if (fs.existsSync(path.resolve(fileDir, c))) return c;
  }
  return null;
}

let filesChanged = 0;
let importsChanged = 0;
const unresolved = [];

for (const file of walk(distDir)) {
  const original = fs.readFileSync(file, 'utf8');
  const fileDir = path.dirname(file);

  let updated = original;
  for (const pattern of PATTERNS) {
    updated = updated.replace(pattern, (match, prefix, openQuote, spec, closeQuote) => {
      if (hasResolvableExtension(spec)) return match;
      const fixed = resolveExtension(fileDir, spec);
      if (!fixed) {
        unresolved.push({ file: path.relative(distDir, file), spec });
        return match;
      }
      importsChanged += 1;
      return `${prefix}${openQuote}${fixed}${closeQuote}`;
    });
  }

  if (updated !== original) {
    fs.writeFileSync(file, updated);
    filesChanged += 1;
  }
}

console.log(
  `fix-esm-extensions: rewrote ${importsChanged} specifier(s) across ${filesChanged} file(s) in ${distDir}`
);

if (unresolved.length > 0) {
  console.log(`fix-esm-extensions: ${unresolved.length} extensionless specifier(s) could not be resolved on disk:`);
  for (const u of unresolved.slice(0, 20)) {
    console.log(`  ${u.file}: ${u.spec}`);
  }
  if (unresolved.length > 20) console.log(`  ... and ${unresolved.length - 20} more`);
}
