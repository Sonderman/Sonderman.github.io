// Surum numarasi build sirasinda vite.config.js tarafindan package.json'ten enjekte edilir.
export const APP_VERSION = typeof __APP_VERSION__ === 'undefined' ? 'dev' : __APP_VERSION__;

export const APP_VERSION_LABEL = `v${APP_VERSION}`;
