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
