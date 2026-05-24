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
