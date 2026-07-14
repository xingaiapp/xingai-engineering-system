---
name: xingai-project-pick
description: >-
  Decides which XingAI project to create or upgrade next from an Opportunity
  Radar issue (same context as the newsletter email). Emits a bilingual Decision
  Card with one PICK, rejected alternatives, and do-not-build lines. Use when
  the user asks to pick a XingAI project, 立项选型, Project Pick, Build Gate,
  portfolio bet, or which opportunity from a Radar issue/email to build.
---

# XingAI Project Pick

Turn a Radar **issue / newsletter brief** into a **single portfolio bet** — not another summary.

Canonical CLI (optional): `xingai-opportunity-radar/agents/project_pick.py`  
Portfolio facts: `xingai-opportunity-radar/config/portfolio.yaml`  
ADR: `xingai-opportunity-radar/docs/adr/005-project-pick-agent.md`

Prefer running the CLI when that repo is available. If not, follow this skill manually with the same rules and card format.

---

## When This Skill Applies

- User pastes or points at a Radar issue / email / Top Opportunity
- User asks: which XingAI project to build, upgrade, or reject this week
- After newsletter send: “what should we build from this?”

**Do not** use for: writing a new Radar issue, sending newsletter email, or scaffolding without a confirmed PICK (use `project-init` after human confirms).

---

## Workflow

Copy and track:

```text
Project Pick:
- [ ] 1. Load issue context (EN + ZH if present)
- [ ] 2. Load portfolio.yaml (or reference.md snapshot)
- [ ] 3. Run CLI if possible; else reason with same rubric
- [ ] 4. Emit Decision Card EN + ZH
- [ ] 5. Stop for human confirm — no new repo yet
```

### 1. Load issue context

From `xingai-opportunity-radar`:

- Latest or named `issues/YYYY-MM-DD-*.md` (exclude picking `.zh.md` as the only source — load EN, then companion `*.zh.md`)
- Extract the same fields as the newsletter featured card:
  - Top Opportunity **name** (first bold title)
  - pitch, Who pays, MVP, Business model, Build this week
  - XingAI Application hooks
  - One Sentence Insight + sources

CLI:

```bash
cd xingai-opportunity-radar
.venv/bin/python agents/project_pick.py --issue issues/YYYY-MM-DD-slug.md
# writes agents/out/latest.en.md + latest.zh.md
```

### 2. Portfolio constraints (hard)

Read [reference.md](reference.md) or `config/portfolio.yaml`.

**Prefer upgrade** when the thesis is:

- agent audit / trust / approval → `agent-firewall` or `robinhood-mcp`
- inference cost / market tracking → `invest` surface (not a new broker)
- research → product artifacts → `research` or `founder`

**Hard reject:**

- Chat shell with no decision output
- Orphan `*.xingai.app` that duplicates an existing chrome product without init checklist
- Request-path Invest decision computation (worker-cache boundary)
- Payment/medical-compliance-first MVP before legal pages

### 3. Score candidates (0–5 each)

For the featured opportunity + each XingAI hook as a candidate:

| Dimension | Question |
|-----------|----------|
| Portfolio fit | New vertical vs upgrade vs orphan? |
| Reuse leverage | chrome / i18n / worker-cache / MCP / Firewall? |
| Founder fit | Can Xing ship a demable decision surface in 2 weeks? |
| Time-to-signal | Pay / use proof inside 14 days? |

**Output exactly one PICK.** Always list ≥2 rejected options with reasons.

### 4. Decision Card format (required)

Emit **both** languages (or EN then ZH). Match:

```markdown
# XingAI Project Pick — Decision Card

**Date:** YYYY-MM-DD
**Engine:** cli|heuristic|manual|openai:…
**Issue:** <subtitle>
**Featured opportunity (from email):** <name>

---

## PICK: <name>

- **Mode:** new | upgrade (upgrade of `<id>`)
- **Repo home:** `xingai-…`
- **Scores:** portfolio n/5 · founder n/5 · time-to-signal n/5 · reuse n/5

### Why now
…

### 2-week MVP
…

### Who pays
…

### Business model
…

## Rejected (do not start these instead)

- **…** (new|upgrade): …

## Do not build

- …

## Handoff
- Next: Confirm pick → Founder seed or project-init skill
- Radar theme: …

_Not investment advice. Editorial decision aid for XingAI founders only._
```

中文卡标题：`# XingAI 立项选型 — Decision Card`（字段对齐，见 [examples.md](examples.md)）。

### 5. Stop

Do **not** create repos, deploy, or email subscribers until the user confirms the PICK. After confirm:

- Upgrade path → open the named repo and plan the module
- New path → skill `project-init`
- Optional → seed Founder `POST /api/opportunities/analyze`

---

## Anti-patterns

- Summarizing the issue again without a single PICK
- Recommending three “Build Now” projects as co-equal
- New consumer app for audit/trust when Agent Firewall can own the MVP
- Ignoring `do_not_build` in portfolio.yaml

## More

- Portfolio snapshot + paths: [reference.md](reference.md)
- Sample card (Issue #2): [examples.md](examples.md)
