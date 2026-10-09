---
name: create-project
description: >-
  Builds a full public XingAI product website to the Travel gold standard:
  product shell, content graph, path locales with hreflang, static HTML/CDN
  cache, localized metadata/JSON-LD, OG JPEGs, legal, SEO/AEO, funnel metrics,
  tests, and CI. Use when the user says create-project, /create-project, build a
  site like Travel, or wants a complete *.xingai.app website beyond bare
  scaffolding.
---

# Create Project (Travel-grade website)

Use this skill to build a **complete public product website**, not only a UI shell.

**Reference product:** `xingai-travel-ai` → https://travel.xingai.app  
**Companion skills (read when relevant):**

| Skill | Role |
|---|---|
| `project-init` | Scaffold + visual hard gate (icons, hero light/dark, motion, chrome) |
| `xingai-web-design` | UI tokens, decision UX, anti-slop, mobile chrome details |
| `create-project` (this) | Full website: routes, i18n URLs, SEO/AEO, cache, content, ship bar |

Do **not** call the site “done” after chrome + one page. Travel-grade means crawlers and users both get a real product graph.

---

## When to use which skill

1. **Brand-new empty repo** → run `project-init` first (baseline), then continue with this skill.
2. **Existing shell that needs to become a real site** → start here; pull missing `project-init` gates as you go.
3. **UI-only polish** → `xingai-web-design` only.

---

## Gold-standard outcomes (Travel)

A finished site must satisfy all of these:

1. **Primary job is obvious** — one decision/tool route + home that explains it (Travel: `/` + `/decide`).
2. **Content graph** — intent pages that answer before conversion (how-it-works, FAQ, compares, guides, city/stories as applicable).
3. **Path locales** — indexable `en` (unprefixed) + `/zh` `/ko` (+ `/es` if product supports it) with matching first-HTML body + metadata.
4. **Static HTML for evergreen pages** — `app/[locale]/…` + `generateStaticParams`; **no** `headers()` in root layout (avoids `private, no-store`).
5. **Discoverability** — sitemap with hreflang, robots, `llms.txt`, page-scoped JSON-LD, JPEG OG images.
6. **Legal** — Privacy / Terms / Disclaimer (+ affiliate disclosure if monetized); footer + drawer links; family backlink to xingai.app.
7. **Engineering** — Vitest (or repo test runner) for critical lib/API; lint green on `main`; README version notes.
8. **Human ops named** — GSC, affiliates, metrics dashboards stay human unless the user asks to automate.

Details: [references/travel-gold-standard.md](references/travel-gold-standard.md).

---

## Build phases (do in order)

Copy and track:

```text
Create-project progress:
- [ ] 0. Product one-liner + URL map frozen
- [ ] 1. project-init baseline (visual gate + chrome + theme + en/zh/ko)
- [ ] 2. Core tool route + home
- [ ] 3. Content graph (intent pages → tool CTA)
- [ ] 4. Path locales + static [locale] + proxy rewrite
- [ ] 5. Localized metadata + JSON-LD + sitemap hreflang
- [ ] 6. OG JPEG + share cards
- [ ] 7. Legal complete (all locales blurbs / pages)
- [ ] 8. Funnel events + rate limits (if AI/tool)
- [ ] 9. Tests + CI green + README
- [ ] 10. Production smoke (cache HIT, titles, hreflang)
- [ ] 11. dot-app registration (src + srcDark)
```

### Phase 0 — Freeze the product

Write in README (short table):

| URL | Role | Indexable? |
|---|---|---|
| `/` | Product home | yes |
| `/<tool>` | Primary action | yes |
| Session routes | Per-browser state | noindex, out of sitemap |

Freeze the public title string for ~30 days unless factual error (Travel pattern).

### Phase 1 — Baseline shell

Follow `project-init` fully: mobile chrome, desktop sidebar (if product family requires), hero light/dark, OG placeholder, motion, en/zh/ko, light/dark, legal stubs, robots/sitemap/llms stubs, dot-app Soon card if needed.

### Phase 2 — Core product

- Tool route works end-to-end (even if AI is mocked).
- Home explains the system and CTAs into the tool.
- Empty states and 404 point back to tool / home / content index.

### Phase 3 — Content graph

Ship pages that **answer first**, then CTA to the tool. Prefer depth over thin stubs (Travel learned compare/guides under ~300 words still lose audits).

Minimum for lifestyle/decision products:

- `/how-it-works` (methodology)
- `/faq` (visible FAQ = JSON-LD FAQPage)
- At least one of: `/compare`, `/guides`, city/story layer

Internal links: human labels, locale-aware hrefs on indexable pages.

### Phase 4 — Path locales + static cache

**Required pattern** (Travel / Invest-aligned):

1. Indexable pages under `app/[locale]/…` with `generateStaticParams` for `en|zh|ko(|es)`.
2. Root `proxy.ts` (Next 16; not deprecated `middleware.ts` name):
   - Rewrite bare English `/path` → `/en/path`
   - Pass through `/zh|ko|es/…`
   - Redirect `/en/…` → bare English (unique canonicals)
   - Session routes stay unprefixed; prefixed session URLs redirect bare
