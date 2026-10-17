---
name: xingai-site-audit
description: >-
  Scores a live website and/or its codebase from seven expert lenses (UX,
  SEO, AEO, GEO, performance and accessibility, CTO, architecture) and turns
  the findings into a traffic-first fix list. Use when Xing asks to evaluate,
  audit, score or review a site or project, including phrasings like "评估网站",
  "打分", "网站体检", "SEO/AEO/GEO 检查", "从 CTO 角度看", "怎么提升流量", or gives a
  URL or repo and asks how good it is.
---

# XingAI Site Audit

Evaluate a site or project the way a panel of experts would, give a number,
and say what to fix first to get more traffic. Chat with Xing in Chinese;
write the report in the language Xing asks for (default: Chinese body, English
technical terms).

## Principles

1. **Evidence over opinion.** Every score cites something you observed. Tag each
   finding `[tested]` (you ran it), `[read]` (seen in source or page text),
   `[inferred]` (reasoned, not observed) or `[not verified]`. Never score an
   area you did not look at: mark it `n/a` and exclude its weight.
2. **Traffic-first ordering.** Rank fixes by expected traffic or conversion
   impact divided by effort, not by how much the problem offends the auditor.
3. **One source of HTML.** Users and crawlers must get the same content. Flag
   any content that exists only after client-side JS or an animation.
4. **Do not paste a generic checklist.** Use the rubric, but drop items that do
   not fit the product (e.g. no local-business schema for a SaaS tool).
5. **Research, not advice.** For finance/health content judge disclosure and
   sourcing; do not rate the content as a recommendation.
6. **Read-only.** Probing is fine. Do not submit forms, create accounts, or
   load-test someone else's site.

## Inputs

- A URL, a repo path, or both. With both, run site and code passes and
  cross-check (what the repo says vs. what production serves).
- Optional: target audience, target keywords/queries, main conversion goal,
  competitors. If missing, infer them from the homepage and say so.

## Workflow

1. **Scope.** State what you are auditing, the assumed audience and goal.
2. **Probe the live site** (see `references/probes.md`): status codes, headers,
   `robots.txt`, `sitemap.xml`, `llms.txt`, canonical/hreflang/meta/JSON-LD,
   legal pages, subdomain health, mobile viewport (375px) overflow, image alt,
   heading structure, page weight, TTFB. Use `curl` for facts and the built-in
   browser for rendered behaviour and screenshots.
3. **Read the code** if a repo is given: routing and rendering mode, data
   boundaries, caching, auth, secrets handling, tests, CI, dependencies,
   observability, deployment.
4. **Score** each lens with `references/rubric.md`. Each item is 0 (missing or
   broken), 1 (partial), 2 (good). Lens score = earned / possible × weight.
   Apply the **caps** at the end of the rubric.
5. **Rank fixes** into Now (this week), Next (this month), Later, using
   impact vs. effort. Maximum three items in Now.
6. **Report** with `references/report-template.md`. Lead with the total and the
   three things that matter most.

## Lenses and weights (total 100)

| Lens | Weight | Question it answers |
|---|---|---|
| UX & conversion | 20 | Can a first-time visitor understand it in 5 seconds and take the next step? |
| SEO | 15 | Can search engines crawl, index and rank it? |
| AEO (answer engines) | 10 | Can featured snippets, voice and assistant answers lift it directly? |
| GEO (generative engines) | 10 | Will ChatGPT/Claude/Perplexity/Gemini cite and describe it correctly? |
| Performance & accessibility | 15 | Is it fast, stable and usable by everyone? |
| CTO (risk and delivery) | 15 | Is it safe, reliable, affordable and shippable by a small team? |
| Architecture | 15 | Will the design survive growth without rewrites? |

Grades: 90+ excellent, 80-89 strong, 70-79 solid with gaps, 60-69 needs work,
below 60 fix fundamentals before promoting.

## XingAI-specific checks (apply when the target is a *.xingai.app product)

- Foundation chrome: top bar, side drawer, bottom nav on mobile; en / zh / ko;
  light/dark; privacy, terms, disclaimer reachable at predictable paths.
- Product Upgrade Rule: later versions keep the visual language and earlier
  user-facing features; no internal version labels in the UI.
- Invest AI: FastAPI only reads cache; no request-time decision logic;
  frontend renders cached fields only.
- CQRS: API handlers never call external services live; workers write.
- Honest status labels (live / demo / planned) match what actually works.

## Output rules

- Save the report to the scratchpad or a path Xing names, not into a public
  repo, unless Xing says so. Reports can mention private details.
- Never put secrets, real holdings or private repo contents in a report that
  may be published. Run the public-safety scan before publishing anything.
- End with the single most valuable next action and offer to do it.
