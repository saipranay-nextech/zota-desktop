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
