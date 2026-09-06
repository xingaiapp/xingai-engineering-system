---
name: project-init
description: >-
  Initializes new XingAI apps and *.xingai.app product projects. Use when creating
  a new app, bootstrapping a product repo, adding a new public product surface,
  or preparing an app for first deploy. Enforces mobile-first UI, XingAI chrome,
  brand assets, mandatory product images/icons/motion, EN/zh/ko i18n, light/dark
  themes, hero light/dark visual pair, legal pages, SEO/AEO, xingai-dot-app
  registration, and Google OAuth setup guidance.
---

# Project Init

Use this skill whenever the user asks to create, scaffold, bootstrap, or ship a new XingAI app.

This skill sets the product baseline. It does not replace `xingai-web-design`; for front-end implementation, read and follow `~/.cursor/skills/xingai-web-design/SKILL.md` too.

## Hard gate — visual presence (non-negotiable)

For any **public UI** (product app, marketing page, demo shell), the agent **must** add real visuals before calling the project ready. Text + chrome alone is **not** done.

**Do not** ship, mark “project-init complete,” or say the shell is ready if any of these are missing:

1. **Product images** — in-app hero light/dark pair + separate OG image (see Hero + [references/hero-visuals.md](references/hero-visuals.md)).
2. **Icons** — logo/favicon/app icons + UI icons for nav and primary actions (SVG/vector; **no emoji** as primary icons).
3. **Motion** — at least **2–3 intentional animations** on the primary route (entrance, hover/press, or theme-safe micro-motion). Not random infinite spinners; not motion-only fluff.

“Scaffold / Soon / mock data” still requires this visual baseline when users can open the UI. Backend-only repos with **no** public UI may skip images/motion until a UI lands — then this gate applies.

If the agent is about to finish without creating image/icon/motion files, **stop and create them** (or generate SVG/illustration assets in-repo) before the final response.

## First Steps

1. Read repo-level guidance if present: `AGENTS.md`, `.cursor/rules/*`, product README, existing `docs/`, and nearby product examples.
2. Identify the app type: marketing site, product app, demo app, internal tool, or backend-only service with a future UI.
3. Choose conservative defaults from existing XingAI repos. Do not invent a new design system if a product family already has one.
4. If the new app has a public UI, treat the checklist below as required before calling it ready — **including the visual presence hard gate**.

## Required App Baseline

### Mobile-first UI

- Design for 320-430px first; add `sm:` / `lg:` only after the base mobile layout works.
- Touch targets must be at least 44x44 CSS px.
- Use safe-area padding for fixed top and bottom chrome.
- Keep the default layout single-column on phones.
- Do not fake OS status bars in the DOM.
- **Control labels must be vertically and horizontally centered** inside buttons, tabs, and chip controls (`display: inline-flex; align-items: center; justify-content: center; line-height: 1.2`). Do not leave label text stuck to the top of a tall min-height button — especially `<a class="btn">` links.

### Navigation Chrome

- Mobile top bar: menu button, brand/title, language switcher, theme toggle, profile/login if applicable.
- Mobile side menu: full nav, language/theme fallback, legal/help links, and disabled "Soon" items for unreleased routes.
- Mobile footbar menu: fixed bottom tab bar for primary destinations; main content must have enough bottom padding.
- Desktop: include a side menu that toggles open/closed. Default open. When closed, show larger icon-only nav with accessible labels/tooltips.
- Keep the same destinations available across mobile and desktop.

### Brand Assets (forced)

- **Create** a product logo and favicon in the first UI pass — do not leave placeholder text-only branding.
- Prefer simple SVG/vector assets that match product tokens; avoid random stock-style marks.
- Add app icons where the framework supports them (`favicon.ico`, `icon.svg`, `apple-touch-icon`, metadata icons).
- Use consistent SVG icons for primary nav destinations and key CTAs. Do not use emoji as primary icons.
- Empty `public/` with only default Next favicon = **fail**.

### Images (forced)

- Ship **real** product imagery on the primary route, not CSS-only decoration.
- Required set for a public product shell:
  - In-app **hero light + dark** pair
  - **OG / Twitter** image (separate file)
  - **dot-app** card `src` + `srcDark` when registered
