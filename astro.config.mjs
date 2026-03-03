import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://cofun.nl',
  output: 'static',
  build: {
    assets: '_assets',
  },
  i18n: {
    defaultLocale: 'nl',
    locales: ['nl', 'en'],
    routing: {
      prefixDefaultLocale: false,
    },
  },
  vite: {
    css: {
      preprocessorOptions: {},
    },
  },
});
