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