3. **Never** call `headers()` / `cookies()` in root layout or evergreen `generateMetadata` unless the page must be dynamic.
4. Language switcher updates the **path**; URL wins over `localStorage`.
5. Session UI may keep client-only locale.

Full recipe: [references/locale-static-seo.md](references/locale-static-seo.md).

### Phase 5 — Metadata that matches the URL language

For every indexable locale URL:

- `<title>`, meta description, `og:title`, `og:description`, `og:locale`
- `canonical` = self; `alternates.languages` = en / zh-CN / ko / es / x-default
- JSON-LD `inLanguage` + headlines in that locale
- Body copy already localized in the **first HTML**

Anti-pattern (Travel regression): path locale + English-only `pageMeta()` → SEO value ≈ zero for `/zh`.

Use a static copy map (`lib/seo-page-copy.ts`) + `pickLocalized` / `pickText` for dynamic pages.

### Phase 6 — Share images

- On-page photos: webp OK
- `og:image` / Twitter: **JPEG** (many crawlers still weak on webp)
- Export script + `/assets/og/*.jpg` (or product equivalent)

### Phase 7 — Legal

- Full pages for privacy / terms / disclaimer (+ affiliate if needed)
- en body + zh/ko/(es) summaries at minimum; expand when regulated
- `/legal/{privacy,terms,disclaimer}` → local pages
- Footer: legal + crawlable `https://xingai.app/` (+ `/apps`)

### Phase 8 — Product telemetry (tools/AI)

- Aggregate counters only (no free-text PII in metrics)
- Funnel: start → success/fail → CTA view → outbound click
- Rate limit AI routes; document Redis/env in README

### Phase 9 — Engineering bar

- Unit tests for pure lib + critical API routes (mocked model)
- Smoke tests for form validation, 404 title, locale helpers
- `npm run lint` must be green on `main` (Vercel may still deploy on red CI — do not rely on that)
- README Status table with dated notes for user-visible ships

### Phase 10 — Production smoke

After deploy to `*.xingai.app`:

```bash
# Cache: evergreen should be public (not private,no-store)
curl -sSI "https://PRODUCT.xingai.app/zh/<tool>" | rg -i 'cache-control|x-vercel-cache'

# Titles follow locale
curl -sS "https://PRODUCT.xingai.app/zh/<tool>" | rg -o '<title>[^<]+</title>'

# Sitemap lists locale URLs + hreflang
curl -sS "https://PRODUCT.xingai.app/sitemap.xml" | rg -c 'hreflang="zh-CN"'
```

Expect: `cache-control: public…`, CDN `HIT`/`PRERENDER` on second hit, localized `<title>`, sitemap coverage ≈ pages × locales.

Crawl checklist: [references/ship-audit.md](references/ship-audit.md).

### Phase 11 — Marketing registration

Register in `xingai-dot-app` with en/zh/ko labels, live URL, icon, `src` + `srcDark` screenshots.

---

## Surface map (default)

| Surface | Required? | Notes |
|---|---|---|
| `/` home | yes | Explains system; primary CTA |
| Tool route | yes | Conversion |
| How it works | yes | Methodology + HowTo JSON-LD |
| FAQ | yes | Visible FAQ + FAQPage |
| Content indexes | recommended | compare / guides / city / stories |
| Legal ×3(+1) | yes | privacy, terms, disclaimer, affiliate if paid |
| `/result` or session | optional | noindex |
| `llms.txt` | yes | Keep in sync with routes |
| `sitemap.xml` / `robots.txt` | yes | Indexable only |

URL rules: [references/website-surface-map.md](references/website-surface-map.md).

---

## Hard gates (block “done”)

Stop and fix before calling create-project complete:

1. **Visual gate** from `project-init` still applies.
2. **Locale gate** — non-English indexable URLs exist; first HTML body + title/description match; hreflang mutual.
3. **Cache gate** — evergreen HTML is not `private, no-store` solely because of locale; root layout has no request `headers()`.
4. **SEO gate** — unique title/description/canonical/OG per indexable route; JPEG OG; sitemap lists all locale URLs.
5. **CI gate** — lint + tests green on the shipped commit.
6. **Legal gate** — three legal pages linked; suggestions/disclaimer language present for AI products.

---

## Anti-patterns (Travel lessons)

- Client-only language toggle with `hreflang` pointing at English URLs.
- `headers()` locale in root layout → whole site dynamic / uncached.
- English `pageMeta` on `/zh` / `/ko` / `/es`.
- WebP-only `og:image`.
- Thin content pages (&lt; ~300 words) sold as “SEO done”.
- Feature-branch Preview treated as production ship for public sites.
- Shipping while CI red because “Vercel still deployed”.
- Unversioned `/assets` with multi-day `max-age` (fingerprint or leave short TTL).

---

## Final report format

When finishing a create-project run, report:

1. Product URL + primary tool path  
2. Locale set (en / zh / ko / es?)  
3. Indexable page count × locales (sitemap)  
4. Cache smoke (`public` + HIT/PRERENDER)  
5. Sample localized titles  
6. CI status  
7. Human leftovers (GSC, affiliates, metrics)

No “要不要继续” — list only true blockers.
