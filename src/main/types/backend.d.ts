declare module '@zota/backend' {
  export interface ServerOptions {
    port?: number;
    skipMigrations?: boolean;
  }

  export function startServer(options?: ServerOptions): Promise<{
    httpServer: any;
    io: any;
    app: any;
  }>;

  export function runMigrations(): Promise<void>;
}
