# Scoring rubric

Score each item 0 / 1 / 2. Lens score = (sum / (2 × items scored)) × weight.
Skip items that do not apply and say why.

## 1. UX & conversion (20)

1. Value proposition is clear above the fold in under 5 seconds, without animation.
2. One primary CTA, visually dominant, repeated at natural decision points.
3. Information architecture: nav labels are plain, depth <= 3 clicks to any key page.
4. Core flow works with no sign-up wall before the first value moment.
5. Social proof or trust signals: real names, sources, status labels, contact.
6. Mobile-first: thumb-reachable nav, no horizontal scroll, tap targets >= 44px.
7. Copy is specific and consistent (no contradictory counts or claims).
8. Empty, loading, error and offline states are designed, with honest waiting UX.
9. Forms are short, labelled, validated inline, and recover from errors.
10. Pricing/limits and next step are visible; no dark patterns.
11. Visual hierarchy, spacing and type scale are consistent; dark/light both work.
12. Localization is complete (not machine-stub), language switch persists.

## 2. SEO (15)

1. Crawlable: 200 on key URLs, no accidental `noindex`, `robots.txt` sane.
2. XML sitemap lists canonical URLs, includes lastmod, referenced in robots.
3. One canonical per page, self-referencing; no duplicate paths.
4. hreflang is complete, reciprocal, with x-default.
5. Unique `<title>` (<= ~60 chars) and meta description (<= ~160) per page.
6. One `<h1>`, logical h2/h3 outline, keywords present naturally.
7. Internal linking: every important page linked from at least two others; no orphans.
8. Clean URLs, no redirect chains, 404 returns real 404, legal paths resolve.
9. Open Graph / Twitter cards with a real image per page.
10. Structured data valid for the page type (Organization, WebSite, Product,
    Article, FAQPage, BreadcrumbList as applicable).
11. Content depth: pages target distinct intents; no thin or duplicate pages.
12. Off-page basics: Search Console and Bing Webmaster verified, backlinks plan,
    brand SERP owned.

## 3. AEO (10)

1. Question-led headings with a 40-60 word direct answer beneath.
2. FAQ block marked up (FAQPage) and matching visible text.
3. Definitions: "What is X" answered in the first 100 words.
4. Lists, tables and steps in clean semantic HTML (snippet-friendly).
5. Entity clarity: consistent name, description, founders, URL, sameAs links.
6. Concise page summaries and TL;DRs near the top.
7. Speakable or short-answer content for voice where relevant.

## 4. GEO — generative engine optimization (10)

1. `llms.txt` present, accurate, current, links to canonical pages.
2. AI crawlers are not blocked unintentionally (GPTBot, ClaudeBot,
   PerplexityBot, Google-Extended, CCBot); policy is deliberate.
3. Facts are quotable: specific numbers, dates, named sources, citations.
4. Claims are verifiable and labelled (tested vs. self-reported); no hype.
5. Content is in server-rendered HTML, not hidden behind JS or auth.
6. Authority signals: authorship, About/Team page, contact, update dates.
7. Consistent entity description across site, llms.txt, schema, and profiles.
8. Third-party presence an LLM can corroborate (docs, blog, GitHub, directories).
9. Test it: ask 3-5 target questions in two assistants; record whether the
   site is cited and whether the description is correct `[tested]`.

## 5. Performance & accessibility (15)

1. TTFB < 0.6s on cached routes; CDN cache hit on HTML where safe.
2. LCP < 2.5s, CLS < 0.1, INP < 200ms (lab or field; state which).
3. Total page weight and JS budget reasonable; no blocking third-party scripts.
4. Images: modern formats, sized, lazy-loaded, priority on LCP image.
5. Video does not autoplay heavy assets or block first paint.
6. Fonts: subset, `font-display`, no layout shift.
7. Every informative image has alt text; decorative images use empty alt.
8. Colour contrast >= 4.5:1 body, 3:1 large text, both themes.
9. Keyboard operable, visible focus, correct landmarks and ARIA, skip link.
10. `prefers-reduced-motion` respected; animations never hide content.
11. Works at 200% zoom and 320px width.
12. HTTPS only, HSTS, HTTP/2 or 3, compression on.

## 6. CTO — risk and delivery (15)

1. Security headers: CSP, X-Frame-Options/frame-ancestors, Referrer-Policy,
   Permissions-Policy, nosniff.
2. Secrets never in client bundles or repos; env handling documented.
3. AuthN/Z correct: least privilege, rate limits, input validation, CORS not `*`
   on credentialed routes.
4. Dependency hygiene: lockfile, audit clean or triaged, update cadence.
5. CI on every PR: lint, types, tests, security scan; main is protected.
6. Test coverage on the money paths and the worker/cache boundary.
7. Observability: error tracking, uptime checks, logs, product analytics.
8. Reliability: health endpoints, graceful degradation, stale-cache semantics,
   rollback path.
9. Cost control: unit cost of each request/LLM call known, caps and alerts set.
10. Privacy and legal: privacy policy, terms, disclaimer, cookie handling
    match actual data flows; no PII in URLs or logs.
11. Bus factor: runbook, README, ADRs, one-command setup.
12. Roadmap realism: what is live vs. planned is honest and tracked.

## 7. Architecture (15)

1. Clear boundaries: read path vs. compute path (CQRS); workers compute,
   API reads cache, frontend renders.
2. Rendering strategy fits each page (static, ISR, SSR, client) and is intentional.
3. Cache layers are separate and explicit (CDN, app, data); invalidation defined.
4. Data model and migrations are versioned; backups and restore tested.
5. API contracts typed and versioned; consistent error shape.
6. Modularity: shared UI/chrome/i18n reused across products, not copy-pasted.
7. Failure isolation: one slow upstream cannot take the page down.
8. Scalability path: stateless services, queue for slow work, horizontal scale.
9. Decision records exist for the big choices (ADRs) and match the code.
10. Environment parity: local, preview, production differ only by config.
11. Extensibility: adding a product, language or page is a small change.

## Caps (apply after scoring)

- Site is `noindex`, blocked in robots, or not on HTTPS: total capped at 50.
- Core content not present in server HTML: SEO, AEO and GEO each capped at 60%.
- Critical security issue (exposed secret, open admin, injectable input):
  CTO capped at 40% and total capped at 70.
- No legal pages on a site collecting data or giving finance/health content:
  CTO capped at 60%.
- Contradictory or false claims on the page: UX and GEO each lose 20%.
