# Ship audit (pre-GSC crawl)

Run after Production deploy. Prefer real `*.xingai.app` URLs.

## Automated smoke

```bash
HOST=https://PRODUCT.xingai.app

# 1) Home + tool
curl -sSI "$HOST/" | rg -i 'HTTP/|cache-control|x-vercel-cache'
curl -sSI "$HOST/<tool>" | rg -i 'HTTP/|cache-control|x-vercel-cache'

# 2) Locale titles (must not all be English)
for u in /zh/<tool> /ko/<tool> /es/<tool>; do
  echo -n "$u -> "
  curl -sS "$HOST$u" | rg -o '<title>[^<]+</title>' | head -1
done

# 3) hreflang present
curl -sS "$HOST/zh/<tool>" | rg -o 'hreflang="[^"]+"' | sort -u

# 4) Sitemap scale ≈ indexable_pages × locales
curl -sS "$HOST/sitemap.xml" | rg -c '<url>'
curl -sS "$HOST/sitemap.xml" | rg -c 'hreflang="zh-CN"'

# 5) Second request should CDN HIT on evergreen
curl -sSI "$HOST/zh/<tool>" | rg -i 'x-vercel-cache'
```

## Manual / browser

- [ ] Language switcher changes URL and keeps the same bare path
- [ ] Nav links keep locale prefix on indexable pages
- [ ] Session route from `/zh/tool` does not stay on `/zh/result` (redirect bare)
- [ ] Light / dark both readable; hero pair swaps
- [ ] Mobile ~375px: top bar, drawer, bottom nav clearance
- [ ] Footer legal + xingai.app anchors are plain `<a>`
- [ ] Share debugger / Slack unfurl shows JPEG OG (spot-check 2–3 URLs)

## Score-killing failures

| Fail | Meaning |
|---|---|
| All `/zh` titles English | Metadata not localized |
| `private, no-store` on home/tool | `headers()` or dynamic root |
| Sitemap missing `/zh` | Locale URLs not emitted |
| Body English on `/zh` first HTML | Client-only i18n |
| CI red on shipped SHA | Do not leave main broken |

## Human follow-ups (checklist only)

- [ ] Search Console: property verified, sitemap submitted
- [ ] Affiliate IDs in env; one live Book/outbound click
- [ ] Metrics command / dashboard reviewed for funnel
