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
