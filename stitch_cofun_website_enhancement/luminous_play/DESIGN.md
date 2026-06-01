---
name: Luminous Play
colors:
  surface: '#f9f9ff'
  surface-dim: '#d7dae5'
  surface-bright: '#f9f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f1f3ff'
  surface-container: '#ebedf9'
  surface-container-high: '#e5e8f3'
  surface-container-highest: '#dfe2ed'
  on-surface: '#181c23'
  on-surface-variant: '#3e4949'
  inverse-surface: '#2c3039'
  inverse-on-surface: '#eef0fc'
  outline: '#6e7979'
  outline-variant: '#bdc9c8'
  surface-tint: '#006a6a'
  primary: '#006767'
  on-primary: '#ffffff'
  primary-container: '#018282'
  on-primary-container: '#f3fffe'
  inverse-primary: '#75d6d5'
  secondary: '#805600'
  on-secondary: '#ffffff'
  secondary-container: '#ffbd52'
  on-secondary-container: '#734d00'
  tertiary: '#416261'
  on-tertiary: '#ffffff'
  tertiary-container: '#5a7a7a'
  on-tertiary-container: '#f3fffe'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#92f2f2'
  primary-fixed-dim: '#75d6d5'
  on-primary-fixed: '#002020'
  on-primary-fixed-variant: '#004f50'
  secondary-fixed: '#ffddaf'
  secondary-fixed-dim: '#fcbb4e'
  on-secondary-fixed: '#281800'
  on-secondary-fixed-variant: '#614000'
  tertiary-fixed: '#c6e9e9'
  tertiary-fixed-dim: '#abcdcd'
  on-tertiary-fixed: '#002020'
  on-tertiary-fixed-variant: '#2c4c4c'
  background: '#f9f9ff'
  on-background: '#181c23'
  surface-variant: '#dfe2ed'
  surface-gray: '#F5F7F9'
  success-mint: '#27AE60'
  growth-orange: '#E67E22'
typography:
  display-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 60px
    letterSpacing: -0.02em
  display-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.01em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  container-max: 1280px
  gutter: 24px
  margin-mobile: 16px
  margin-desktop: 48px
  section-gap: 80px
---

## Brand & Style

The design system is built on the philosophy of **"Spelend beter leren"** (Learning better through play). It balances the authoritative reliability required by educational professionals with the vibrant energy of a classroom. The style is **Corporate Modern with a Playful Edge**, utilizing generous whitespace, soft-touch surfaces, and deliberate pops of warmth to create an inviting yet highly functional workspace.

The target audience—teachers and educators—needs a tool that reduces cognitive load. To achieve this, the system avoids "flat" fatigue by using depth, subtle gradients, and rounded geometry to make digital interactions feel tactile and encouraging. The aesthetic is professional enough for administrative tasks but spirited enough to inspire creative lesson planning.

## Colors

The palette is anchored by a deep **Teal (#1A8B8B)**, representing stability and the core identity of the platform. This is paired with a **Sunny Yellow (#F9B84C)** secondary color used exclusively for "Fun" and "Growth" callouts—actionable items that signify progress or engagement. 

- **Primary (Teal):** Used for navigation, primary buttons, and structural branding.
- **Secondary (Yellow):** Used for accents, badges, and rewarding feedback loops.
- **Neutral:** A deep charcoal is used for high-legibility text, while a very light blue-gray (`#F5F7F9`) serves as the primary background to keep the interface feeling airy.
- **Tertiary:** A muted variation of the teal used for less prominent structural elements or hover states.

## Typography

This design system employs a dual-font strategy. **Plus Jakarta Sans** is used for headings to provide a friendly, modern, and slightly geometric personality that feels approachable. For body text and data-heavy interfaces, **Inter** is utilized for its exceptional legibility and neutral tone, ensuring that educational content remains the focus.

- **Headlines:** Use tighter letter-spacing and semi-bold weights to create a strong visual hierarchy.
- **Body:** Maintains standard weights with a comfortable line height (1.5x - 1.6x) to facilitate long-form reading of lesson plans.
- **Mobile Scaling:** Top-level displays scale down significantly on mobile to maintain viewport efficiency while preserving their distinct geometric character.

## Layout & Spacing

The layout follows a **Fixed-Fluid Hybrid** model. Content is contained within a max-width of 1280px for desktop to ensure line lengths remain readable, centering itself within the viewport. 

- **The 8px Grid:** All margins, paddings, and component heights are multiples of 8px to ensure mathematical harmony.
- **Generous Breathing Room:** Sections are separated by large gaps (80px+) to prevent the "cluttered classroom" feel.
- **Responsive Behavior:** 
    - **Desktop:** 12-column grid with 24px gutters.
    - **Tablet:** 8-column grid with 20px gutters.
    - **Mobile:** 4-column grid with 16px margins; vertical stacking is mandatory for all card-based components.

## Elevation & Depth

Visual hierarchy is established through **Tonal Layers** and **Ambient Shadows**. Instead of harsh black shadows, this design system uses tinted shadows (using a percentage of the Primary Teal or Neutral Dark) to keep the UI feeling integrated and soft.

- **Level 0 (Surface):** The background (`#F5F7F9`).
- **Level 1 (Cards):** Pure white background with a subtle 1px border (`#E1E4E8`) or a very soft, diffused shadow (Blur: 10px, Y: 4px, Opacity: 5%).
- **Level 2 (Interactive/Floating):** Higher elevation used for modals and active dropdowns, featuring a more pronounced shadow to indicate it is "closer" to the user.
- **Backdrop Blurs:** Used sparingly behind modal overlays to maintain context while focusing attention.

## Shapes

The shape language is **Rounded**, avoiding sharp corners to align with the "Playful" and "Engaging" brand attributes. 

- **Components:** Standard buttons and input fields use a 0.5rem (8px) radius.
- **Containers:** Large content cards and feature sections use a "rounded-lg" (16px) or "rounded-xl" (24px) radius to create a soft, friendly frame for content.
- **Icons:** Should always feature rounded terminals and joinery; avoid razor-sharp edges in iconography.

## Components

### Buttons
- **Primary:** Solid Teal (`#1A8B8B`) with white text. Rounded (8px). Subtle lift on hover.
- **Secondary/Fun:** Solid Yellow (`#F9B84C`) with dark text (`#1D2129`). Used for "Add New", "Start Lesson", or "Celebrate" actions.
- **Ghost:** Teal outline with transparent background for secondary actions.

### Inputs & Form Fields
Fields should have a white background, 1px light gray border, and 8px border radius. On focus, the border transitions to Primary Teal with a soft outer glow. Labels are always positioned above the field in `label-sm`.

### Cards
Cards are the primary vessel for lesson content. They feature a white background, 16px corner radius, and a 24px internal padding. High-priority cards may feature a top-border accent in the Secondary Yellow.

### Chips & Badges
Used for categorizing subjects (e.g., "Math", "Science"). These use a "Pill" shape (fully rounded) with a low-opacity background tint of the category color and high-contrast text.

### Progress Indicators
Progress bars should be thick (8px) with fully rounded ends, using a gradient transition from Teal to Yellow to visually represent the journey from "Learning" to "Growth".