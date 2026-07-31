---
name: project-init
description: >-
  Initializes new XingAI apps and *.xingai.app product projects. Use when creating
  a new app, bootstrapping a product repo, adding a public product surface, or
  preparing an app for first deploy. Enforces mobile-first UI, XingAI chrome,
  brand assets, EN/zh/ko i18n matching Invest AI dashboard (`tr` + header language menu +
  localStorage), light/dark themes, hero light/dark visual pair, legal pages, SEO/AEO,
  xingai-dot-app registration, Google OAuth guidance, and XingAI Notification Platform (XNP)
  as the only messaging integration path.
---

# Project Init

Use this skill whenever the user asks to create, scaffold, bootstrap, or ship a new XingAI app.

This skill sets the product baseline. It does not replace `xingai-web-design`; use that skill for front-end implementation details.

## First Steps

1. Read repo-level guidance if present: `AGENTS.md`, `.cursor/rules/*`, README, existing `docs/`, and nearby product examples.
2. Identify the app type: marketing site, product app, POC, internal tool, or backend-only service with a future UI.
3. Choose conservative defaults from existing XingAI repos.
4. If the app has a public UI, treat the checklist below as required before calling it ready.
5. Plan notifications through **XingAI Notification Platform (XNP)** — see [Notifications (XNP)](#notifications-xnp) below. Do not add a product-local Twilio / Resend / SendGrid / FCM stack.

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

Match **Invest AI dashboard** multilanguage style and behavior ([invest.xingai.app/dashboard](https://invest.xingai.app/dashboard)) — not `next-intl` URL routing, not separate `messages/en.json` trees as the primary UI API.

**Reference implementation**

- `xingai-invest-ai/stock-ai-front-end/components/dashboard/lang-context.tsx` — `LangProvider`, `useLang`, `localStorage`
- `xingai-invest-ai/stock-ai-front-end/lib/i18n/index.ts` — `tr`, `localeForLang`, `htmlLangFor`
- `xingai-invest-ai/stock-ai-front-end/lib/language-options.ts` — `LANGUAGE_MENU`
- `xingai-invest-ai/stock-ai-front-end/components/dashboard/header.tsx` — language dropdown in chrome
- `xingai-invest-ai/stock-ai-front-end/lib/nav-i18n.ts` — flat nav key tables
- `xingai-invest-ai/stock-ai-front-end/lib/i18n/labels.ts` — English API enum → zh/ko maps

**Locale set**

- Codes: `en` | `zh` | `ko` (required enabled).
- Optional menu stub: `es` with `enabled: false` and localized “Soon” (same as Invest).
- Default: **English** until the user picks another language.
- BCP 47 for dates/numbers: `en-US`, `zh-CN`, `ko-KR` via `localeForLang(lang)`.
- `document.documentElement.lang` via `htmlLangFor(lang)` (`en`, `zh-CN`, `ko`).

**Persistence & sync**

- Persist in `localStorage` under key `app_language` (same key as Invest unless the product already has a documented alias).
- Sync across tabs with the `storage` event.
- Do **not** put locale in the URL path by default (`/zh/...`). Do **not** require cookies for language unless you add a documented upgrade.

**UI control (function parity with Invest)**

- Language control lives in the **header / top chrome** (and mobile drawer fallback if the header control is hidden).
- Drive the menu from a single `LANGUAGE_MENU` config: `{ id, label, triggerShort, enabled }`.
- Trigger shows short labels: `EN` / `中文` / `한국어` (via `languageTriggerShort`).
- Menu shows native names: `English`, `中文`, `한국어`; disabled locales visible but not selectable, with “Soon” / `即将推出` / `곧 제공`.
- Accessible: `aria-label` / `title` translated with `tr(...)`.

**String API (style parity with Invest)**

- Primary API: `const { lang } = useLang()` then `tr(lang, en, zh?, ko?)`.
- `tr` rules: `en` required; `zh`/`ko` optional; for `ko`, fall back to English-key lookup then `en` (Invest: `lookupKo`).
- Prefer **inline triples** for one-off UI copy near the component.
- Prefer **flat per-locale tables** for nav / shared chrome keys (Invest: `navT(lang, "dashboard")`).
- Prefer **English-key → `{ zh, ko }` maps** for backend/API enums and signal vocabulary (Invest: `labels.ts`).
- Do **not** default new apps to `next-intl` / `react-i18next` catalogs unless the product already uses them — matching Invest is the XingAI baseline.

**Provider wiring**

- Wrap app chrome in `LangProvider` (client).
- Prefer a small locale `beforeInteractive` bootstrap that sets `document.documentElement.lang` from `localStorage` (Invest does this for theme today; new apps should do both theme + language to reduce flash).

**What to translate vs keep**

- Translate: nav, buttons, empty states, onboarding, settings, product explanations.
- Keep in English: tickers/symbols, technical IDs, most legal gate copy when following Invest’s EN-first disclaimer source (document that choice).
- Still ship full Privacy / Terms / Disclaimer pages in **en / zh / ko** for public products (footer links) even if a short gate strip stays EN.
- Finance products: keep “not investment advice / you decide” in every enabled locale.
- Format dates and numbers with `toLocaleString(localeForLang(lang))`.

**AI / backend copy**

- Product AI prompts and user-visible model outputs should respect the selected UI language when applicable (or return parallel `en`/`zh` structured fields like Invest worker briefs).

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
- Include XNP env placeholders when the product will send notifications (see below).

### Notifications (XNP)

XingAI apps share **[xingai-notification-platform](https://github.com/xingaiapp/xingai-notification-platform)** (XNP) for SMS, email, push, digests, campaigns, consent, and delivery tracking.

**Hard rules**

- Do **not** integrate Twilio, SendGrid, Resend, Amazon SES, ACS, FCM, APNs, WhatsApp, Slack, or Teams **directly** in a new product app.
- Do **not** store the user’s phone, email, or device token only inside campaign/send code paths — XNP owns contact points; products send `userId` / subscriber refs + template data.
- Product apps call XNP via versioned REST (`POST /api/v1/notifications`, …) and/or published integration events — never provider SDKs.
- Classify every send as transactional vs marketing (and related types). Marketing must go through XNP consent + preference rules.

**On every new product init**

1. Assign a stable **tenant id** (e.g. `xingai-learn`, `xingai-health`). Document it in README + `.env.example`.
2. List planned **topics** (e.g. `daily-lesson`, `ops-alert`) and **template keys** under `docs/notifications.md` (or README section).
3. Add env placeholders (no secrets committed):

```bash
# XingAI Notification Platform (XNP) — do not add Twilio/Resend keys to this app
XNP_BASE_URL="https://notify.xingai.app"   # or local/dev host
XNP_TENANT_ID="xingai-<product>"
XNP_CLIENT_ID=""
XNP_CLIENT_SECRET=""                       # service client; use secret store in prod
# Optional: Idempotency-Key prefix for this app's sends
XNP_IDEMPOTENCY_PREFIX="<product>"
```

4. Prefer a thin **XNP client module** (`src/lib/xnp/` or equivalent) that:
   - sends Bearer JWT / service-client auth
   - sets `Idempotency-Key` on every send
   - never logs full phone/email/tokens
5. If the product needs SMS opt-in UX, plan the shared **SmsSubscribeButton** pattern (native Messages / QR + keyword) — do not auto-send SMS from the browser.
6. Link architecture for authors: `xingai-notification-platform/docs/architecture/` (system design, API contracts, multi-tenancy, ADRs).

**If XNP is not deployed yet (Phase 1–4)**

- Still **do not** add a permanent Resend/Twilio integration in the new app.
- Ship an `XnpClient` interface + **fake/in-memory** or file-logged adapter for local demos.
- Document cutover: “replace fake adapter with real `XNP_BASE_URL` when platform Phase 5+ is live.”
- Legacy apps that already call Resend (e.g. Invest AI, InvestSim) may keep existing paths until an explicit migration ticket; **new** apps must not copy that pattern.

**Out of scope for product init**

- Implementing XNP itself, provider adapters, or the XNP admin dashboard (that is the `xingai-notification-platform` repo).
- Bypass of consent for “just this one marketing blast.”

## Pre-Ship Checklist

```markdown
- [ ] Mobile-first layout works at ~375px
- [ ] Top bar, drawer, bottom nav, and desktop nav are wired where applicable
- [ ] Logo, favicon, and app icons exist
- [ ] In-app hero visual on primary route (light + dark pair; mobile strip + desktop second column)
- [ ] OG image separate from in-app hero
- [ ] dot-app screenshot has `src` + `srcDark` when registered
- [ ] EN / zh / ko enabled via Invest-style `LangProvider` + `tr` / `LANGUAGE_MENU` (localStorage `app_language`; header switcher)
- [ ] Dates/numbers use `localeForLang`; tickers stay English; finance risk copy present in each enabled locale
- [ ] Light and dark themes are readable with no flash
- [ ] Privacy, Terms, and Disclaimer exist and are linked
- [ ] SEO metadata, canonical, OG/Twitter, robots.txt, sitemap.xml are done
- [ ] llms.txt, FAQ, and JSON-LD are done
- [ ] Product is registered in the public product registry
- [ ] Login, if present, uses correct OAuth redirect URIs
- [ ] XNP tenant id, topics/templates, and env placeholders documented (or N/A with reason)
- [ ] No direct Twilio/Resend/SendGrid/FCM/APNs SDKs in the new app
- [ ] .env.example, README, and deploy docs are updated
- [ ] Build/lint/tests pass, or skipped checks are explained
```

## Common Mistakes To Block

- Desktop-first pages squeezed down to mobile.
- Language/theme hidden on mobile without drawer fallback.
- Missing legal pages or only English legal copy.
- Hard-coded UI strings in components (bypass `tr` / `useLang`).
- Using `next-intl` URL locales (`/zh/...`) by default instead of Invest’s `localStorage` + header menu pattern.
- Missing header language control (or no mobile drawer fallback).
- Translating ticker symbols or inventing parallel finance jargon that fights English API enums.
- Empty product cards in the product registry.
- Reusing another product's Google OAuth client without approval.
- Exposing internal labels like V1/V2 in user-facing UI.
- Using only `og-image.png` as the hero — still need in-app light/dark pair.
- dot-app screenshot with `src` only and no `srcDark`.
- Hero visual desktop-only with nothing on mobile.
- Wiring Resend/Twilio/FCM keys into a new product instead of XNP.
- Sending marketing messages without XNP consent/topic subscription.
- Logging full phone numbers, emails, or device tokens in the product app.
