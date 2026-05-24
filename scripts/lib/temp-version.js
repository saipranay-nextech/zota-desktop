const fs = require('fs');

async function withTemporaryVersion(packageJsonPath, newVersion, callback) {
  if (typeof newVersion !== 'string' || newVersion.length === 0) {
    throw new Error('version must be a non-empty string');
  }
  const originalRaw = fs.readFileSync(packageJsonPath, 'utf8');
  const pkg = JSON.parse(originalRaw);
  if (typeof pkg.version !== 'string') {
    throw new Error(`package.json at ${packageJsonPath} has no version field`);
  }
  const trailingNewline = originalRaw.endsWith('\n') ? '\n' : '';
  pkg.version = newVersion;
  fs.writeFileSync(packageJsonPath, JSON.stringify(pkg, null, 2) + trailingNewline);
  try {
    return await callback();
  } finally {
    fs.writeFileSync(packageJsonPath, originalRaw);
  }
}

module.exports = { withTemporaryVersion };
