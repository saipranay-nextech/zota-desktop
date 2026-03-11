# Zota CPOS Desktop — Architecture

## High-Level Overview

```
┌─────────────────────────────────────────────────────────┐
│                    ELECTRON APP                          │
│                                                         │
│  ┌──────────────┐    ┌──────────────────────────────┐   │
│  │  Setup Window │    │        Main Window            │   │
│  │  (Renderer)   │    │  loads http://localhost:8000  │   │
│  │              │    │                              │   │
│  │ • Activation  │    │  ┌──────────────────────┐   │   │
│  │ • PG Install  │    │  │  React Frontend      │   │   │
│  │ • DB Setup    │    │  │  (served via Express) │   │   │
│  │ • Progress    │    │  │                      │   │   │
│  └──────┬───────┘    │  │  API → localhost:8000 │   │   │
│         │ IPC        │  │  Socket.io → :8000    │   │   │
│         ▼            │  └──────────────────────┘   │   │
│  ┌──────────────┐    └──────────────────────────────┘   │
│  │  Preload.ts   │                                       │
│  │  (IPC Bridge) │                                       │
│  └──────┬───────┘                                       │
│         │                                               │
│  ┌──────▼───────────────────────────────────────────┐   │
│  │              MAIN PROCESS (index.ts)              │   │
│  │                                                   │   │
│  │  Services:                                        │   │
│  │  ┌─────────────┐  ┌──────────────┐              │   │
│  │  │ Activation  │  │ Config       │              │   │
│  │  │ (AES-256)   │  │ (JSON file)  │              │   │
│  │  └─────────────┘  └──────────────┘              │   │
│  │  ┌─────────────┐  ┌──────────────┐              │   │
│  │  │ PG Installer│  │ DB Setup     │              │   │
│  │  │ (download)  │  │ (psql + DDL) │              │   │
│  │  └─────────────┘  └──────────────┘              │   │
│  │  ┌─────────────┐  ┌──────────────┐              │   │
│  │  │ Backend     │  │ Updater      │              │   │
│  │  │ Runner      │  │ (GitHub)     │              │   │
│  │  └──────┬──────┘  └──────────────┘              │   │
│  └─────────┼────────────────────────────────────────┘   │
└────────────┼────────────────────────────────────────────┘
             │ dynamicImport()
             ▼
┌──────────────────────┐     ┌─────────────────────────┐
│  @zota/backend       │     │  zota-react-frontend     │
│  (Express + Socket)  │     │  /build (static files)   │
│  Port 8000           │◄────│  Served via Express      │
│                      │     │  static middleware        │
│  /api/*  → routes    │     └─────────────────────────┘
│  /health → healthcheck│
│  /*      → index.html │     ┌─────────────────────────┐
│          (React SPA)  │     │  PostgreSQL              │
│                      │────►│  Database: "customer"    │
└──────────────────────┘     │  Port: 5432              │
                             └─────────────────────────┘
```

---

## Three Codebases, One Installer

| Codebase | Role | How Connected |
|----------|------|--------------|
| `zota-desktop` | Electron wrapper | Orchestrates everything |
| `zota-pos-backend-ts` | Express API + Socket.io | Loaded as `file:` npm dependency, imported via ESM `import()` |
| `zota-react-frontend` | React SPA | `build/` folder copied as `extraResources`, served via Express static |

---

## Startup Flow

```
1. app.whenReady()
   │
2. Register IPC handlers
   │
3. Create Setup Window (500x400, frameless)
   │
4. Check activation → NOT ACTIVATED?
   │                   Show ActivationScreen
   │                   Wait for ZOTA-XXXX code
   │                   ↓ (user enters code)
   │                   Decrypt AES-256-GCM
   │                   Save to config.json
   │
5. Check PostgreSQL installed?
   │   NO → Prompt download (Windows: silent NSIS install)
   │   YES ↓
   │
6. Test DB connection (default password: "postgres")
   │   AUTH FAILED → Show password prompt
   │   OK ↓
   │
7. Set env vars: DB_HOST, DB_USER, DB_PASSWORD, DB_NAME
   │
8. Create "customer" database (if not exists)
   │
9. Run migrations (via backend's runMigrations())
   │
10. Start backend: dynamicImport('@zota/backend')
    │  → backend.startServer({ port: 8000 })
    │
11. Remove backend's catch-all 404 middleware
    │
12. Mount frontend: express.static(frontendPath)
    │  + React Router catch-all (inject LAN patch scripts)
    │
13. Health check: GET http://localhost:8000/health
    │
14. Close setup window → Open main window
    │  → loadURL('http://localhost:8000')
    │
15. App is ready!
```

---

## File Structure

```
zota-desktop/src/
├── main/
│   ├── index.ts                    # Main process entry point & IPC handlers
│   ├── window.ts                   # Setup window + Main window creation
│   ├── preload.ts                  # IPC bridge (contextIsolation: true)
│   ├── services/
│   │   ├── activation.ts           # Activation code validation
│   │   ├── backend-runner.ts       # Starts Express server + serves frontend
│   │   ├── config.ts               # Persistent config (userData/config.json)
│   │   ├── crypto.ts               # AES-256-GCM encrypt/decrypt
│   │   ├── database-setup.ts       # PostgreSQL DB creation & migrations
│   │   ├── postgres-installer.ts   # PostgreSQL download & install
│   │   └── updater.ts              # Manual updates via GitHub Releases
│   ├── utils/
│   │   └── paths.ts                # Resolve ESM file:// URL for backend
│   └── types/
│       └── backend.d.ts            # TypeScript declarations for @zota/backend
├── renderer/
│   ├── index.tsx                   # React entry point
│   ├── App.tsx                     # Root component (loading → activation → setup → ready)
│   ├── index.html                  # HTML template
│   ├── styles.css                  # Global styles
│   └── components/
│       ├── ActivationScreen.tsx    # Activation code entry UI
│       ├── SetupProgress.tsx       # Multi-step setup with progress bar
│       ├── SplashScreen.tsx        # Loading spinner
│       └── UpdateDialog.tsx        # App update UI
└── shared/
    ├── constants.ts                # IPC channels, ports, paths
    └── types.ts                    # Shared TypeScript interfaces
```

