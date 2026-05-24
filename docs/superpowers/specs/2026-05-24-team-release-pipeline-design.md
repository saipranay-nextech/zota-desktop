# Team Release Pipeline — Design

**Date:** 2026-05-24
**Status:** Draft, pending implementation plan
**Scope:** `zota-desktop` repo and its CI

## Problem

Releases of the Zota POS desktop app currently require a single developer's local machine: their Windows environment, their `GH_TOKEN` in shell env, their submodule checkouts. This blocks team members from cutting releases, creates bus-factor risk, and produces non-reproducible artifacts.

The desktop app has unusual structure that the pipeline must handle:
- **One desktop repo** wraps two backend variants (`pos`, `cpos`) and one React frontend, all consumed as git submodules under `sourcecode/`.
- **Per-client divergence** lives on dedicated branches inside the backend and frontend submodules (e.g., `client-acme`).
- **Per-client release repos** — each customer has their own private GitHub repo (e.g., `zota-updates-acme`) that hosts only release artifacts. Customers' installed apps poll their own repo for updates.
- **Independent versions per client** — ACME may be on 1.0.5 while another customer is on 1.0.3.

## Goals

1. Any team member with repo access can trigger a release without setting up Windows, tokens, or submodules locally.
2. A release for one client cannot break another client's update stream.
3. Each release is traceable to a specific commit, set of submodule SHAs, and trigger.
4. The pipeline runs on free GitHub-hosted Windows runners (no self-hosted infra).
5. Same workflow handles MSI build, signing-ready packaging, and publishing to the correct client's private release repo.

## Non-Goals

- Code signing certificates / signed installers (out of scope for this iteration; can be added later as another workflow input).
- macOS or Linux builds.
- Migrating away from per-client release repos to a unified release channel.
- Automating version bumps (release manager picks the version; pipeline consumes it).
- Customer-side token management for fetching from private update repos (separate problem; out of scope here).

## Architecture Overview

```
Release Manager
      │
      │  (a) push tag `acme/v1.0.5`
      │  (b) click "Run workflow" in Actions tab, picks client + version
      ▼
GitHub Actions workflow (.github/workflows/release.yml)
      │
      │  Runs on windows-latest
      │
      ├─ Checkout zota-desktop @ tag commit
      ├─ Parse client + version from tag (or workflow_dispatch inputs)
      ├─ Read clients/<client>.json   → variant, backendBranch, frontendBranch, publish repo
      ├─ Checkout submodules at branches from client config
      │     (authenticated via GitHub App token with read access to all 3 source repos)
      ├─ Install deps, build backend + frontend + desktop
      ├─ Override package.json version with parsed version
      ├─ Run electron-builder --publish always
      │     (GH_TOKEN from same App, write-scoped to client release repos)
      └─ Post release URL as workflow summary
      │
      ▼
Client's private release repo (e.g., zota-updates-acme)
  └─ Release v1.0.5
     ├─ Zota POS Setup 1.0.5.msi
     ├─ latest.yml
     └─ Zota POS Setup 1.0.5.msi.blockmap
      │
      ▼
Installed customer apps (electron-updater on next launch)
```

## Components

### 1. Extended `clients/<name>.json` schema

The single source of truth for everything that varies per client. Today this only carries publish-repo info; it needs to also describe which code branches belong to this client.

**Current:**
```json
{
  "clientId": "acme-001",
  "clientName": "ACME Pharmacy",
  "github": { "owner": "...", "repo": "zota-updates-acme", "private": true }
}
```

**Proposed:**
```json
{
  "clientId": "acme-001",
  "clientName": "ACME Pharmacy",
  "productName": "ACME POS",
  "variant": "pos",
  "backendBranch": "client-acme",
  "frontendBranch": "client-acme",
  "github": {
    "owner": "saipranay-nextech",
    "repo": "zota-updates-acme",
    "private": true
  }
}
```

`variant`, `backendBranch`, `frontendBranch` are new. The workflow uses these to know which submodule branches to check out before building.

### 2. `.github/workflows/release.yml`

Single workflow file, two triggers:

```yaml
on:
  push:
    tags: ['*/v*']        # e.g., acme/v1.0.5
  workflow_dispatch:
    inputs:
      client:
        description: 'Client (matches clients/<name>.json)'
        required: true
        type: choice
        options: [acme, ...]   # populated from clients/ at workflow-edit time
      version:
        description: 'Version (e.g., 1.0.5)'
        required: true
      create_tag:
        description: 'Also create and push the git tag'
        type: boolean
        default: true
```

Job runs on `windows-latest`. Steps:

1. Parse `client` and `version` from tag ref (push) or inputs (dispatch).
2. Use `actions/create-github-app-token` to mint a short-lived token from the GitHub App; expose as env var.
3. `actions/checkout` with `submodules: false` (we control submodule init manually).
4. Read `clients/<client>.json`; init each submodule at its branch using the app token for git auth.
5. Run `node scripts/zota.js dist <variant> --client clients/<client>.json --version <version> --publish` (script changes below).

### 3. `scripts/zota.js` changes

Add two flags:
- `--version <x.y.z>` — temporarily rewrites `package.json`'s `version` field before build, restores after. Tag/CI controls version, not committed package.json.
- `--publish` — passes `--publish always` to electron-builder so it uploads to the configured release repo.

