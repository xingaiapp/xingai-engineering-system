# Travel gold standard (reference product)

Canonical repo: `xingai-travel-ai` · Production: https://travel.xingai.app

Use this as the bar when `create-project` asks “is this Travel-grade?”

## Product shape

| Piece | Travel example | Rule |
|---|---|---|
| Home | `/` | Explains the decision system; does not redirect to the tool |
| Tool | `/decide` | Captures constraints → compares → winner + trade-offs → book links |
| Session | `/result`, `/trips` | `noindex`, not in sitemap |
| Content | `/how-it-works`, `/faq`, `/compare`, `/guides`, `/city`, `/stories` | Answer first, CTA to tool |
| Legal | privacy, terms, disclaimer, affiliate-disclosure | Footer + drawer |

## Architecture snapshots worth copying

### Locale + static HTML

- Pages: `app/[locale]/…` + `generateStaticParams` for `en|zh|ko|es`
- Edge: `proxy.ts` rewrites bare English → `/en/…`; `/zh|ko|es` pass through; `/en/…` redirects bare
- Chrome: `AppShell` + `LocaleProvider(initialLocale)` inside `[locale]/layout`
- Session layouts reuse `AppShell` without locale param
- Helpers: `lib/public-locale.ts`, `lib/locale-params.ts`, `lib/seo-page-copy.ts`, `lib/seo-meta.ts`

### SEO / AEO

- Shared `pageMeta({ path, title, description, locale })` → canonical + hreflang + OG/Twitter
- Sitemap emits every locale URL with `alternates.languages`
- Page-scoped JSON-LD (FAQPage, HowTo, Article) — not one giant FAQ on every page
- `llms.txt` lists primary routes **and** locale prefixes
- OG: JPEG under `/assets/og/`; on-page media can stay webp

### Engineering

- Vitest: lib helpers, mocked API routes, smoke product tests, locale/seo copy tests
- Metrics: Redis day hashes; funnel events via `/api/track` + server `after()`
- Rate limits on AI routes
- README Status table with dated ship notes

## What audits punished

1. Path locales without localized `<title>` / description / og  
2. `headers()` locale → `private, no-store` sitewide  
3. CI red on `main` while Production still green  
4. Thin compare/guides copy  
5. Legal Spanish missing while `/es` URLs existed  
6. WebP OG on social crawlers  

## Human-only (do not fake as code done)

- Google Search Console property + sitemap submit  
- Affiliate partner apps + env IDs + live click check  
- Reading `npm run metrics` / Redis funnel numbers  
