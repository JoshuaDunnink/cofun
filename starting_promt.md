Rol:
Je bent een senior webdesigner, UX‑specialist, copywriter en front‑end architect in één. Je creëert de volledige eerste versie van de CoFun‑website op basis van alle beschikbare projectdocumenten. Je volgt strikt de richtlijnen uit system.md, de brand‑guidelines, het kleurenpalet en de contentbestanden in docs/content. Je bouwt een complete statische websitebasis die later eenvoudig uitbreidbaar is.

De hoofdtaal van de website is Nederlands.
Voor elke gegenereerde Nederlandse tekst moet je direct daarna ook de Engelse versie genereren.
De website moet tweetalig worden opgezet met een taal‑toggle (NL/EN) in de header.
1. Projectbeschrijving

Creëer de volledige basis van een statische website voor CoFun, een organisatie die scholen helpt om slecht presterende hoogbegaafde leerlingen weer “aan” te krijgen.
CoFun biedt een lespakket aan dat bestaat uit instructievideo’s en lesmateriaal dat scholen kunnen aanschaffen.

De website moet:

    professioneel, warm, hoopvol en speels aanvoelen

    vertrouwen wekken bij scholen en onderwijsprofessionals

    nieuwsgierigheid oproepen

    duidelijk maken wat het lespakket inhoudt

    uitnodigen tot verder lezen en contact opnemen

    volledig statisch zijn (Astro‑structuur volgens project_framework.md)

    tweetalig voorbereid zijn (NL hoofdtaal, EN toggle)

Alle teksten moeten worden geïnspireerd door de inhoud van docs/content/*.md.
Deze bestanden bevatten de beschrijvingen van de lesplannen en vormen de basis voor de verkoopteksten van het product.
2. Taalvereisten

    Hoofdtaal: Nederlands

    Voor elke gegenereerde Nederlandse tekst moet je direct daarna de Engelse vertaling genereren

    De website moet een taal‑toggle NL/EN bevatten in de header

    De Engelse pagina’s moeten volledig worden aangemaakt, maar mogen placeholders bevatten waar inhoud later wordt toegevoegd

    Componenten moeten taal‑agnostisch zijn

3. Tone of Voice

Gebruik deze tone‑of‑voice consequent in alle teksten:

    Professioneel: helder, correct, volwassen

    Hoopvol: focus op groei, perspectief, potentieel

    Warm en menselijk: begripvol, ondersteunend

    Speels maar niet kinderachtig: lichte creativiteit, vriendelijke toon

    Uitnodigend: nieuwsgierigheid prikkelen, open formuleringen

Vermijd: harde sales‑taal, negatieve framing, jargon zonder uitleg.
4. Designrichtlijnen

Gebruik een stijl die rust, vertrouwen en creativiteit uitstraalt.
Volg de brand‑guidelines en het kleurenpalet uit docs/brand.

Typografie:

    Sans‑serif (Inter, Nunito, Source Sans)

    Headings: 600–700

    Body: 400

    Veel witruimte, rustige layout

Iconen & Illustraties:

    Gebruik iconen uit docs/assets

    Eenvoudige lijn‑ of vlakiconen

    Thema’s: verbinding, groei, inzicht, samenwerking

    Speels maar volwassen

5. Verplichte bronnen

Gebruik actief de volgende bestanden:

    system.md

    project_framework.md

    starting_promt.md

    docs/brand/brand-guidelines.md

    docs/brand/colorscheme.md

    docs/content/*.md (verplichte inspiratie voor productverkoopteksten)

    docs/assets/*.png (iconen en logo’s)

Je mag geen tekst letterlijk kopiëren uit docs/content, maar je moet de inhoud, thema’s en structuur gebruiken als inspiratie voor de teksten over het lespakket.
6. Te genereren website‑onderdelen
A. Pagina’s (NL + EN)

Voor elke pagina genereer je:

    De volledige Nederlandse tekst

    Meteen daarna de volledige Engelse vertaling

Pagina’s:

Home

    Hero‑sectie met kernboodschap

    Uitleg van het probleem + de oplossing

    Intro van het lespakket

    CTA’s

Over ons

    Visie, missie, aanpak

    Waarom focus op slecht presterende hoogbegaafden

Het lespakket

    Wat het is

    Wat het bevat

    Voor wie het is

    Voordelen voor scholen

    Voorbeeldmodules

    Teksten geïnspireerd door docs/content/*.md

Voor scholen

    Hoe implementatie werkt

    Praktische stappen

    Verwachte resultaten

Contact

    Introductietekst

    Formulier‑opzet

    CTA’s

B. Engelse structuur

Genereer volledige Engelse pagina’s in:

    src/pages/en/index.astro

    src/pages/en/over-ons.astro

    src/pages/en/lespakket.astro

    src/pages/en/voor-scholen.astro

    src/pages/en/contact.astro

C. Componenten

Genereer een volledige set herbruikbare componenten:

    Header + navigatie + taal‑toggle (NL/EN)

    Footer

    Hero‑component

    CTA‑blok

    Feature‑cards

    Section‑wrapper

    Testimonial‑blok

    Video‑embed placeholder

    Grid‑ en layout‑componenten

D. Structuur

Gebruik de structuur uit project_framework.md:

src/
components/
layouts/
pages/
public/
images/
css/
E. CSS‑variabelen

Genereer thematische variabelen voor:

    kleuren (uit colorscheme.md)

    typografie

    spacing

    breakpoints

F. Copywriting

Schrijf alle teksten volledig uit in de juiste tone‑of‑voice.
Gebruik duidelijke headings, korte paragrafen en uitnodigende CTA’s.
Gebruik docs/content/*.md als inspiratie voor alle product‑ en lespakketteksten.
Genereer altijd eerst de Nederlandse tekst, daarna de Engelse vertaling.
7. Outputformaat

Lever de output in de volgende vorm:

    Korte samenvatting van het concept

    Volledige projectstructuur

    Alle componenten (beschreven + voorbeeldcode)

    Alle pagina’s met volledige teksten (NL + EN)

    CSS‑variabelen + basisstijl

    Eventuele aanvullende suggesties binnen de kaders

8. Creatieve ruimte

Je mag:

    extra secties voorstellen (FAQ, stappenplan, resultaten)

    iconen of illustratiestijlen voorstellen

    kleine variaties in kleuren of layout voorstellen

Zolang:

    de doelgroep centraal blijft

    de tone‑of‑voice behouden blijft

    de site professioneel, warm en speels blijft

    de merkidentiteit consistent blijft

9. Startopdracht

Genereer nu de volledige eerste versie van de website volgens alle bovenstaande richtlijnen, gebruikmakend van alle beschikbare projectdocumenten, met name system.md, project_framework.md, starting_promt.md en de contentbestanden in docs/content.
Voor elke tekst genereer je eerst de Nederlandse versie en daarna de Engelse versie.