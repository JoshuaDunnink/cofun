Rol:  
Je bent een senior DevOps‑engineer, front‑end architect en documentatieschrijver. Je creëert een complete, professionele workflow voor lokale ontwikkeling én automatische deployment van een statische website naar een Strato‑shared‑hostingpakket via FTP.
1. Projectcontext

Het project is een statische website (bijv. Astro, Eleventy of vergelijkbaar) voor een bedrijf dat scholen helpt om slecht presterende hoogbegaafde leerlingen weer “aan” te krijgen.
De site wordt lokaal ontwikkeld en via FTP gedeployed naar Strato.
2. Wat jij moet genereren

Genereer alle onderdelen hieronder volledig:
A. Lokale ontwikkelomgeving

Maak een complete set instructies en configuraties voor:

    installatie van Node.js (met aanbevolen versie)

    installatie van alle projectdependencies

    installatie van build‑tools

    installatie van package managers (npm of pnpm)

    lokale development server

    build‑commando’s

    folderstructuur

    environment‑bestanden (.env.example)

    scripts voor development en productie

    make file voor makkelijke uitvoer van acties

Lever ook:

    een README.md sectie “Local Development”

    troubleshooting tips

    aanbevolen VS Code extensies

    uitleg hoe GitHub Copilot gebruikt wordt binnen deze workflow

B. Deployment naar Strato (FTP)

Genereer een volledige, professionele deployment‑pipeline:

    GitHub Actions workflow die:

        code checkout

        dependencies installeert

        build draait

        outputmap (dist/ of public/) uploadt naar Strato via FTP

        secrets gebruikt (FTP_HOST, FTP_USER, FTP_PASS)

    FTP‑configuratie

        uitleg waar Strato de webroot heeft (/httpdocs/)

        hoe je credentials instelt

        hoe je een testdeployment uitvoert

    Deployment scripts

        deploy.sh (optioneel)

        fallback: handmatige FileZilla instructies

    README.md sectie “Deployment Pipeline”

        hoe de pipeline werkt

        hoe je hem triggert

        hoe je fouten debugt

C. Dependency‑beheer

Genereer een volledige lijst van:

    runtime dependencies

    dev dependencies

    build dependencies

    aanbevolen versies

    uitleg waarom deze nodig zijn

Maak ook:

    een package.json voorbeeld

    scripts zoals:

        dev

        build

        preview

        deploy

D. Omgevingsvariabelen

Genereer:

    .env.example

    uitleg hoe .env werkt in een statische site

    hoe secrets in GitHub Actions worden opgeslagen

    hoe je lokale variabelen veilig houdt

E. Documentatie

Maak een complete documentatiesectie met:

    “Getting Started”

    “Local Development”

    “Building for Production”

    “Deploying to Strato”

    “Environment Variables”

    “Troubleshooting”

    “Recommended Workflow”

3. Outputformaat

Lever de output in deze volgorde:

    Korte samenvatting van de workflow

    Volledige lokale ontwikkelsetup

    Volledige dependency‑lijst + package.json

    Volledige GitHub Actions workflow

    Volledige deployment instructies

    Volledige documentatie (README‑stijl)

    Eventuele optimalisaties of uitbreidingen

4. Kwaliteitseisen

    Gebruik duidelijke, professionele taal

    Gebruik codeblokken waar nodig

    Zorg dat alles direct uitvoerbaar is

    Maak het geschikt voor beginners én professionals

    Houd rekening met Strato‑shared‑hosting beperkingen

    Zorg dat de workflow schaalbaar is voor toekomstige uitbreidingen

5. Start nu met het genereren van de volledige lokale ontwikkelsetup en deployment‑pipeline