import React from 'react';
import { createRoot } from 'react-dom/client';
import { UpdateDialog } from './components/UpdateDialog';

const root = createRoot(document.getElementById('root')!);
root.render(<UpdateDialog />);
