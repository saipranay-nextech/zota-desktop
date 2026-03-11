import React, { useState } from 'react';
import type { SetupProgress as SetupProgressType } from '../../shared/types';

interface SetupProgressProps {
  progress: SetupProgressType | null;
}

const STEP_MESSAGES: Record<string, string> = {
  checking: 'Checking system requirements...',
  'postgres-not-found': 'PostgreSQL not found',
  'postgres-password': 'PostgreSQL authentication required',
  'downloading-postgres': 'Downloading database server...',
  'installing-postgres': 'Installing database server...',
  'creating-database': 'Setting up database...',
  'running-migrations': 'Preparing application...',
  'starting-backend': 'Starting services...',
  complete: 'Ready!',
  failed: 'Setup failed',
};

function PostgresPasswordPrompt(): React.ReactElement {
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [submitting, setSubmitting] = useState(false);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (!password.trim()) return;

    setSubmitting(true);
    setError('');

    const result = await window.electronAPI.submitPostgresPassword(password);
    if (!result.success) {
      setError(result.error || 'Invalid password');
      setSubmitting(false);
    }
  }

  return (
    <div className="container">
      <div className="card">
        <h1 className="title">Database Authentication</h1>

        <p className="subtitle" style={{ marginBottom: '1rem' }}>
          PostgreSQL is installed but requires a password to connect.
        </p>

        <form onSubmit={handleSubmit}>
          <div style={{ marginBottom: '1rem' }}>
            <label
              htmlFor="pg-password"
              style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.9rem', color: '#ccc' }}
            >
              PostgreSQL password for user &quot;postgres&quot;:
            </label>
            <input
              id="pg-password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Enter password"
              disabled={submitting}
              autoFocus
              style={{
                width: '100%',
                padding: '0.6rem 0.8rem',
                borderRadius: '6px',
                border: '1px solid #444',
                background: '#1a1a2e',
                color: '#fff',
                fontSize: '0.95rem',
                boxSizing: 'border-box',
              }}
            />
          </div>

          {error && (
            <p className="error-message" style={{ marginBottom: '0.75rem' }}>{error}</p>
          )}

          <button
            type="submit"
            className="btn btn-primary"
            style={{ width: '100%' }}
            disabled={submitting || !password.trim()}
          >
            {submitting ? 'Connecting...' : 'Connect'}
          </button>
        </form>
      </div>
    </div>
  );
}

export function SetupProgress({
  progress,
}: SetupProgressProps): React.ReactElement {
  if (!progress) {
    return (
      <div className="container">
        <div className="card" style={{ textAlign: 'center' }}>
          <div className="loading-spinner" />
          <p className="subtitle">Preparing setup...</p>
        </div>
      </div>
    );
  }

  const isFailed = progress.step === 'failed';
  const isComplete = progress.step === 'complete';
  const isPostgresPrompt = progress.step === 'postgres-not-found';
  const isPasswordPrompt = progress.step === 'postgres-password';

  if (isPasswordPrompt) {
    return <PostgresPasswordPrompt />;
  }

  // PostgreSQL not found - show download prompt
  if (isPostgresPrompt) {
    return (
      <div className="container">
        <div className="card">
          <div className="status-icon">
            <span style={{ fontSize: '2rem' }}>&#128268;</span>
          </div>

          <h1 className="title">PostgreSQL Required</h1>

          <p className="subtitle" style={{ marginBottom: '0.5rem' }}>
            PostgreSQL database server is not installed on this system.
          </p>
          <p className="subtitle" style={{ fontSize: '0.85rem', color: '#888', marginBottom: '1.5rem' }}>
            Zota CPOS needs PostgreSQL to store data locally. The download is approximately 300 MB.
          </p>

          <button
            className="btn btn-primary"
            style={{ width: '100%', marginBottom: '0.5rem' }}
            onClick={() => window.electronAPI.confirmPostgresDownload()}
          >
            Download &amp; Install PostgreSQL
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="container">
      <div className="card">
        <div className="status-icon">
          {isFailed ? (
            <span className="error-icon">X</span>
          ) : isComplete ? (
            <span className="success-icon">OK</span>
          ) : (
            <div className="loading-spinner" />
          )}
        </div>

        <h1 className="title">
          {isFailed
            ? 'Setup Failed'
            : isComplete
              ? 'Setup Complete'
              : 'Setting Up'}
        </h1>

        <p className="subtitle">
          {progress.message ||
            STEP_MESSAGES[progress.step] ||
            'Please wait...'}
        </p>

        {!isFailed && !isComplete && (
          <div className="progress-container">
            <div className="progress-bar">
              <div
                className="progress-fill"
                style={{ width: `${progress.percent}%` }}
              />
            </div>
            <div className="progress-text">
              <span>{STEP_MESSAGES[progress.step]}</span>
              <span>{progress.percent}%</span>
            </div>
          </div>
        )}

        {isFailed && progress.error && (
          <div style={{ marginTop: '1rem' }}>
            <p className="error-message">{progress.error}</p>
            <button
              className="btn btn-primary"
              style={{ marginTop: '1rem' }}
              onClick={() => window.electronAPI.startSetup()}
            >
              Retry
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
