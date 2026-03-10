/* ==========================================================================
   CoFun   i18n Translation Utility
   ========================================================================== */

export type Locale = "nl" | "en";

export const defaultLocale: Locale = "nl";
export const locales: Locale[] = ["nl", "en"];

export const translations = {
  nl: {
    /* ── Navigation ─────────────────────────────────────────────────────── */
    "nav.home": "Home",
    "nav.about": "Over ons",
    "nav.curriculum": "Het lespakket",
    "nav.schools": "Voor scholen",
    "nav.contact": "Contact",

    /* ── Hero ───────────────────────────────────────────────────────────── */
    "hero.home.title": "Spelend beter leren",
    "hero.home.subtitle":
      "CoFun helpt scholen om slecht presterende hoogbegaafde leerlingen weer in beweging te krijgen   met plezier, inzicht en verbinding.",
    "hero.home.cta": "Ontdek het lespakket",
    "hero.home.cta_secondary": "Meer over onze aanpak",

    /* ── Home Page ──────────────────────────────────────────────────────── */
    "home.problem.title": "Het probleem herkennen",
    "home.problem.text":
      "Hoogbegaafde leerlingen die vastlopen in het onderwijs vormen een groeiende uitdaging. Ze presteren onder hun niveau, verliezen motivatie of vallen stil. Niet omdat ze het niet kunnen   maar omdat de juiste aansluiting ontbreekt.",
    "home.solution.title": "Onze oplossing",
    "home.solution.text":
      "CoFun biedt een bewezen lespakket dat spelenderwijs de cognitieve en executieve functies van leerlingen versterkt. Door te werken vanuit de basis   met spel, observatie en reflectie   komen leerlingen weer in beweging.",
    "home.intro.title": "Wat is CoFun?",
    "home.intro.text":
      "CoFun staat voor Cognitieve Functies en verbindt wetenschappelijke inzichten met de dagelijkse onderwijspraktijk. Ons lespakket biedt leerkrachten concrete handvatten om hoogbegaafde leerlingen te begeleiden in hun ontwikkeling.",
    "home.features.title": "Waarom CoFun werkt",
    "home.feature.play.title": "Spelend leren",
    "home.feature.play.text":
      "Kinderen leren het best door te doen. Ons lespakket gebruikt spel als krachtig middel om cognitieve functies te ontwikkelen.",
    "home.feature.insight.title": "Inzicht in denken",
    "home.feature.insight.text":
      "Door te observeren en te reflecteren krijgen leerkrachten inzicht in de denkprocessen van hun leerlingen.",
    "home.feature.growth.title": "Groei van binnenuit",
    "home.feature.growth.text":
      "We werken aan het fundament. Door de basisfuncties te versterken, ontstaat ruimte voor hogere executieve vaardigheden.",
    "home.feature.connection.title": "Verbinding maken",
    "home.feature.connection.text":
      "CoFun creëert een veilige omgeving waarin kinderen weer durven, willen en kunnen leren.",
    "home.cta.title": "Klaar om het verschil te maken?",
    "home.cta.text":
      "Ontdek hoe CoFun uw school kan ondersteunen bij het begeleiden van hoogbegaafde leerlingen.",
    "home.cta.button": "Neem contact op",

    /* ── About Page ─────────────────────────────────────────────────────── */
    "hero.about.title": "Over CoFun",
    "hero.about.subtitle":
      "Wij geloven dat elk kind het verdient om gezien te worden in wie het is én wat het kan.",
    "about.vision.title": "Onze visie",
    "about.vision.text":
      "Elk kind beschikt over uniek potentieel. Wanneer een hoogbegaafde leerling vastloopt, is dat zelden een kwestie van onvermogen. Het is een signaal dat de juiste aansluiting ontbreekt. Wij geloven dat door te investeren in het fundament   de cognitieve en executieve bouwstenen   kinderen weer in beweging komen.",
    "about.mission.title": "Onze missie",
    "about.mission.text":
      "CoFun maakt wetenschappelijke inzichten over cognitieve ontwikkeling toegankelijk voor het onderwijs. Met ons lespakket bieden we leerkrachten praktische, speelse en bewezen methoden om hoogbegaafde leerlingen te begeleiden. We observeren, reflecteren en bouwen   stap voor stap.",
    "about.approach.title": "Onze aanpak",
    "about.approach.text":
      "We volgen de omgekeerde piramide: in plaats van direct te werken aan de executieve functie waar een kind moeite mee heeft, versterken we de onderliggende cognitieve bouwstenen. Door spel, gerichte speelse activiteiten ontstaat ruimte voor groei van binnenuit.",
    "about.why.title": "Waarom hoogbegaafde leerlingen?",
    "about.why.text":
      "Hoogbegaafde kinderen die onder hun niveau presteren worden vaak niet herkend of begrepen. Ze kunnen gedragsproblemen vertonen, zich terugtrekken of juist opvallen door frustratie. CoFun helpt om deze leerlingen weer aan te sluiten bij hun eigen potentieel   spelend, denkend en groeiend.",

    /* ── Curriculum Page ────────────────────────────────────────────────── */
    "hero.curriculum.title": "Het lespakket",
    "hero.curriculum.subtitle":
      "Een praktisch en wetenschappelijk onderbouwd lespakket dat leerkrachten handvatten geeft om hoogbegaafde leerlingen spelenderwijs te begeleiden.",
    "curriculum.what.title": "Wat is het lespakket?",
    "curriculum.what.text":
      "Het CoFun-lespakket is een complete set lesbrieven, instructievideo's en spelmateriaal waarmee leerkrachten gericht kunnen werken aan de cognitieve en executieve functies van leerlingen. Elk onderdeel is zorgvuldig opgebouwd volgens de omgekeerde piramide.",
    "curriculum.contains.title": "Wat bevat het?",
    "curriculum.contains.videos": "Instructievideo's per leeftijdsgroep",
    "curriculum.contains.briefs":
      "Uitgebreide lesbrieven met observatiehandvatten",
    "curriculum.contains.games":
      "Spelmateriaal afgestemd op cognitieve bouwstenen",
    "curriculum.contains.reflection":
      "Reflectietools voor leerkrachten en leerlingen",
    "curriculum.contains.guide": "Handleiding voor implementatie in de klas",
    "curriculum.who.title": "Voor wie?",
    "curriculum.who.text":
      "Het lespakket is ontworpen voor leerkrachten, intern begeleiders en zorgcoördinatoren die werken met hoogbegaafde leerlingen in het primair onderwijs. Het is geschikt voor groep 1-2, groep 3-4-5 en groep 6-7-8.",
    "curriculum.groups.12.title": "Groep 1-2",
    "curriculum.groups.12.subtitle": "Kinderen van 4 – 6 jaar",
    "curriculum.groups.12.text":
      "Speelse activiteiten die de basis leggen voor waarneming, nauwkeurigheid en het leggen van relaties. Door middel van spel ontdekken jonge kinderen hun cognitieve bouwstenen.",
    "curriculum.groups.345.title": "Groep 3-4-5",
    "curriculum.groups.345.subtitle": "Kinderen van 7 – 9 jaar",
    "curriculum.groups.345.text":
      "Gerichte oefeningen die voortbouwen op de basis. Kinderen leren bewust om te gaan met vergelijken, elimineren en selecteren   altijd via spel en reflectie.",
    "curriculum.groups.678.title": "Groep 6-7-8",
    "curriculum.groups.678.subtitle": "Kinderen van 10 – 12 jaar",
    "curriculum.groups.678.text":
      "Uitdagende opdrachten die metacognitief bewustzijn stimuleren. Leerlingen leren hun eigen denkstappen te benoemen en strategieën bewust in te zetten.",
    "curriculum.benefits.title": "Voordelen voor uw school",
    "curriculum.benefit.1":
      "Wetenschappelijk onderbouwd en praktisch toepasbaar",
    "curriculum.benefit.2": "Direct inzetbaar in de dagelijkse lespraktijk",
    "curriculum.benefit.3":
      "Geschikt voor alle leerjaren in het primair onderwijs",
    "curriculum.benefit.4":
      "Bevordert zelfinzicht en metacognitie bij leerlingen",
    "curriculum.benefit.5":
      "Ondersteunt leerkrachten bij het observeren en begeleiden",
    "curriculum.cta.title": "Het lespakket aanschaffen",
    "curriculum.cta.text":
      "Wilt u het CoFun-lespakket inzetten op uw school? Neem contact met ons op voor meer informatie of een vrijblijvend gesprek.",
    "curriculum.cta.button": "Neem contact op",

    /* ── Schools Page ───────────────────────────────────────────────────── */
    "hero.schools.title": "Voor scholen",
    "hero.schools.subtitle":
      "Van eerste kennismaking tot succesvolle implementatie   wij begeleiden uw school bij elk stap.",
    "schools.how.title": "Hoe werkt de implementatie?",
    "schools.how.text":
      "Het CoFun-lespakket kan eenvoudig worden geïntegreerd in uw bestaande onderwijspraktijk. Wij bieden ondersteuning bij elke stap van het traject.",
    "schools.step.1.title": "Kennismaking",
    "schools.step.1.text":
      "We bespreken de situatie op uw school en de behoeften van uw team. Samen kijken we hoe CoFun het best kan aansluiten.",
    "schools.step.2.title": "Introductie & training",
    "schools.step.2.text":
      "Leerkrachten maken kennis met de methode, de materialen en de achterliggende visie. Ze ervaren zelf wat leerlingen straks gaan doen.",
    "schools.step.3.title": "Uitvoering in de klas",
    "schools.step.3.text":
      "Met de lesbrieven en video's als leidraad gaan leerkrachten aan de slag. Observeren, begeleiden en reflecteren staan centraal.",
    "schools.step.4.title": "Evaluatie & groei",
    "schools.step.4.text":
      "Samen evalueren we de voortgang en bespreken we observaties. Zo ontstaat een continu proces van groei   voor leerlingen én voor het team.",
    "schools.results.title": "Wat kunt u verwachten?",
    "schools.result.1":
      "Leerlingen die weer betrokken raken en in beweging komen",
    "schools.result.2":
      "Leerkrachten die met meer inzicht en vertrouwen begeleiden",
    "schools.result.3": "Een schoolbrede aanpak voor hoogbegaafdheid",
    "schools.result.4":
      "Zichtbare groei in cognitieve en executieve vaardigheden",
    "schools.cta.title": "Samen aan de slag?",
    "schools.cta.text":
      "Wij denken graag met u mee over de beste aanpak voor uw school. Neem contact op voor een vrijblijvend kennismakingsgesprek.",
    "schools.cta.button": "Plan een gesprek",

    /* ── Contact Page ───────────────────────────────────────────────────── */
    "hero.contact.title": "Contact",
    "hero.contact.subtitle":
      "We horen graag van u. Stel uw vraag, deel uw situatie of plan een kennismakingsgesprek.",
    "contact.intro.title": "Laten we kennismaken",
    "contact.intro.text":
      "Of u nu meer wilt weten over het lespakket, een vraag heeft over implementatie of gewoon nieuwsgierig bent   wij staan voor u klaar. Stuur ons een email op info@cofun.nl en we nemen zo snel mogelijk contact met u op.",
    "contact.form.name": "Naam",
    "contact.form.email": "E-mailadres",
    "contact.form.school": "Schoolnaam",
    "contact.form.role": "Uw functie",
    "contact.form.message": "Uw bericht",
    "contact.form.submit": "Verstuur bericht",
    "contact.form.privacy":
      "Wij gaan zorgvuldig om met uw gegevens. Uw informatie wordt uitsluitend gebruikt om contact met u op te nemen.",

    /* ── Footer ─────────────────────────────────────────────────────────── */
    "footer.tagline": "Spelend beter leren   voor elke hoogbegaafde leerling.",
    "footer.nav": "Navigatie",
    "footer.contact": "Contact",
    "footer.email": "info@cofun.nl",
    "footer.copyright": "© 2026 CoFun. Alle rechten voorbehouden.",
    "footer.construction": "Website in aanbouw. Meer content op komst.",
    /* ── Misc ───────────────────────────────────────────────────────────── */
    "testimonial.coming": "Ervaringen van scholen volgen binnenkort.",
    "video.placeholder": "Video komt binnenkort beschikbaar.",
    "lang.switch": "EN",
  },

  en: {
    /* ── Navigation ─────────────────────────────────────────────────────── */
    "nav.home": "Home",
    "nav.about": "About us",
    "nav.curriculum": "The curriculum",
    "nav.schools": "For schools",
    "nav.contact": "Contact",

    /* ── Hero ───────────────────────────────────────────────────────────── */
    "hero.home.title": "Learning through play",
    "hero.home.subtitle":
      "CoFun helps schools get underperforming gifted students back on track   through play, insight and connection.",
    "hero.home.cta": "Discover the curriculum",
    "hero.home.cta_secondary": "More about our approach",

    /* ── Home Page ──────────────────────────────────────────────────────── */
    "home.problem.title": "Recognising the problem",
    "home.problem.text":
      "Gifted students who are stuck present a growing challenge in education. They underperform, lose motivation or shut down. Not because they lack ability   but because the right connection is missing.",
    "home.solution.title": "Our solution",
    "home.solution.text":
      "CoFun offers a proven curriculum that strengthens students' cognitive and executive functions through play. By working from the foundation   with games, observation and reflection   students start moving again.",
    "home.intro.title": "What is CoFun?",
    "home.intro.text":
      "CoFun stands for Cognitive Functions and bridges scientific insights with daily educational practice. Our curriculum provides teachers with practical tools to guide gifted students in their development.",
    "home.features.title": "Why CoFun works",
    "home.feature.play.title": "Learning through play",
    "home.feature.play.text":
      "Children learn best by doing. Our curriculum uses play as a powerful means to develop cognitive functions.",
    "home.feature.insight.title": "Insight into thinking",
    "home.feature.insight.text":
      "Through observation and reflection, teachers gain insight into the thought processes of their students.",
    "home.feature.growth.title": "Growth from within",
    "home.feature.growth.text":
      "We work on the foundation. By strengthening basic functions, space for higher executive skills emerges naturally.",
    "home.feature.connection.title": "Creating connection",
    "home.feature.connection.text":
      "CoFun creates a safe environment where children dare, want and can learn again.",
    "home.cta.title": "Ready to make a difference?",
    "home.cta.text":
      "Discover how CoFun can support your school in guiding gifted students.",
    "home.cta.button": "Get in touch",

    /* ── About Page ─────────────────────────────────────────────────────── */
    "hero.about.title": "About CoFun",
    "hero.about.subtitle":
      "We believe every child deserves to be seen for who they are and what they can achieve.",
    "about.vision.title": "Our vision",
    "about.vision.text":
      "Every child has unique potential. When a gifted student gets stuck, it is rarely a matter of inability. It is a signal that the right connection is missing. We believe that by investing in the foundation   cognitive and executive building blocks   children start moving again.",
    "about.mission.title": "Our mission",
    "about.mission.text":
      "CoFun makes scientific insights about cognitive development accessible for education. With our curriculum, we offer teachers practical, playful and proven methods to guide gifted students. We observe, reflect and build   step by step.",
    "about.approach.title": "Our approach",
    "about.approach.text":
      "We follow the inverted pyramid: instead of directly working on the executive function a child struggles with, we strengthen the underlying cognitive building blocks. Through play and targeted activities, space for growth emerges from within.",
    "about.why.title": "Why gifted students?",
    "about.why.text":
      "Gifted children who underperform are often unrecognised or misunderstood. They may exhibit behavioural issues, withdraw or stand out through frustration. CoFun helps these students reconnect with their own potential   through play, thinking and growing.",

    /* ── Curriculum Page ────────────────────────────────────────────────── */
    "hero.curriculum.title": "The curriculum",
    "hero.curriculum.subtitle":
      "A practical, evidence-based curriculum that equips teachers to guide gifted students through play.",
    "curriculum.what.title": "What is the curriculum?",
    "curriculum.what.text":
      "The CoFun curriculum is a complete set of lesson plans, instructional videos and play materials that enable teachers to systematically develop students' cognitive and executive functions. Every component is carefully structured following the inverted pyramid.",
    "curriculum.contains.title": "What does it contain?",
    "curriculum.contains.videos": "Instructional videos for each age group",
    "curriculum.contains.briefs":
      "Detailed lesson plans with observation guides",
    "curriculum.contains.games":
      "Play materials aligned with cognitive building blocks",
    "curriculum.contains.reflection":
      "Reflection tools for teachers and students",
    "curriculum.contains.guide": "Implementation guide for the classroom",
    "curriculum.who.title": "Who is it for?",
    "curriculum.who.text":
      "The curriculum is designed for teachers, special needs coordinators and care coordinators working with gifted students in primary education. It is suitable for ages 4-6, 7-9 and 10-12.",
    "curriculum.groups.12.title": "Ages 4-6",
    "curriculum.groups.12.subtitle": "Kindergarten and Year 1",
    "curriculum.groups.12.text":
      "Playful activities that lay the foundation for perception, accuracy and making connections. Through play, young children discover their cognitive building blocks.",
    "curriculum.groups.345.title": "Ages 7-9",
    "curriculum.groups.345.subtitle": "Years 2-4",
    "curriculum.groups.345.text":
      "Targeted exercises that build on the foundation. Children learn to consciously engage with comparing, eliminating and selecting   always through play and reflection.",
    "curriculum.groups.678.title": "Ages 10-12",
    "curriculum.groups.678.subtitle": "Years 5-7",
    "curriculum.groups.678.text":
      "Challenging assignments that stimulate metacognitive awareness. Students learn to articulate their own thinking steps and consciously deploy strategies.",
    "curriculum.benefits.title": "Benefits for your school",
    "curriculum.benefit.1": "Evidence-based and practically applicable",
    "curriculum.benefit.2": "Ready to use in daily teaching practice",
    "curriculum.benefit.3": "Suitable for all year groups in primary education",
    "curriculum.benefit.4":
      "Promotes self-insight and metacognition in students",
    "curriculum.benefit.5": "Supports teachers in observation and guidance",
    "curriculum.cta.title": "Get the curriculum",
    "curriculum.cta.text":
      "Would you like to use the CoFun curriculum at your school? Contact us for more information or a no-obligation conversation.",
    "curriculum.cta.button": "Get in touch",

    /* ── Schools Page ───────────────────────────────────────────────────── */
    "hero.schools.title": "For schools",
    "hero.schools.subtitle":
      "From first introduction to successful implementation   we guide your school every step of the way.",
    "schools.how.title": "How does implementation work?",
    "schools.how.text":
      "The CoFun curriculum can easily be integrated into your existing educational practice. We provide support at every stage of the process.",
    "schools.step.1.title": "Introduction",
    "schools.step.1.text":
      "We discuss the situation at your school and your team's needs. Together, we explore how CoFun can best connect.",
    "schools.step.2.title": "Training & onboarding",
    "schools.step.2.text":
      "Teachers get acquainted with the method, materials and underlying vision. They experience first-hand what students will be doing.",
    "schools.step.3.title": "Classroom practice",
    "schools.step.3.text":
      "Using the lesson plans and videos as a guide, teachers get to work. Observation, guidance and reflection take centre stage.",
    "schools.step.4.title": "Evaluation & growth",
    "schools.step.4.text":
      "Together, we evaluate progress and discuss observations. This creates a continuous process of growth   for students and for the team.",
    "schools.results.title": "What can you expect?",
    "schools.result.1": "Students who re-engage and start moving again",
    "schools.result.2":
      "Teachers who guide with greater insight and confidence",
    "schools.result.3": "A school-wide approach to giftedness",
    "schools.result.4": "Visible growth in cognitive and executive skills",
    "schools.cta.title": "Let's get started",
    "schools.cta.text":
      "We are happy to explore the best approach for your school. Get in touch for a no-obligation introductory meeting.",
    "schools.cta.button": "Schedule a meeting",

    /* ── Contact Page ───────────────────────────────────────────────────── */
    "hero.contact.title": "Contact",
    "hero.contact.subtitle":
      "We would love to hear from you. Ask a question, share your situation or schedule an introductory meeting.",
    "contact.intro.title": "Let's connect",
    "contact.intro.text":
      "Whether you want to learn more about the curriculum, have a question about implementation or are simply curious   we are here for you. Send us an email at info@cofun.nl and we will get back to you as soon as possible.",
    "contact.form.name": "Name",
    "contact.form.email": "Email address",
    "contact.form.school": "School name",
    "contact.form.role": "Your role",
    "contact.form.message": "Your message",
    "contact.form.submit": "Send message",
    "contact.form.privacy":
      "We handle your data with care. Your information will only be used to contact you.",

    /* ── Footer ─────────────────────────────────────────────────────────── */
    "footer.tagline": "Learning through play   for every gifted student.",
    "footer.nav": "Navigation",
    "footer.contact": "Contact",
    "footer.email": "info@cofun.nl",
    "footer.copyright": "© 2026 CoFun. All rights reserved.",
    "footer.construction":
      "Website under construction. More content on the way.",
    /* ── Misc ───────────────────────────────────────────────────────────── */
    "testimonial.coming": "School experiences coming soon.",
    "video.placeholder": "Video coming soon.",
    "lang.switch": "NL",
  },
} as const;

export type TranslationKey = keyof typeof translations.nl;

/**
 * Returns a translation function for the given locale.
 */
export function useTranslations(locale: Locale) {
  return function t(key: TranslationKey): string {
    return translations[locale][key] ?? translations[defaultLocale][key] ?? key;
  };
}

/**
 * Returns localised paths for navigation.
 */
export function getLocalePath(locale: Locale, path: string): string {
  if (locale === defaultLocale) return path;
  return `/en${path}`;
}

/**
 * Returns all navigation items for a given locale.
 */
export function getNavItems(locale: Locale) {
  const t = useTranslations(locale);
  const prefix = locale === defaultLocale ? "" : "/en";
  return [
    { label: t("nav.home"), href: `${prefix}/` },
    { label: t("nav.about"), href: `${prefix}/over-ons` },
    { label: t("nav.curriculum"), href: `${prefix}/lespakket` },
    { label: t("nav.schools"), href: `${prefix}/voor-scholen` },
    { label: t("nav.contact"), href: `${prefix}/contact` },
  ];
}
