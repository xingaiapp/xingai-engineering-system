# Website surface map

Default surfaces for a XingAI `*.xingai.app` product site. Drop rows that do not apply; do not invent empty “Soon” routes in the bottom nav without disabled + toast.

## Always

| Path | Purpose |
|---|---|
| `/` | Product home — positioning + primary CTA |
| Tool route (e.g. `/decide`) | Core conversion |
| `/how-it-works` | Methodology; HowTo JSON-LD |
| `/faq` | Visible FAQ; FAQPage JSON-LD |
| `/privacy` `/terms` `/disclaimer` | Legal |
| `/llms.txt` | AEO plain summary |
| `/sitemap.xml` `/robots.txt` | Crawl |

## Usually

| Path | Purpose |
|---|---|
| `/compare` + `/compare/[slug]` | A vs B decision pages |
| `/guides` + `/guides/[slug]` | Intent guides |
| Content layer (`/city`, `/stories`, …) | Depth + long-tail |
| `/affiliate-disclosure` | If any partner links |

## Session / noindex

| Path | Rules |
|---|---|
| `/result`, `/trips`, `/s`, dashboards | `robots: noindex`; omit from sitemap; no locale prefix |

## Locale expansion

For each **indexable** bare path `P`:

- English: `P`
- Others: `/zhP`, `/koP`, `/esP` (leading slash rules: `/` → `/zh`, `/decide` → `/zh/decide`)

Session paths never get locale prefixes.

## Footer crawl set

Plain anchors (not JS-only):

- Legal pages
- `https://xingai.app/`
- Usually `https://xingai.app/apps`
- Optional sibling products (Cook, Wear, Invest, …)

## Nav rules

- Same destinations on mobile drawer, bottom tabs, and desktop chrome
- Language + theme always reachable on mobile (top bar or drawer)
- No internal version labels (V1/V2) in UI
