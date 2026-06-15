---
name: xingai-web-design
description: >-
  Builds and refines XingAI web UIs for *.xingai.app products. Applies
  decision-system UX, hero sections, brand assets (logo, favicons), motion,
  icon systems, SEO/AEO, legal/trust pages (Privacy, Terms, Disclaimer, About),
  mobile chrome, oklch tokens, light/dark theme, i18n, and anti-AI-slop rules.
---

# XingAI Web Design

Use this skill for front-end work on XingAI product apps, marketing pages, and public UI surfaces.

## When To Apply

- New screens, components, CSS, or theme work in `xingai-*` repos
- Home/marketing pages, hero sections, logo, favicons
- Mobile header, side menu, bottom nav, light/dark theme
- Product UI polish, SEO/AEO metadata, structured content
- Legal/trust pages: Privacy, Terms, Disclaimer, About, Help
- User asks for XingAI style, decision UI, or V1-aligned upgrade

Not for backend APIs, workers, Vercel-only config, or non-visual scripts.

## Non-Negotiable Product Rules

1. Upgrade, do not replace. Later versions inherit prior UX, product identity, and main flow.
2. Do not expose internal labels like V1/V2/V3 in user-facing UI.
3. Decision systems, not generic chatbots. One primary outcome per screen.
4. Finance/invest surfaces need risk-first copy and no guaranteed returns.

## Workflow

1. Read existing `globals.css`, layout files, sibling components, and README.
2. Identify the current design system: tokens, spacing, radius, typography, icons, and motion.
3. Declare the design direction before large diffs.
4. Build mobile first at ~375px.
5. Add desktop refinements after the mobile base works.
6. Verify hero, brand assets, light/dark theme, EN/zh/ko strings, safe areas, and touch targets.
7. Verify legal/trust pages exist and are linked from footer and mobile drawer.
8. Verify SEO metadata and AEO-friendly copy before shipping public pages.

## Hero Section

Every product home or landing page must include a **hero** — the first screen that states the decision outcome.

### Layout

- **Background**: full-width hero image or subtle gradient mesh over a product-relevant photo/illustration. Always add a readable overlay (`linear-gradient` or `oklch` scrim) so text passes contrast in light and dark.
- **Content stack**: logo → eyebrow/kicker → **one H1** → supporting line → primary CTA → optional secondary link.
- **Mobile (~375px)**: min-height ~60–70vh, background `object-cover` with focal point centered, CTA full-width or prominent, no text clipped by bottom nav.
- **Desktop**: wider max-width for copy; background can use parallax or wider crop — never at the cost of mobile readability.

### Hero image

- Prefer **original or on-brand** imagery (product UI mock, calm abstract, founder/decision metaphor). Avoid generic purple AI brain stock photos.
- Store under `public/hero/` (or repo asset convention). Provide WebP/AVIF + fallback; use `next/image` with `priority` on LCP hero.
- Alt text must describe the scene for SEO and screen readers — not keyword stuffing.

### Hero motion

- Use **subtle, purposeful** animation only: fade/slide-in on load (stagger eyebrow → H1 → CTA), gentle background scale (1.02→1), or soft gradient shift.
- Respect `prefers-reduced-motion: reduce` — disable or replace with instant state.
- No infinite distracting loops, particle storms, or layout-shifting animations.
- Prefer CSS transitions/`@keyframes` or lightweight libraries already in the repo; do not add heavy animation deps for one page.

## Brand Assets

Create or upgrade when missing — do not ship a public page without logo + favicons.

### Logo

- **Primary**: SVG in `public/logo.svg` (or `public/brand/`) — scales cleanly, works on light and dark (single-color or adaptive via CSS/`currentColor`).
- **Raster fallback**: PNG @1x/@2x for OG/email if needed.
- Style: calm green decision-system identity; wordmark + simple mark; readable at 32px height in mobile header.
- Use `GenerateImage` only when the user explicitly wants a new logo asset; otherwise draw SVG or refine existing repo marks.

