import React, { useState } from 'react';

interface ActivationScreenProps {
  onActivate: (code: string) => Promise<{ success: boolean; error?: string }>;
}

export function ActivationScreen({
  onActivate,
}: ActivationScreenProps): React.ReactElement {
  const [code, setCode] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);
    setError(null);

    const result = await onActivate(code.trim());

    if (!result.success) {
      setError(result.error || 'Activation failed');
      setLoading(false);
    }
  }

  return (
    <div className="container">
      <div className="card">
        <h1 className="title">Welcome to Zota CPOS</h1>
        <p className="subtitle">Enter your activation code to get started</p>

        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="activation-code">Activation Code</label>
            <textarea
              id="activation-code"
              value={code}
              onChange={(e) => setCode(e.target.value)}
              placeholder="ZOTA-xxxx..."
              disabled={loading}
            />
            {error && <p className="error-message">{error}</p>}
          </div>

          <button
            type="submit"
            className="btn btn-primary"
            disabled={loading || !code.trim()}
          >
            {loading ? 'Activating...' : 'Activate'}
          </button>
        </form>
      </div>
    </div>
  );
}
