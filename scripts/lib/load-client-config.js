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
