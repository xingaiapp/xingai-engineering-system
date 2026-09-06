---
name: xingai-brand-story
description: >-
  Writes XingAI brand, product story, and marketing copy aligned with xingai.app
  positioning — decision systems (not chatbots), everyday + invest clusters,
  product URLs, en/zh/ko tone. Use when drafting hero copy, About/Story pages,
  app catalog text, FAQs, llms.txt, README intros, social posts, or any
  user-facing XingAI narrative.
---

# XingAI Brand Story

Guidance for **brand voice, product narrative, and marketing copy** across `xingai.app`, `*.xingai.app`, and repo READMEs. Pair with **`xingai-web-design`** for UI and **`anti-ai-writing-style`** for tone.

## When to apply

- Hero, About, Story, Apps listing, app detail pages
- `llms.txt`, FAQ, JSON-LD descriptions, OG titles
- Product README intros, launch posts, contact/early-access copy
- User asks for “XingAI positioning”, “how products fit together”, or “brand voice”

**Not for:** component CSS, API docs, ADR internals, legal clause drafting (link to `/legal/*` instead).

## Canonical sources (read first)

| Source | Path |
|--------|------|
| Live copy (en/zh/ko) | `xingai-dot-app/app/i18n/translations.ts` |
| Story clusters + invest flow | `xingai-dot-app/app/data/ecosystem.ts` |
| Product map (repos, domains) | `xingai-dot-app/docs/product-wiki.md` |
| Marketing checklist | `xingai-dot-app/docs/marketing-site-standards.md` |
| Anti-AI writing | `.cursor/rules/anti-ai-writing-style.mdc` |

When copy conflicts, **translations.ts on dot-app wins** for public marketing.

---

## Brand core

**Name:** XingAI (not “Xing AI”, not “xingai” in titles)

