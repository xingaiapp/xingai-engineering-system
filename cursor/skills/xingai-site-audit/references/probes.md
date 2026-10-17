# Probe cookbook (read-only)

Replace `$U` with the origin, e.g. `https://example.com`.

```bash
# status, timing, size
for p in "" llms.txt sitemap.xml robots.txt privacy terms disclaimer legal; do
  curl -s -o /dev/null -w "/$p %{http_code} %{time_total}s %{size_download}B\n" "$U/$p"; done

# headers (cache, security, locale)
curl -sI "$U" | egrep -i 'cache|strict|content-security|x-frame|referrer|permissions|x-content|server|link'

# head metadata
curl -s "$U" | grep -oE '<(title|meta (name|property)="(description|robots|og:[a-z]+|twitter:[a-z]+)")[^>]*>[^<]*'
curl -s "$U" | grep -oE '<link rel="(canonical|alternate)"[^>]*>'
curl -s "$U" | grep -c 'application/ld+json'

# sitemap breakdown and hreflang entries
curl -s "$U/sitemap.xml" | grep -o '<loc>[^<]*' | sed 's/<loc>//' | awk -F/ '{print $4}' | sort | uniq -c
curl -s "$U/sitemap.xml" | grep -c 'xhtml:link'

# AI crawler policy
curl -s "$U/robots.txt" | egrep -i 'gptbot|claudebot|perplexity|google-extended|ccbot|disallow'

# is content in server HTML? (compare with rendered text)
curl -s "$U" | sed 's/<[^>]*>/ /g' | wc -w

# redirect chains
curl -sIL -o /dev/null -w "%{url_effective} %{num_redirects}\n" "$U/privacy"
```

Browser checks (375px viewport, then desktop):

```js
({sw: document.documentElement.scrollWidth, vw: innerWidth,
  h1: document.querySelectorAll('h1').length,
  imgs: document.images.length,
  noAlt: [...document.images].filter(i => !i.alt).length,
  lang: document.documentElement.lang})
```

Also: screenshot above the fold on mobile and desktop, tab through the page
for focus visibility, toggle dark/light, switch language, and check the
console for errors. If Lighthouse or PageSpeed is available, record LCP, CLS,
INP and say lab vs. field. If not, mark performance numbers `[not verified]`.

GEO test: ask two assistants 3-5 questions a target user would ask, record
whether the site is cited and whether its description is accurate.

## i18n probes

```bash
# translation key parity (adapt to the repo's file layout)
# compare key sets per locale; list keys missing in any locale

# per-locale head signals on sampled pages
for l in zh ko; do for p in "" apps pricing legal contact; do
  echo "/$l/$p"; curl -s "$U/$l/$p" | grep -oE '<html[^>]*lang="[^"]*"|hrefLang="[^"]+"|hreflang="[^"]+"|og:locale"[^>]*|<link rel="canonical"[^>]*>' | sort -u; done; done

# English leaking into a localized page (visible text lines with 3+ English words)
curl -s "$U/zh" | sed 's/<script[^>]*>[^<]*<\/script>//g; s/<[^>]*>/\n/g' | grep -E '[A-Za-z]{4,} [A-Za-z]{3,} [A-Za-z]{3,}'

# locale coverage of sibling products and subdomains
for h in app1 app2; do for l in "" zh ko; do curl -s -o /dev/null -w "$h/$l %{http_code} %{redirect_url}\n" "https://$h.example.com/$l"; done; done

# Accept-Language behaviour (should not force-redirect crawlers)
curl -sI -H "Accept-Language: ko-KR,ko;q=0.9" "$U" | egrep -i '^(HTTP|location)'
curl -s -o /dev/null -w "%{http_code}\n" "$U/zh/llms.txt"
```

## Responsive probes

Emulate 320, 375, 768 and 1280 widths in the browser, reload after each, then:

```js
({vw: innerWidth, sw: document.documentElement.scrollWidth,
  viewport: document.querySelector('meta[name=viewport]')?.content,
  smallTargets: [...document.querySelectorAll('a,button,input,select,textarea,[role=button]')]
    .filter(e => { const r = e.getBoundingClientRect();
      return r.width && r.height && (r.width < 44 || r.height < 44) }).length,
  smallText: [...document.querySelectorAll('p,li,span,a')]
    .filter(e => parseFloat(getComputedStyle(e).fontSize) < 14 && e.innerText?.trim()).length,
  imgsNoSrcset: [...document.images].filter(i => !i.srcset && i.naturalWidth > 600).length,
  overflowing: [...document.querySelectorAll('body *')]
    .filter(e => e.getBoundingClientRect().right > innerWidth + 1).length})
```

Also take a screenshot per width, open the nav on phone, focus a form field,
rotate to landscape, and set text zoom to 200%. Throttle to 4G/4x CPU slowdown
before reading LCP/INP/CLS.
