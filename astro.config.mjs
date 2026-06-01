import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import sitemap from '@astrojs/sitemap';

const deployEnv = process.env.DEPLOY_ENV ?? 'production';
const isStaging = deployEnv === 'staging';

const defaultBase = isStaging ? '/cofun/__development/' : '/';
const base = process.env.BASE_PATH ?? defaultBase;
const site = process.env.SITE_URL ?? (isStaging ? 'https://cofun.nl/cofun/__development/' : 'https://cofun.nl');

export default defineConfig({
  site,
  base,
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
