import React, { useState, useEffect } from 'react';
import { SplashScreen } from './components/SplashScreen';
import { ActivationScreen } from './components/ActivationScreen';
import { SetupProgress } from './components/SetupProgress';
import type { SetupProgress as SetupProgressType } from '../shared/types';

type AppMode = 'loading' | 'activation' | 'setup' | 'ready';

function App(): React.ReactElement {
  const [mode, setMode] = useState<AppMode>('loading');
  const [setupProgress, setSetupProgress] =
    useState<SetupProgressType | null>(null);

  useEffect(() => {
    checkInitialState();
  }, []);

  useEffect(() => {
    const unsubscribe = window.electronAPI.onSetupProgress((progress) => {
      setSetupProgress(progress);
    });

    return unsubscribe;
  }, []);

  async function checkInitialState() {
    try {
      const isActivated = await window.electronAPI.isActivated();

      if (!isActivated) {
        setMode('activation');
      } else {
        setMode('setup');
      }
    } catch (error) {
      console.error('Failed to check initial state:', error);
      setMode('activation');
    }
  }

  async function handleActivate(
    code: string
  ): Promise<{ success: boolean; error?: string }> {
    const result = await window.electronAPI.activate(code);

    if (result.success) {
      setMode('setup');
    }

    return result;
  }

  if (mode === 'loading') {
    return <SplashScreen message="Loading..." />;
  }

  if (mode === 'activation') {
    return <ActivationScreen onActivate={handleActivate} />;
  }

  if (mode === 'setup') {
    return <SetupProgress progress={setupProgress} />;
  }

  return <SplashScreen message="Starting application..." />;
}

export default App;
