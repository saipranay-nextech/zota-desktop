import React, { useState, useEffect } from 'react';
import type { UpdateProgress } from '../../shared/types';

export function UpdateDialog(): React.ReactElement {
  const [progress, setProgress] = useState<UpdateProgress>({
    status: 'idle',
    percent: 0,
  });

  const [version, setVersion] = useState('');

  useEffect(() => {
    const unsubscribe = window.electronAPI.onUpdateProgress(setProgress);
    window.electronAPI.getVersion().then(setVersion);
    return unsubscribe;
  }, []);

  function handleCheckUpdate() {
    window.electronAPI.checkForUpdates();
  }

  function handleDownload() {
    window.electronAPI.downloadUpdate();
  }

  function handleInstall() {
    window.electronAPI.installUpdate();
  }

  return (
    <div className="card">
      <h2 className="title">Software Updates</h2>

      {progress.status === 'idle' && (
        <>
          <p className="subtitle">Current version: {version || '...'}</p>
          <button className="btn btn-primary" onClick={handleCheckUpdate}>
            Check for Updates
          </button>
        </>
      )}

      {progress.status === 'checking' && (
        <>
          <div className="loading-spinner" />
          <p className="subtitle">Checking for updates...</p>
        </>
      )}

      {progress.status === 'available' && progress.updateInfo && (
        <>
          <p className="subtitle">
            Version {progress.updateInfo.version} is available!
          </p>
          <div
            style={{
              margin: '1rem 0',
              fontSize: '0.875rem',
              color: 'var(--text-secondary)',
            }}
          >
            {progress.updateInfo.releaseNotes}
          </div>
          <button className="btn btn-primary" onClick={handleDownload}>
            Download Update
          </button>
        </>
      )}

      {progress.status === 'downloading' && (
        <>
          <p className="subtitle">Downloading update...</p>
          <div className="progress-container">
            <div className="progress-bar">
              <div
                className="progress-fill"
                style={{ width: `${progress.percent}%` }}
              />
            </div>
            <div className="progress-text">
              <span>Downloading...</span>
              <span>{progress.percent}%</span>
            </div>
          </div>
        </>
      )}

      {progress.status === 'downloaded' && (
        <>
          <p className="subtitle">Update ready to install</p>
          <p
            style={{
              fontSize: '0.875rem',
              color: 'var(--text-secondary)',
              marginBottom: '1rem',
            }}
          >
            The application will restart to apply the update.
          </p>
          <button className="btn btn-primary" onClick={handleInstall}>
            Install & Restart
          </button>
        </>
      )}

      {progress.status === 'error' && (
        <>
          <p className="error-message">{progress.error}</p>
          <button
            className="btn btn-secondary"
            style={{ marginTop: '1rem' }}
            onClick={handleCheckUpdate}
          >
            Try Again
          </button>
        </>
      )}
    </div>
  );
}
