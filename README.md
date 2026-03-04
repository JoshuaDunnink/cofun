# CoFun Spelend beter leren

Statische website voor CoFun, een organisatie die scholen helpt om slecht presterende hoogbegaafde leerlingen weer "aan" te krijgen. Gebouwd met [Astro](https://astro.build).

---

## Getting Started

### Vereisten

- **Node.js** ≥ 22 (aanbevolen: v22 LTS)
- **npm** ≥ 10

### Installatie

```bash
git clone <repository-url>
cd cofun
npm install
```

---

## Local Development

Start de ontwikkelserver:

```bash
npm run dev
# of
make dev
```

De site is beschikbaar op `http://localhost:4321`.

### Beschikbare scripts

| Commando          | Beschrijving                     |
| ----------------- | -------------------------------- |
| `npm run dev`     | Start de lokale ontwikkelserver  |
| `npm run build`   | Bouw de site voor productie      |
| `npm run preview` | Preview de productiebuild lokaal |
| `npm run format`  | Format code met Prettier         |
| `npm run lint`    | Controleer formatting            |

### Makefile

Je kunt ook `make` gebruiken:

```bash
make dev        # Ontwikkelserver
make build      # Productie-build
make preview    # Preview
make deploy     # Deploy naar Strato
make release    # Build + deploy
make clean      # Verwijder build-output
```

---

## Project Structure

```
cofun/
├── .copilot/             # AI system prompt
├── .github/workflows/    # GitHub Actions (FTP deploy)
├── docs/                 # Brand guidelines, content, assets
│   ├── assets/           # Logo's en iconen
│   ├── brand/            # Brand guidelines en kleurenpalet
│   └── content/          # Lesmateriaal (inspiratiebron)
├── public/               # Statische bestanden (images, favicon)
├── src/
│   ├── components/       # Herbruikbare Astro-componenten
│   ├── i18n/             # Vertalingen (NL/EN)
│   ├── layouts/          # Pagina-layouts
│   ├── pages/            # Pagina's (NL root, EN in /en/)
│   └── styles/           # CSS variabelen en global styles
├── astro.config.mjs      # Astro configuratie
├── package.json
├── tsconfig.json
├── Makefile
└── deploy.sh             # Handmatig FTP deploy script
```

---

## Building for Production

```bash
npm run build
```

De output verschijnt in `dist/`. Dit is de map die naar Strato wordt geüpload.

---

## Deploying to Strato

### Automatisch (GitHub Actions)

De pipeline in `.github/workflows/deploy.yml` draait automatisch bij een push naar `main`.

**Secrets instellen in GitHub:**

1. Ga naar je repository → Settings → Secrets and variables → Actions
2. Voeg toe:
   - `FTP_HOST` je Strato FTP-hostnaam
   - `FTP_USER` je FTP-gebruikersnaam
   - `FTP_PASS` je FTP-wachtwoord

De workflow:

1. Checkout code
2. Installeert dependencies
3. Bouwt de site
4. Uploadt `dist/` naar `/httpdocs/` op Strato

### Handmatig (deploy.sh)

```bash
cp .env.example .env
# Vul je FTP-credentials in .env
make deploy
```

### Handmatig (FileZilla)

1. Open FileZilla
2. Verbind met je Strato FTP-server
3. Upload de inhoud van `dist/` naar `/httpdocs/`

---

## Environment Variables

Kopieer `.env.example` naar `.env` en vul je gegevens in:

```bash
cp .env.example .env
```

| Variabele        | Beschrijving                    |
| ---------------- | ------------------------------- |
| `FTP_HOST`       | Strato FTP-hostnaam             |
| `FTP_USER`       | FTP-gebruikersnaam              |
| `FTP_PASS`       | FTP-wachtwoord                  |
| `FTP_REMOTE_DIR` | Webroot (standaard: /httpdocs/) |
| `SITE_URL`       | Publieke URL van de site        |

**Let op:** `.env` staat in `.gitignore` en wordt nooit gecommit.

---

## Tweetaligheid (NL / EN)

- Hoofdtaal: **Nederlands** (root `/`)
- Engelse pagina's: `/en/`
- Taal-toggle in de header
- Vertalingen in `src/i18n/translations.ts`

---

## Troubleshooting

| Probleem               | Oplossing                                            |
| ---------------------- | ---------------------------------------------------- |
| Port 4321 bezet        | `npx kill-port 4321` of gebruik `--port 3000`        |
| Build faalt            | Check `npm run build` output, verifieer imports      |
| FTP deploy mislukt     | Controleer credentials in `.env` of GitHub Secrets   |
| Styles niet zichtbaar  | Controleer of `global.css` is geïmporteerd in layout |
| Afbeeldingen ontbreken | Check of assets in `public/images/` staan            |

---

## Recommended Workflow

1. Ontwikkel lokaal met `make dev`
2. Check formatting: `make lint`
3. Preview productie: `make build && make preview`
4. Commit en push naar `main`
5. GitHub Actions deployt automatisch naar Strato

---

## Aanbevolen VS Code Extensies

- [Astro](https://marketplace.visualstudio.com/items?itemName=astro-build.astro-vscode)
- [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
- [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=github.copilot)

---

## Gebruik van GitHub Copilot

Dit project bevat een AI system prompt in `.copilot/system.md`. Deze stuurt Copilot aan op basis van:

- Merkidentiteit en tone-of-voice
- Kleurenpalet en visuele stijl
- Componentbibliotheek en naamconventies
- Contentrichtlijnen

Copilot gebruikt deze context automatisch bij het genereren van code en teksten binnen dit project.

---

## Licentie

© 2026 CoFun. Alle rechten voorbehouden.