- Prefer SVG or optimized PNG/WebP under `public/` or `public/brand/`. Document paths in README.
- Theme swap must change the actual asset (light ≠ dark file).

### Motion / animation (forced)

- On the primary landing/decision route, ship **at least 2–3 intentional motions**, for example:
  - Hero or decision card entrance (fade/slide, short duration, `prefers-reduced-motion` respected)
  - Primary CTA press/hover feedback
  - One content reveal (staggered list, drawer open, or theme toggle polish)
- Prefer CSS transitions / `@keyframes` or the repo’s existing motion helper; do not add a heavy animation library by default.
- Motion must support hierarchy and presence — not noise, not endless looping logos.
- Respect `prefers-reduced-motion: reduce` (disable or simplify non-essential motion).

Details: [references/visual-motion.md](references/visual-motion.md).

### Hero

- Create a strong hero section with product-specific headline, short subcopy, primary CTA, and secondary CTA where useful.
- Add a **hero visual** (illustration or product mock) that explains the product — not CSS-only decoration.
- Ship a **light + dark image pair** for the in-app hero; swap by theme (`dark:hidden` / `dark:block` or repo `ThemedImage`).
- **Desktop:** copy left, hero visual in a second column on `lg+`.
- **Mobile:** hero strip under copy (do not hide the visual only on desktop).
- Ensure hero text remains readable in both themes.
- Put the primary decision/content path before decorative visuals in DOM order when performance or accessibility matters.
- **`og-image.png` is separate** — Open Graph/Twitter only; it does not replace the in-app hero pair.

Default asset paths and layout: [references/hero-visuals.md](references/hero-visuals.md). Reference implementation: `xingai-research-ai/components/research-hero.tsx`.

### XingAI Dot App Registration

- Register the new product in `xingai-dot-app` the same way existing demo/product apps are registered.
- Add product card metadata, route/domain link, icon/logo, localized labels (`en`, `zh`, `ko`), and status.
- Screenshot entries need **`src` + `srcDark`** (`*-demo-light.jpg` / `*-demo-dark.jpg`) so marketing theme swap works.
- If the app is not ready, mark it as "Soon" or equivalent disabled state. Do not ship empty links.
- Update sitemap, AEO files, and any product index data in `xingai-dot-app`.

### Language

- Support EN / 中文 / 한국어.
- Use locale codes `en`, `zh`, and `ko` in code. Do not use `cn` as a locale code.
- Put all new user-facing strings through the repo i18n layer.
- Persist the locale and re-apply it on load before paint when the repo has an i18n boot pattern.
- Product AI prompts and outputs should respect the selected language where applicable.

### Theme

- Support both light and dark themes.
- Use the repo convention: `next-themes` + `.dark`, or `data-theme`, not both unless already established.
- Avoid theme flash with an inline init script or existing no-flash pattern.
- Update `theme-color` metadata when the theme changes if the app supports it.
- Use repo oklch tokens; do not introduce random primary hex colors.

### Legal

- Every public product must link to Privacy Policy, Terms of Service, and Disclaimer.
- Legal pages must exist in EN / zh / ko before legal is considered done.
- Footer and mobile drawer must expose legal links.
- AI lifestyle/travel/style/research products must say suggestions are informational and users should verify before action.
- Invest or finance products need risk-first copy and no return promises.

### SEO

- Add `metadataBase`, route-specific title and description, canonical URL, Open Graph, and Twitter card metadata.
- Set `<html lang>` to the active locale.
- Add or update `robots.txt` and `sitemap.xml`.
- Use a branded OG image or product screenshot, not only a favicon.
- Internal links should respect the active locale on localized marketing pages.

### AEO

- Add `llms.txt` at the product root or `public/`.
- Include a short factual FAQ on the homepage or landing page.
- Add JSON-LD where applicable: `SoftwareApplication`, `FAQPage`, `Organization`, or `WebSite`.
- Keep FAQ, on-page copy, and `llms.txt` in sync.
- Avoid hype. Use factual answers with real product domains.

### Login And Google OAuth