Also: when running in CI (`process.env.GITHUB_ACTIONS === 'true'`), `setVariantConfig()` should read `variant`, `backendBranch`, and `frontendBranch` from the client config instead of relying on the CLI's `<pos|cpos>` positional. The positional remains required for local builds for backward compatibility.

### 4. GitHub App for source repo access

One GitHub App ("Zota Release Bot") with:
- **Installed on:** `Zota-NexTech-Limited` org (covers the 3 source repos: `zota-pos-backend-ts`, `zota-cpos-backend-ts`, `zota-react-frontend`)
- **Permissions:** Contents: Read
- **App ID + private key** stored as secrets in `zota-desktop` repo: `ZOTA_BOT_APP_ID`, `ZOTA_BOT_PRIVATE_KEY`

Per-run, the workflow mints a token from the app and uses it for `git clone`/submodule init. Because `.gitmodules` currently uses SSH URLs (`git@github.com-zota:...`), the workflow rewrites those to `https://x-access-token:<token>@github.com/...` via `git config url.<https>.insteadOf <ssh>` before submodule init.

### 5. Publish tokens per client release repo

All client release repos live under the `Zota-NexTech-Limited` org, so the same GitHub App handles publishing. The App is granted Contents: Write on the release repos in addition to Contents: Read on the source repos. The minted app token is exposed as `GH_TOKEN` to the `electron-builder --publish always` step.

Any existing release repos currently on a personal account must be transferred to the org as part of rollout (or recreated under the org if transfer is impractical) before the pipeline can publish to them.

### 6. `docs/RELEASING.md`

Short team-facing doc covering:
- Tag format: `<client>/v<version>` (e.g., `acme/v1.0.5`)
- How to add a new client (extend `clients/*.json`, update workflow `choice` list, ensure release repo exists)
- How to do a hotfix (cherry-pick to client's submodule branch, push new tag)
- What to do if a release fails mid-publish

## Data Flow Per Release

1. RM bumps the right submodule branch with whatever changes they want released, ensures submodules in `zota-desktop` point at the desired SHAs, commits + pushes.
2. RM tags: `git tag acme/v1.0.5 && git push origin acme/v1.0.5`.
3. GitHub Actions runs; produces MSI; pushes release to `zota-updates-acme`.
4. Installed ACME apps poll their repo, see 1.0.5 > installed version, prompt to update (per existing `updater.ts` logic).

## Error Handling

- **Tag malformed** (e.g., `acme-1.0.5` instead of `acme/v1.0.5`): workflow fails in the parse step with a clear message.
- **Client not in `clients/`:** parse step fails, points to `docs/RELEASING.md`.
- **Submodule branch doesn't exist:** `git checkout` fails; surface the missing branch name in the workflow log.
- **electron-builder publish fails partway** (e.g., MSI uploaded, latest.yml not): re-running the workflow with the same inputs is safe — electron-builder overwrites the draft release. RM can also delete the partial release and re-run.
- **Two concurrent releases for the same client:** GitHub Actions concurrency group keyed on `client` so a second run for the same client queues behind the first.

## Testing Strategy

Manual end-to-end test before declaring the pipeline complete:

1. Create a throwaway client config (`clients/test-client.json`) pointing at a throwaway release repo owned by the same account/org.
2. Add throwaway `client-test` branches in backend and frontend submodules.
3. Push `test-client/v0.0.1` tag. Verify:
   - Workflow runs to completion on windows-latest.
   - MSI, latest.yml, blockmap appear on the test release repo.
   - Workflow also visible from manual dispatch with the same inputs.
4. Install MSI on a Windows machine, launch, confirm app opens.
5. Push `test-client/v0.0.2`; verify the installed v0.0.1 picks up the update via the existing in-app updater flow.
6. Negative tests: malformed tag, unknown client name, deliberately wrong branch name in client config — each should fail loudly in the workflow.

Unit-level tests for `scripts/zota.js` argument parsing (version flag, publish flag, client config branch reading) live alongside the script as a small Node test file.

## Migration / Rollout

1. Land the `clients/*.json` schema extension (additive, non-breaking — script falls back to current behavior if new fields absent).
2. Add `--version` and `--publish` flags to `zota.js`; verify local builds still work unchanged.
3. Set up GitHub App, install on org, store secrets.
4. Add `release.yml`. First runs use the throwaway test client.
5. Migrate ACME (and any other live clients) one at a time: update their `clients/*.json` with `variant`/`backendBranch`/`frontendBranch`, do a dry-run release using the manual-dispatch trigger with a bumped patch version, verify the release appears correctly in the client's repo, then resume normal tagged releases.
6. Document in `docs/RELEASING.md`; share with the team.
7. Deprecate local releases (`node scripts/zota.js dist ... --client ...` still works locally for emergencies but stops being the normal path).

## Open Questions

None blocking. Items to decide later (not in this iteration):
- Whether to add code signing to the workflow (likely a follow-up spec).
- Whether to publish a draft release first and require manual "publish" click, vs. always publishing immediately. Current design publishes immediately; team can switch to draft-then-publish if they want a review gate.
- How customers' installed apps authenticate to fetch from private release repos. Out of scope here — separate problem.
