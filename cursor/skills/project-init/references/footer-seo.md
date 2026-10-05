# Footer + SEO / AEO / GEO (required)

Every public `*.xingai.app` product must ship a crawlable footer that reinforces legal coverage and XingAI family equity. Text-only chrome without these links fails project-init.

## Required footer blocks

1. **Legal triad (required)**  
   Plain in-app links to Privacy, Terms, and Disclaimer. Prefer local routes (`/privacy`, `/terms`, `/disclaimer`) as the canonical pages.

2. **Foundation slug aliases (required)**  
   Also accept foundation paths so external docs and bots that expect `/legal/*` do not 404:

   | Foundation slug | Destination |
   |---|---|
   | `/legal/privacy` | `/privacy` |
   | `/legal/terms` | `/terms` |
   | `/legal/disclaimer` | `/disclaimer` |

   Use Next `redirects()` (307/308) like Invest — do not duplicate three legal page trees.

3. **Family backlink (required)**  
   Crawlable **plain** `<a href="…">` (not `next/link` only, not buttons, not `rel="nofollow"`):

   - `https://xingai.app/` — “Part of XingAI”
   - `https://xingai.app/apps` — “All apps”
   - 2–3 sibling live products (omit self), e.g. Cook / Wear / Travel / Invest

   Same family row belongs in **page footer HTML** (first SSR). Mobile drawer may repeat it; legal must appear in the drawer either way.

4. **Internal discover links (recommended for AEO/GEO)**  
   Link high-intent content from the footer: `/how-it-works`, `/faq`, `/compare`, `/guides` (or product equivalents). Keeps one HTML graph for users and answer engines.

## Markup rules

- Family and legal links must appear in the **first HTML** (AppChrome / layout footer), not only after client navigation.
- Brand product names may stay English; surrounding UI copy goes through i18n (`en` / `zh` / `ko`).
- Do not put family links behind login, tabs, or JS-only menus that omit them from SSR.

## Align with SEO / AEO / GEO

| Layer | Footer role |
|---|---|
| **SEO** | Equity to `xingai.app` + `/apps`; legal discoverability; internal links to intent pages |
| **AEO** | Same URLs as `llms.txt` “Related apps”; FAQ/how-it-works linked where the product has them |
| **GEO** | One HTML for users and bots — no cloaking; family anchors stay in the shared document |

Also keep: `robots.txt` → `sitemap.xml`, `llms.txt`, JSON-LD, self-canonicals. Client-only locale toggles are **not** indexable languages — do not invent `hreflang` until each language has its own URL in the first HTML.

## Reference implementations

- Travel: `xingai-travel-ai/components/app-chrome.tsx` footer + `/legal/*` redirects in `next.config.mjs`
- Invest: `stock-ai-front-end/components/dashboard/footer.tsx` + `next.config.mjs` redirects
- Cook: `cook_v1/components/family-footer.tsx`

## Anti-patterns

- Footer with Privacy/Terms only and no Disclaimer
- `/legal/privacy` 404 while marketing docs link that path
- Family links only as styled `<button>` or `next/link` without a real `href` crawlers can follow to `xingai.app`
- `rel="nofollow"` on XingAI family links
- Hard-coding English legal/footer chrome while the rest of the UI is localized
