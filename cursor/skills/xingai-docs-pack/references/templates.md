# Templates — XingAI Docs Pack

Use these skeletons; fill with evidence from the subject repo. Keep anti-AI writing rules.

## ADR

```markdown
# ADR-NNN: Title

**Date:** YYYY-MM-DD
**Status:** Proposed | Accepted | Superseded
**Author:** Xing @ XingAI
**Also available:** [中文](NNN-slug.zh.md)

## Context

What problem, constraint, or prior ADR forced a choice? Link related ADRs and code paths.

## Decision

What we chose. Include field maps, boundaries, or invariants in a table when useful.

## Consequences

Positive:
- …

Negative / tradeoffs:
- …

## Follow-ups

- Tech blog: …
- Enterprise design: …
- Wiki: …
```

中文 sibling: same structure with `Also available: [English](NNN-slug.md)`.

---

## Tech blog

Filename: `posts/YYYY-MM-DD-slug.md`

```markdown
# Clear Specific Title

One-paragraph hook: what shipped and why it matters as a pattern (not a changelog dump).

## The Boundary / Pattern

Explain the rule in plain language. Quote one invariant if useful.

## What We Built

Concrete paths, APIs, or schemas. No fake metrics.

## What We Did Not Do

Explicit non-goals.

## Links

- Repo: https://github.com/xingaiapp/…
- ADR: https://github.com/xingaiapp/…/docs/adr/…
- Design (if any): https://github.com/xingaiapp/xingai-enterprise-ai-design/blob/main/articles/…
```

Add README Posts table row:

`| YYYY-MM-DD | [Title](posts/….md) · [中文](posts/….zh.md) | Product | \`tag1\` \`tag2\` |`

---

## Enterprise design

Filename: `articles/YYYY-MM-DD-slug.md`

```markdown
---
title: Teaching Title
author: Xing Wang
date: YYYY-MM-DD
tags: [architecture, enterprise, …]
description: One factual sentence for SEO/cards.
---

# Teaching Title

Opening: who this is for and what decision it clarifies.

## Problem

Enterprise / team failure mode this pattern prevents.

## Pattern

Diagram or short steps. Name the invariant.

## XingAI reference

Link public repo, ADR, or POC. Do not invent production claims.

## Related Design Docs

- EN: …
- 中文: …

## Disclaimer

Educational / informational. Not legal, compliance, or professional advice. Users own their deployment risk.
```

---

## Wiki

Prefer `wiki/syntheses/<slug>.md` + `<slug>.zh.md` or `wiki/concepts/…`.

```markdown
# Title

One-line scope. Public sources only.

## Known

- Claim — cite `raw/…` or https://github.com/…

## Missing

- …

## Rethink

- …

## Debate

- Side A vs Side B — unresolved without ADR/code.

## Needs evidence

- Open questions. Do not answer by guessing.

## Links

- ADR / blog / design (absolute URLs)
```

Update `wiki/index.md` and `wiki/index.zh.md` when adding a page.
