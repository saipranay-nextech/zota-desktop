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
