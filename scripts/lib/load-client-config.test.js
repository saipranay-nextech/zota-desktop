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

test('rejects missing clientId', () => {
  const cfg = { ...validConfig };
  delete cfg.clientId;
  assert.throws(() => loadClientConfig(tempConfig(cfg)), /missing required field "clientId"/i);
});

test('rejects missing clientName', () => {
  const cfg = { ...validConfig };
  delete cfg.clientName;
  assert.throws(() => loadClientConfig(tempConfig(cfg)), /missing required field "clientName"/i);
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
