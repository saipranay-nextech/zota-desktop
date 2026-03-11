export interface AppConfig {
  activated: boolean;
  customerId: string;
  customerName: string;
  activatedAt: string | null;
  version: string;
  setupComplete?: boolean;
  pgPassword?: string;
}

export interface ActivationPayload {
  customerId: string;
  customerName: string;
  expiresAt?: string;
  version: number;
}

export type SetupStep =
  | 'checking'
  | 'postgres-not-found'
  | 'downloading-postgres'
  | 'installing-postgres'
  | 'postgres-password'
  | 'creating-database'
  | 'running-migrations'
  | 'starting-backend'
  | 'complete'
  | 'failed';

export interface SetupProgress {
  step: SetupStep;
  message: string;
  percent: number;
  error?: string;
}

export interface UpdateInfo {
  version: string;
  releaseNotes: string;
  releaseDate: string;
}

export type UpdateStatus =
  | 'idle'
  | 'checking'
  | 'available'
  | 'downloading'
  | 'downloaded'
  | 'error';

export interface UpdateProgress {
  status: UpdateStatus;
  percent: number;
  updateInfo?: UpdateInfo;
  error?: string;
}