---

## Services

### Activation (`activation.ts` + `crypto.ts`)
- Per-client licensing via encrypted activation codes
- Format: `ZOTA-` + base64(IV + AuthTag + AES-256-GCM encrypted JSON)
- Payload: `{ version, customerId, customerName, expiresAt }`
- Encryption key: hardcoded 32-byte key
- Saved to `config.json` on activation

### Config (`config.ts`)
- Persistent storage at `app.getPath('userData')/config.json`
- Stores: `activated`, `customerId`, `customerName`, `activatedAt`

### PostgreSQL Installer (`postgres-installer.ts`)
- Checks standard install paths (Windows + macOS/Linux)
- Downloads PostgreSQL 14.13 from EnterpriseDB (~300MB)
- Silent install: `--mode unattended --superpassword postgres`

### Database Setup (`database-setup.ts`)
- Tests connection with stored password
- Creates `customer` database via `psql` CLI
- Runs backend's `runMigrations()` for schema setup
- Supports password prompt if default auth fails

### Backend Runner (`backend-runner.ts`)
- Dynamically imports `@zota/backend` via ESM `import()`
- Starts Express + Socket.io on port 8000
- Removes backend's catch-all 404 middleware
- Mounts frontend build as `express.static`
- Injects LAN patch scripts into `index.html`:
  - Sets `localStorage.localIP` for Socket.io
  - Patches `XMLHttpRequest.open` to rewrite `localhost:8000` → actual origin
- React Router catch-all for non-API routes
- Health check polling before reporting ready

### Updater (`updater.ts`)
- Manual check/download via `electron-updater`
- Publishes to GitHub Releases (per-client repos)
- Events sent to renderer: checking → available → downloading → downloaded

---

## IPC Channels (Preload Bridge)

| Channel | Direction | Purpose |
|---------|-----------|---------|
| `activation:is-activated` | Renderer → Main | Check activation status |
| `activation:activate` | Renderer → Main | Submit activation code |
| `activation:get-config` | Renderer → Main | Get app config |
| `setup:get-status` | Renderer → Main | Get setup status |
| `setup:start` | Renderer → Main | Start setup process |
| `setup:progress` | Main → Renderer | Setup progress events |
| `setup:confirm-postgres-download` | Renderer → Main | Confirm PostgreSQL download |
| `setup:submit-postgres-password` | Renderer → Main | Submit PostgreSQL password |
| `update:check` | Renderer → Main | Check for updates |
| `update:download` | Renderer → Main | Download update |
| `update:install` | Renderer → Main | Install and restart |
| `update:progress` | Main → Renderer | Update progress events |
| `app:get-version` | Renderer → Main | Get app version |
| `app:quit` | Renderer → Main | Quit application |

---

## Build Pipeline

```bash
npm run build
  ├── build:main      → tsc (TypeScript → CommonJS)      → dist/main/
  ├── build:preload   → esbuild (bundle for Node)        → dist/main/main/preload.js
  ├── build:renderer  → esbuild (bundle for Chrome 108)  → dist/renderer/index.js
  └── copy-assets     → index.html + styles.css          → dist/renderer/

npx electron-builder --win
  → Packages dist/ + node_modules + extraResources (frontend build)
  → Creates NSIS installer (.exe)
  → asar: false (ESM can't resolve across asar boundary)
```

---

## Key Technical Decisions

| Decision | Reason |
|----------|--------|
| `asar: false` | ESM module resolution doesn't work across asar/asar.unpacked boundary |
| `new Function('specifier', 'return import(specifier)')` | TypeScript compiles `import()` to `require()` which can't load ESM modules |
| esbuild for preload | tsc output uses `require('../shared/...')` which breaks inside asar |
| `bcryptjs` over `bcrypt` | Native `bcrypt` has platform-specific binaries that fail cross-platform |
| `!app.isPackaged` over `electron-is-dev` | `electron-is-dev` namespace import is always truthy |
| Frontend served via Express (not `file://`) | `file://` protocol breaks Razorpay checkout, `fetch()` API calls, and Socket.io |
| PostgreSQL downloaded at runtime | Saves ~300MB from installer size |
| `require.resolve('@zota/backend')` + `pathToFileURL` | Reliable backend path resolution in both dev and packaged modes |

---

## LAN Access

Any device on the same network can access the app at `http://<host-ip>:8000`.

- Backend already listens on `0.0.0.0` (Node.js default)
- Injected scripts handle the frontend's hardcoded `localhost:8000`:
  - `localStorage.localIP` → Socket.io reconnects to LAN IP
  - `XMLHttpRequest.open` patched → axios API calls rewritten to actual origin
- No frontend or backend code changes required

---

## Environment Variables (Set by Electron before backend import)

```
DB_HOST=localhost
DB_USER=postgres
DB_PASSWORD=<user-provided or "postgres">
DB_NAME=customer
db_port=5432
```