### Favicons

Ship a complete set in `public/` and wire through Next.js `metadata`:

| File | Purpose |
|---|---|
| `favicon.ico` | Legacy browsers |
| `icon.svg` | Modern tab icon (scalable) |
| `apple-touch-icon.png` | iOS home screen (180×180) |
| `icon-192.png` / `icon-512.png` | PWA / Android (if applicable) |

- Favicon mark = simplified logo glyph (not full wordmark at 16px).
- Set `metadata.icons`, `themeColor`, and `manifest` when the app supports install/PWA.

## Icons

- Use a **consistent icon library** (Lucide, Heroicons, or repo standard) — stroke weight and size match across nav, CTAs, and feature rows.
- Size nav/action icons ~20–24px inside **44px** touch targets.
- Every interactive icon needs `aria-label` or visible text; decorative icons use `aria-hidden="true"`.
- **Do not** use emoji as primary navigation or feature icons (emoji in body copy is OK sparingly).
- Hero and feature sections: pair icon + headline + one-line benefit — not icon-only grids.

## SEO & AEO

Optimize for search engines **and** answer engines (ChatGPT, Perplexity, Google AI Overviews).

### SEO (technical + on-page)

- **One H1 per page**; logical `h2`/`h3` hierarchy; semantic landmarks (`header`, `main`, `nav`, `footer`).
- **Metadata** via Next.js `metadata` / `generateMetadata`: unique `title`, `description` (150–160 chars), `openGraph`, `twitter`, `canonical`, `robots` when needed.
- **Performance**: hero LCP image prioritized; lazy-load below-fold; avoid layout shift in hero.
- **i18n**: `lang` on `<html>`, localized titles/descriptions per locale when the app supports zh/ko.
- **Sitemap + robots.txt** for public marketing domains when applicable.

### AEO (answer-friendly content)

- **First screen answers**: H1 + first paragraph clearly state *what the product is*, *who it is for*, and *the primary outcome* — in plain language agents can quote.
- **Structured data**: JSON-LD where relevant (`WebApplication`, `SoftwareApplication`, `Organization`, `FAQPage` for help/landing FAQs).
- **FAQ block** on home or `/help`: real questions, concise answers, `FAQPage` schema — no fake testimonials.
- **Descriptive alt text** on hero and feature images; avoid empty or generic "image" alts.
- **Stable, citable URLs** for key pages; meaningful slug names (`/radar`, not `/p2-feed`).
- Avoid hiding critical product meaning inside client-only widgets without SSR fallback text.

## Legal & Trust Pages

Every public `*.xingai.app` product must ship **reachable legal and trust pages** — not README-only disclaimers.

### Required routes

| Route | Page | Purpose |
|---|---|---|
| `/legal/privacy` | Privacy Policy | Data collected, cookies, third parties, retention, contact |
| `/legal/terms` | Terms of Service | Acceptable use, accounts, IP, limitation of liability |
| `/legal/disclaimer` | Disclaimer | AI outputs, no professional advice, as-is, user responsibility |
| `/about` | About | What the product is, who builds it, mission — AEO-friendly |

Recommended when applicable:

| Route | Page |
|---|---|
| `/help` or `/faq` | Help / FAQ (real Q&A, link from drawer) |
| `/contact` | Contact or support channel |

Also keep `DISCLAIMER.md` in the repo (engineering standard) — the **website must still link** to `/legal/disclaimer` in UI.

### Link placement

- **Site footer** on every public layout (desktop + mobile page footer).
- **Mobile drawer** — legal block below main nav (Privacy · Terms · Disclaimer · About).
- **Do not** bury legal links only in Settings or GitHub README.
- Use i18n labels (`Privacy Policy`, `隐私政策`, `개인정보 처리방침`, etc.).

### Page design

