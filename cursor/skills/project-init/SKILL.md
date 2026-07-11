---
name: project-init
description: >-
  Initializes new XingAI apps and *.xingai.app product projects. Use when creating
  a new app, bootstrapping a product repo, adding a public product surface, or
  preparing an app for first deploy. Enforces mobile-first UI, XingAI chrome,
  brand assets, EN/zh/ko i18n, light/dark themes, hero light/dark visual pair,
  legal pages, SEO/AEO, xingai-dot-app registration, and Google OAuth guidance.
---

# Project Init

Use this skill whenever the user asks to create, scaffold, bootstrap, or ship a new XingAI app.

This skill sets the product baseline. It does not replace `xingai-web-design`; use that skill for front-end implementation details.

## First Steps

1. Read repo-level guidance if present: `AGENTS.md`, `.cursor/rules/*`, README, existing `docs/`, and nearby product examples.
2. Identify the app type: marketing site, product app, POC, internal tool, or backend-only service with a future UI.
3. Choose conservative defaults from existing XingAI repos.
4. If the app has a public UI, treat the checklist below as required before calling it ready.

## Required App Baseline

### Mobile-First UI

- Design for 320-430px first.
- Touch targets must be at least 44x44 CSS px.
- Use safe-area padding for fixed top and bottom chrome.
- Keep phone layouts single-column by default.
- Do not fake OS status bars in the DOM.

### Navigation Chrome

- Mobile top bar: menu, brand/title, language switcher, theme toggle, profile/login if applicable.
- Mobile side menu: full nav, language/theme fallback, legal/help links, and disabled `Soon` items for unreleased routes.
- Mobile footbar menu: fixed bottom tab bar for primary destinations.
- Desktop: include a side menu or equivalent navigation pattern. If collapsible, closed mode needs accessible icon labels.
- Keep the same destinations available across mobile and desktop.

### Brand Assets

- Create a product logo and favicon before shipping.
- Prefer simple SVG/vector assets that match product tokens.
- Add app icons where supported.
- Use consistent icons from the repo icon library. Do not use emoji as primary icons.

### Hero

- Strong hero: headline, subcopy, primary CTA (+ secondary CTA when useful).
- **Hero visual** — product illustration or mock; not CSS-only decoration.
- **Light + dark pair** for in-app hero; swap by theme (`dark:hidden` / `dark:block` or `ThemedImage`).
- **Desktop (`lg+`):** copy left, visual in second column.
- **Mobile:** hero strip under copy — do not show visual on desktop only.
- **`og-image.png` is separate** — OG/Twitter metadata only; not a substitute for in-app hero.

Details: [references/hero-visuals.md](references/hero-visuals.md). Reference: `xingai-research-ai/components/research-hero.tsx`.

### Language

- Support EN / 中文 / 한국어.
- Use locale codes `en`, `zh`, and `ko`.
- Put all new user-facing strings through the repo i18n layer.
- Product AI prompts and outputs should respect selected language where applicable.

### Theme

- Support both light and dark themes.
- Use the repo convention: `next-themes`, `.dark`, or `data-theme`.
- Avoid theme flash.
- Use repo tokens; prefer `oklch`.

### Legal

- Public products must link Privacy Policy, Terms of Service, and Disclaimer.
- Legal pages should exist in EN / zh / ko before legal is done.
- Footer and mobile drawer should expose legal links.
- Finance products need risk-first copy and no return promises.

### SEO + AEO

- Add `metadataBase`, route-specific title and description, canonical URL, Open Graph, and Twitter metadata.
- Add or update `robots.txt`, `sitemap.xml`, and `llms.txt`.
- Add short factual FAQ and JSON-LD where applicable.
- Avoid hype. Use factual answers with real product domains.

### Product Registry

- Register public products in `xingai-dot-app` or the current product registry.
- Add localized labels, icon/logo, route/domain link, and status.
- Screenshot entries need **`src` + `srcDark`** for theme-aware marketing demos.
- If not ready, mark as `Soon`; do not ship empty links.

### Login And Google OAuth

- If the app has login, use Google OAuth unless the product requires another provider.
- Create a new Google OAuth client for the new app. Do not copy another product's OAuth client by default.
- Add production and local redirect URIs before testing.
- Document env names: `AUTH_SECRET`, `AUTH_URL`, `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET`.
- Never commit secrets.

### Developer Setup

- Add `.env.example` with safe placeholders.
- Add README local dev commands, deployment notes, project URL, and version notes.
- Add build/lint/test commands that match the repo.
- Verify production env names match local env names unless documented.

## Pre-Ship Checklist

```markdown
- [ ] Mobile-first layout works at ~375px
- [ ] Top bar, drawer, bottom nav, and desktop nav are wired where applicable
- [ ] Logo, favicon, and app icons exist
- [ ] In-app hero visual on primary route (light + dark pair; mobile strip + desktop second column)
- [ ] OG image separate from in-app hero
- [ ] dot-app screenshot has `src` + `srcDark` when registered
- [ ] EN / zh / ko strings are complete
- [ ] Light and dark themes are readable with no flash
- [ ] Privacy, Terms, and Disclaimer exist and are linked
- [ ] SEO metadata, canonical, OG/Twitter, robots.txt, sitemap.xml are done
- [ ] llms.txt, FAQ, and JSON-LD are done
- [ ] Product is registered in the public product registry
- [ ] Login, if present, uses correct OAuth redirect URIs
- [ ] .env.example, README, and deploy docs are updated
- [ ] Build/lint/tests pass, or skipped checks are explained
```

## Common Mistakes To Block

- Desktop-first pages squeezed down to mobile.
- Language/theme hidden on mobile without drawer fallback.
- Missing legal pages or only English legal copy.
- Hard-coded UI strings in components.
- Empty product cards in the product registry.
- Reusing another product's Google OAuth client without approval.
- Exposing internal labels like V1/V2 in user-facing UI.
- Using only `og-image.png` as the hero — still need in-app light/dark pair.
- dot-app screenshot with `src` only and no `srcDark`.
- Hero visual desktop-only with nothing on mobile.
