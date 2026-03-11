export const APP_NAME = 'Zota CPOS';
export const CONFIG_FILE_NAME = 'config.json';

export const BACKEND_PORT = 8000;
export const BACKEND_URL = `http://localhost:${BACKEND_PORT}`;

export const POSTGRES_PATHS = process.platform === 'win32'
  ? [
      'C:\\Program Files\\PostgreSQL\\16\\bin',
      'C:\\Program Files\\PostgreSQL\\15\\bin',
      'C:\\Program Files\\PostgreSQL\\14\\bin',
    ]
  : [
      '/opt/homebrew/opt/postgresql@16/bin',
      '/opt/homebrew/opt/postgresql@15/bin',
      '/opt/homebrew/opt/postgresql@14/bin',
      '/usr/local/opt/postgresql@16/bin',
      '/usr/local/opt/postgresql@15/bin',
      '/usr/local/opt/postgresql@14/bin',
      '/usr/lib/postgresql/16/bin',
      '/usr/lib/postgresql/15/bin',
      '/usr/lib/postgresql/14/bin',
    ];

export const POSTGRES_DEFAULT_PASSWORD = 'postgres';
export const DATABASE_NAME = 'customer';

export const POSTGRES_VERSION = '14.13-1';
export const POSTGRES_DOWNLOAD_URL = `https://get.enterprisedb.com/postgresql/postgresql-${POSTGRES_VERSION}-windows-x64.exe`;

export const IPC_CHANNELS = {
  // Setup
  GET_SETUP_STATUS: 'setup:get-status',
  START_SETUP: 'setup:start',
  SETUP_PROGRESS: 'setup:progress',
  CONFIRM_POSTGRES_DOWNLOAD: 'setup:confirm-postgres-download',
  SUBMIT_POSTGRES_PASSWORD: 'setup:submit-postgres-password',

  // Activation
  IS_ACTIVATED: 'activation:is-activated',
  ACTIVATE: 'activation:activate',
  GET_CONFIG: 'activation:get-config',

  // Updates
  CHECK_UPDATE: 'update:check',
  DOWNLOAD_UPDATE: 'update:download',
  INSTALL_UPDATE: 'update:install',
  UPDATE_PROGRESS: 'update:progress',

  // App
  GET_VERSION: 'app:get-version',
  QUIT_APP: 'app:quit',
  OPEN_UPDATE_WINDOW: 'app:open-update-window',
} as const;