- Same tokens, typography, and shell as the rest of the app — readable long-form prose.
- One H1 per page; `last updated` date; table of contents for long policies.
- Max-width ~65ch for body text; sufficient contrast in light and dark.
- No hero animation required — calm, trustworthy layout beats marketing flair.

### Copy rules

- Start from `xingai-engineering-system/templates/disclaimer-template.md` when drafting Disclaimer.
- AI products: outputs are **suggestions or estimates**, not professional, legal, financial, medical, or compliance advice.
- Finance/invest surfaces: risk-first copy; **no guaranteed returns**.
- POC/demo products: state what is not production-ready (auth, audit, SLA).
- This skill is an engineering standard — **not legal advice**; flag product-specific risks for qualified review.

## Default Design Tokens

Use repo tokens first. If the repo has no tokens yet, start with a calm green decision-system palette.

| Role | Light | Dark |
|---|---|---|
| Background | `oklch(0.985 0.004 145)` | `oklch(0.14 0.01 145)` |
| Foreground | `oklch(0.22 0.02 150)` | `oklch(0.98 0 0)` |
| Primary | `oklch(0.52 0.19 145)` | `oklch(0.62 0.18 145)` |
| Card | `oklch(1 0 0)` | `oklch(0.19 0.02 145)` |
| Border | `oklch(0.9 0.02 145)` | `oklch(0.3 0.03 145)` |

## Mobile Chrome

- Top bar: menu, product title, language, theme, profile/login where applicable.
- Drawer: full nav, settings fallback, **legal links** (Privacy · Terms · Disclaimer · About), help/GitHub.
- Bottom nav: primary destinations only, mobile only.
- Page footer: repeat legal + About links where a footer exists on desktop.
- Content bottom padding must clear the bottom nav and safe area.
- Never hide language/theme on mobile unless repeated in the drawer.

## Anti-Patterns

- Inter + blue default SaaS styling without product reason
- Purple/pink gradient glass UI for every app
- Hero with unreadable text over busy stock photo (no overlay)
- Missing favicon/logo on public pages
- Emoji as primary nav or feature icons
- Fake testimonials or FAQ schema with marketing fluff
- Generic AI chatbot dashboard replacing the product's main flow
- Big desktop controls that overlap mobile title/chrome
- Hard-coded UI strings outside i18n
- Keyword-stuffed metadata or invisible SEO text blocks
- Heavy animation that ignores `prefers-reduced-motion`
- Public product with no Privacy, Terms, or Disclaimer pages in UI
- Legal text only in README/`DISCLAIMER.md` with no in-app links
- Copying legal pages between products without product-specific review
- Finance or AI advice copy without limitation-of-liability language

## Pre-Delivery Checklist

```markdown
- [ ] Hero present on home/landing with readable overlay and primary CTA
- [ ] Hero image optimized (WebP/AVIF, alt text, LCP priority)
- [ ] Hero motion subtle; reduced-motion respected
- [ ] Logo SVG (+ favicon set) in public/ and wired in metadata
- [ ] Icon library consistent; 44px touch targets; aria labels on actions
- [ ] SEO: title, description, OG/Twitter, one H1, semantic headings
- [ ] AEO: clear what/who/outcome above fold; JSON-LD if applicable
- [ ] Privacy Policy, Terms of Service, Disclaimer at `/legal/privacy`, `/legal/terms`, `/legal/disclaimer`
- [ ] About page at `/about`; Help/FAQ linked if product has support content
- [ ] Legal + About linked in footer and mobile drawer
- [ ] AI/finance copy includes appropriate limitation language
- [ ] Matches existing repo tokens/theme
- [ ] Mobile layout works at ~375px
- [ ] Light and dark are readable
- [ ] Language/theme reachable on mobile
- [ ] Main decision path is visible without extra navigation
- [ ] No internal version labels in user-facing UI
- [ ] Legal/help links reachable without extra navigation
```
