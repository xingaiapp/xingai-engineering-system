# Path locales + static SEO (required recipe)

Goal: every indexable language has its own URL, first-HTML copy, metadata, and CDN-cacheable HTML.

## Do

1. Put evergreen pages under `app/[locale]/…`.
2. `generateStaticParams()` returns `{ locale: "en"|"zh"|"ko"|"es" }` (product locale set).
3. Resolve locale from `params` via `localeFromParams` — **not** `headers()`.
4. Root `layout.tsx` must not read `headers()` / `cookies()` for locale.
5. `proxy.ts` (Next 16 file convention):

```ts
// Bare English → internal /en/…
// /zh|ko|es/… → next()
// /en/… → redirect to bare path (unique canonical)
// Prefixed /zh/result → redirect /result
```

6. Language switcher: `router.push(localizedPublicHref(next, barePath))`.
7. Nav `Link` hrefs use `localizedPublicHref` on indexable paths.
8. `pageMeta` / sitemap share one `hreflangPaths` helper:
   - keys: `en`, `zh-CN`, `ko`, `es` (if supported), `x-default` → English

## Metadata per locale

| Field | Source |
|---|---|
| title / description | `seo-page-copy` map or Localized fields |
| og:title / og:description | same strings as title/description |
| og:locale | `en_US` / `zh_CN` / `ko_KR` / `es_ES` |
| canonical | absolute localized URL |
| JSON-LD inLanguage / headline | same locale as page |

## Sitemap

For each bare indexable path, emit **one entry per locale** with shared `alternates.languages`. Exclude session routes.

## Cache expectations (Vercel)

After a correct static locale ship:

- `cache-control: public, max-age=0, must-revalidate` (Travel evergreen — do not invent long HTML TTL)
- First hit may be `PRERENDER` / `MISS`; second hit should be CDN `HIT`
- **Fail** if all pages return `private, no-store` after a locale feature

Workspace rule: `.cursor/rules/xingai-cache-seo-aeo-geo.mdc`.

## Regression tests (minimum)

- `stripLocalePrefix` / `localizedPublicHref` / `alternatesFor`
- Static copy titles differ by locale (`/decide` zh ≠ en)
- Optional: smoke curl script in README

## Forbidden shortcut

Middleware rewrite `/zh/…` → bare `/…` **plus** `headers("x-locale")` in layout — works for UI, **breaks** static cache and tempts English metadata. Travel hit this; do not repeat.
