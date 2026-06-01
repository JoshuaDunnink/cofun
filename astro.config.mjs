import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://cofun.nl/cofun/__development/',
  base: '/cofun/__development/',
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
  integrations: [
    tailwind({ applyBaseStyles: false }),
    sitemap({
      i18n: {
        defaultLocale: 'nl',
        locales: { nl: 'nl-NL', en: 'en-US' },
      },
    }),
  ],
});
