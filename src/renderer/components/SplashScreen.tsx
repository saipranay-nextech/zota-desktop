import React from 'react';

interface SplashScreenProps {
  message: string;
}

export function SplashScreen({ message }: SplashScreenProps): React.ReactElement {
  return (
    <div className="container">
      <div className="card" style={{ textAlign: 'center' }}>
        <div className="loading-spinner" />
        <p className="subtitle">{message}</p>
      </div>
    </div>
  );
}