- If the app has login, use Google OAuth unless the user asks for a different provider.
- Remind the user to create a new Google OAuth client for the new app. Do not copy an old project's OAuth client by default.
- Add redirect URIs before testing:
  - Production: `https://<product>.xingai.app/api/auth/callback/google`
  - Local: `http://localhost:3000/api/auth/callback/google` or the repo's actual local port
- Add required env docs: `AUTH_SECRET`, `AUTH_URL`, `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET`.
- Never commit secrets. Keep real values in `.env.local`, Vercel, Fly, or another secret store.

### Developer Setup

- Add `.env.example` with all required variables and safe placeholders.
- Add README local dev commands, deployment notes, and project URL.
- Document Vercel/Fly settings when the app uses them.
- Add build/lint/test commands that match the repo.
- Verify production env names match local env names unless there is a documented reason.

## Build Workflow

1. Scaffold or inspect the app structure.
2. Install and reuse the repo's existing UI, i18n, theme, icon, and metadata patterns.
3. **Create brand icons + hero light/dark images + OG image early** (same session as first UI). Do not defer visuals to a “polish” follow-up.
4. **Wire 2–3 primary-route motions** with `prefers-reduced-motion` support.
5. Build the core product route first, then chrome, then legal/SEO/AEO.
6. Register the product in `xingai-dot-app` with icon + `src`/`srcDark` screenshots.
7. Run lint/build/tests where available.
8. Verify mobile ~375px, desktop side menu open/closed, light/dark, all three languages, **and** that images/icons/motion are visible.

## Pre-ship Checklist

Copy this into the plan or PR summary for any new XingAI public app:

```markdown
- [ ] Mobile-first layout works at ~375px
- [ ] Top bar, mobile drawer, mobile footbar, and desktop side menu are wired
- [ ] Desktop side menu toggles open/closed; closed mode shows icon-only nav
- [ ] Logo, favicon, and app icons exist (not emoji; not default Next placeholder only)
- [ ] Nav / primary actions use SVG (or repo icon set) icons
- [ ] Button / tab / CTA labels are vertically + horizontally centered (not top-aligned in tall controls)
- [ ] In-app hero visual exists on primary route (light + dark pair; mobile strip + desktop second column)
- [ ] OG image exists separately from in-app hero
- [ ] At least 2–3 intentional motions on primary route; reduced-motion respected
- [ ] dot-app screenshot has `src` + `srcDark` when product is registered
- [ ] EN / zh / ko strings are complete
- [ ] Light and dark themes are readable with no flash
- [ ] Privacy, Terms, and Disclaimer exist and are linked
- [ ] SEO metadata, canonical, OG/Twitter, robots.txt, and sitemap.xml are done
- [ ] llms.txt, FAQ, and JSON-LD are done
- [ ] Product is registered in xingai-dot-app with localized metadata
- [ ] Beautiful icons and primary/secondary buttons match repo style
- [ ] Login, if present, uses a new Google OAuth client with correct redirect URIs
- [ ] .env.example, README, and deploy docs are updated
- [ ] Build/lint/tests pass, or skipped checks are clearly explained
```

## Common Mistakes To Block

- Shipping a “complete” shell that is text-only (no hero images, no logo, no motion).
- Deferring icons/images/animation to a later PR when the UI is already user-visible.
- Tall buttons/tabs with label text stuck to the top (missing flex centering on `<a class="btn">` / `.btn`).
- Desktop-first pages squeezed down to mobile.
- Language/theme hidden on mobile without drawer fallback.
- Missing legal pages or only English legal copy.
- Hard-coded UI strings in components.
- Empty product cards in `xingai-dot-app`.
- Reusing another product's Google OAuth client without explicit user approval.
- Forgetting OAuth redirect URLs before deploy.
- Exposing internal labels like V1/V2 in user-facing nav or titles.
- Adding polished UI without `robots.txt`, `sitemap.xml`, `llms.txt`, and metadata.
- Using only `og-image.png` as the hero — still need in-app light/dark hero pair.
- CSS gradient / abstract blob as the only “hero” with no product-specific image.
- Emoji as nav or brand icons.
- Motion that ignores `prefers-reduced-motion` or adds endless looping chrome.
- dot-app screenshot with `src` only and no `srcDark`.
- Hero visual hidden on mobile while only shown on desktop.