**Primary domain:** [xingai.app](https://xingai.app)

**One-line:** AI decision systems for everyday life.

**Tagline (short):** Get the right decision, every time.

**Elevator:** Not a chatbot. Not a wrapper. Focused AI products that help you decide — one real decision per app, with structure, clarity, and privacy in mind.

**Value pill:** AI decision systems, not just chat.

---

## What we build (principles)

1. **One decision per product** — structured output + clear next step; chat is optional, never the whole product.
2. **Upgrade, don’t replace** — later versions inherit prior UX and main flow; no internal V1/V2 labels in user-facing copy.
3. **Mobile-first web** — phone-first layouts; light + dark; en / 中文 / 한국어 where the product ships i18n.
4. **Two clusters** — everyday life apps stand alone; invest tools reinforce each other without one forced login.
5. **Building in public** — ship, iterate, share process; no hype or guaranteed outcomes.

### Say this

- “decision system”, “focused AI product”, “structured output”, “clear next step”
- “paper/simulation” for invest lab tools
- “early access”, “free during public beta” when true
- Real domains: `cook.xingai.app`, `invest.xingai.app`, etc.

### Don’t say this

- “AI-powered platform”, “cutting-edge ecosystem”, “seamless synergy”
- “Guaranteed returns”, “beat the market”, “financial advice”
- Generic chatbot framing (“ask anything”, “your AI assistant for everything”)
- Internal roadmap labels (V1.1, V2 dashboard) in user-facing text

---

## Product clusters

### Everyday decisions

Food, style, habits, SAT, family, travel — each product owns **one job**.

| Product | Domain | Domain label | Status note |
|---------|--------|--------------|-------------|
| Meal Coach | meal.xingai.app | Health AI · Eat Better | Live |
| Cook AI | cook.xingai.app | Cooking AI · Cook Smarter | Live |
| Outfit AI | wear.xingai.app | Style AI · Dress Smarter | Live / demo per catalog |
| Routine AI | routine.xingai.app | Habits AI · Live Better | Per catalog |
| SAT AI | sat.xingai.app | Education AI · Prep Smarter | Demo |
| Parent AI | — | Parenting AI · Family Support | In development |
| Travel AI | travel.xingai.app | Travel AI · Explore Better | Live |

### Invest & trading tools

Portfolio context → rule stress-test → daily T plan. **Paper/simulation only · Not investment advice · No broker integration.**

| Product | Domain | Role |
|---------|--------|------|
| Investment Assistant | invest.xingai.app | Risk-first decision dashboard: macro radar, allocations, symbol context from **precomputed cache** |
| Performance Sim | lab.xingai.app | Same signals, different rule sets; paper ledger outcomes |
| T Today | t.xingai.app | Holdings screenshot → rules + AI plan for today; early access via contact |

**Invest flow (narrative order):**

1. Read macro and symbol context on **invest.xingai.app**
2. Stress-test rules on **lab.xingai.app**
3. Request free early access for **t.xingai.app** when you want a daily plan

---

## Voice & style

Follow **`anti-ai-writing-style`** globally:

- Human, direct, specific. Mix sentence lengths.
- Banned words: leverage, delve, seamless, robust, cutting-edge, utilize, facilitate, synergy, ecosystem, holistic, empower, innovative.
- No “Firstly / Secondly / Finally”, no “In today’s fast-paced world”, no “I hope this helps!”
- Active voice default. Short > fancy.

**Register by surface:**

| Surface | Tone |
|---------|------|
| Marketing hero | Confident, plain, one sharp idea per paragraph |
| App detail | Factual: Can do / Best for / Features; no fluff |
| Invest / finance | Risk-first; disclaimers visible; no return promises |
| Travel / lifestyle | Suggestions only; verify before booking |
| FAQ / AEO | Factual Q&A; name real URLs; sync with on-page copy |

**Brand in metadata:** Use **XingAI** in titles; use **xingai.app** for domain/URLs — don’t mix both in one phrase (e.g. avoid “XingAI xingai.app”).

---

## Copy workflow

1. **Identify surface** — home, story, app card, FAQ, llms.txt, in-app string.
2. **Pick cluster + single decision** — one job sentence before feature lists.
3. **Pull facts** from `translations.ts` / product-wiki; don’t invent URLs or launch status.
4. **Draft en first**, then zh and ko if the surface requires i18n (locale codes: `en`, `zh`, `ko`).
5. **Invest check** — disclaimer present? No request-time decision claims? Cache/worker boundary respected in technical marketing?
6. **Anti-AI pass** — cut ~20%, remove banned words, read aloud.

---

## Templates

### Hero (marketing)

```text
[Value pill — optional]
[Headline — one decision outcome, not “AI platform”]
[Sub — 2–3 concrete domains + languages if relevant]
[CTA: Try demo | See all systems | How it fits together → /story]
```

**Example (en):**

> AI decision systems, not just chat  
> Get the right decision, every time.  
> What to eat, wear, study, and how to invest — ten focused systems. English · 中文 · 한국어.

### App card (Can do / Best for)

```text
Can do: [One sentence — primary structured output]
Best for: [Audience + moment, not demographics fluff]
```

### Story page section

```text
Eyebrow: Product map
Heading: How XingAI fits together
Lead: One platform of focused decision systems—not a pile of chatbots.
Principle: Each app answers one decision with structured output and a clear next step.
Clusters: Everyday | Invest & trading tools
Invest disclaimer: Paper/simulation only · Not investment advice · No broker integration.
```

### FAQ item (AEO-safe)

```text
Q: What is [Product]?
A: [Product] is a [domain] decision system at [url]. It [one primary job]. [Optional: languages/themes]. Not [what it is not].
```

### llms.txt block (product or portfolio)

```text
# [Product name]
- URL: https://[subdomain].xingai.app
- What it does: [one sentence, one decision]
- Main flow: [3 steps max]
- Languages: en, zh, ko (if shipped)
- Disclaimer: [one line for invest/travel/legal-sensitive apps]
```

---

## i18n rules

- Marketing site: locale in URL path (`/`, `/zh/…`, `/ko/…`); switcher changes path.
- Product apps: strings through repo i18n layer — no hard-coded UI copy in components.
- Keep **meaning aligned** across en/zh/ko; don’t literal-translate invest disclaimers into softer language.
- Korean and Chinese product names: use established strings in `translations.ts` when they exist.

---

## Legal & trust (always link, don’t rewrite)

Public products link to:

- `/legal/privacy`
- `/legal/terms`
- `/legal/disclaimer`

Invest cluster: lead with risk; state paper/simulation; no broker integration.  
Travel/lifestyle: suggestions only; user verifies before booking/action.

---

## Quick checklist

- [ ] One decision per product — not “does everything”
- [ ] Real `*.xingai.app` URLs and accurate live/demo/soon status
- [ ] No banned AI-slop words; no internal version labels
- [ ] Invest copy is risk-first with disclaimer
- [ ] en/zh/ko complete if shipping the surface
- [ ] FAQ / llms.txt / hero stay in sync after positioning changes

---

## Related skills & rules

- **UI implementation:** `~/.cursor/skills/xingai-web-design/SKILL.md`
- **Workspace foundation:** `.cursor/rules/xingai-foundation.mdc`
- **Product upgrades:** workspace `AGENTS.md` → *Product Upgrade Rule* (principle + Meal/Cook/Invest examples)
- **Invest decision boundary:** `xingai-invest-ai/.cursor/rules/decision-cache-boundary.mdc` (no “live recalc” marketing that contradicts cache-only API)
