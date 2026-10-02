---
name: xingai-ai-learning-wiki
description: >-
  Scans public xingaiapp GitHub repos and updates the XingAI AI-Learning Wiki as
  a critical bilingual (EN+中文) knowledge base: known/missing/rethink/debate —
  no copy-paste, no guessing. Includes UX PNGs on wiki pages when product/chrome
  visuals are needed. Use when building/syncing the AI wiki, ingesting public
  repos, linting, or /xingai-ai-learning-wiki.
---

# XingAI AI-Learning Wiki Builder

Public XingAI repos → `raw/` snapshots → `wiki/` per `AGENTS.md`.

Goal: a **knowledge base** that compounds — not a mirror of READMEs. Wiki pages
must state what is known, missing, to rethink, and debated — in **English and
中文** — without inventing evidence. When a product/concept page needs a **UX
visual**, include the PNG under `wiki/assets/ux/` and embed it (EN+ZH).

**Wiki path (default):**  
`/path/to/ai-projects-work-space/xingai-ai-learning-wiki`

## When to apply

- Build / update / sync the AI wiki from public repos
- Lint the wiki
- `/xingai-ai-learning-wiki`

**Not for:** private repos, Radar internals, private ADRs.  
**Not for:** ad-hoc URL/image/paste → use `xingai-wiki-ingest`.  
**Not for:** third-party-authored marketing posters (non-XingAI credit).

## Hard rules

1. **Public only** — confirm `visibility == PUBLIC` via `gh`.
2. **Read `$WIKI/AGENTS.md` first** — Epistemic standard + synthesis bar + bilingual rule + UX PNG rule.
3. **Absolute GitHub links** — no `../sibling/` paths.
4. **Synthesize + critique** — not duplicate; not hype.
5. **No guessing as fact** — mark `unknown` / `needs evidence` instead.
6. **Bilingual required** — every new/updated wiki content page is `name.md` + `name.zh.md` in the **same** pass.
7. **UX PNG when needed** — product chrome / flow / theme / demo UI → snapshot UX assets and embed via `wiki/assets/ux/<slug>/` on both language pages. Detail: `~/.cursor/skills/xingai-wiki-ingest/references/ux-png.md`.
8. **Do not commit/push** unless asked.
9. **Never ingest this wiki into itself.**

## Epistemic standard (required on every wiki write)

Same bar as `xingai-wiki-ingest`. Each new/updated page (**EN and ZH**) must cover Known / Missing / Rethink / Debate / Needs evidence (ZH labels: 已知 / 缺失 / 需重新思考 / 争议 / 待证).

**Fail the page if:** shortened README; production claims without evidence; debate “won” without ADR/code; **EN shipped without `.zh.md`**; UX discussed with no embed when a public/user UX PNG exists.

Full text: `$WIKI/AGENTS.md`.

## Bilingual page pair (required)

```text
wiki/<area>/<slug>.md
wiki/<area>/<slug>.zh.md
```

- Headers: `Chinese: […]` / `English: […]`
- Same section order and epistemic blocks; full ZH localization (not a summary)
- Internal links use language-matched siblings
- UX embeds use the **same** `wiki/assets/ux/...` path on both pages
- Catalog: keep `index.md` + `index.zh.md` (and overview pair) in sync
- Exception: `wiki/log.md` English-only

## Workflow

```
Wiki build:
- [ ] 1. Locate wiki + read AGENTS.md
- [ ] 2. List public xingaiapp repos
- [ ] 3. Diff vs raw/
- [ ] 4. Choose ingest set (priority table)
- [ ] 5. Snapshot into raw/ (incl. needed UX PNGs)
- [ ] 6. Update wiki EN (Known/Missing/Rethink/Debate) + embed UX if needed
- [ ] 7. Write matching .zh.md for every touched content page (same embeds)
- [ ] 8. Lint (epistemic + bilingual + UX + private leaks)
- [ ] 9. Append log.md
- [ ] 10. Summarize; push only if asked
```

### 1. Locate wiki + schema

```bash
WIKI="${WIKI_ROOT:-/path/to/ai-projects-work-space/xingai-ai-learning-wiki}"
test -f "$WIKI/AGENTS.md" || { echo "AGENTS.md missing"; exit 1; }
```

### 2. List public repos

```bash
bash ~/.cursor/skills/xingai-ai-learning-wiki/scripts/list-public-repos.sh
```

Skip `xingai-ai-learning-wiki`.

### 3–4. Diff + priority

| Priority | Repo | Snapshot focus |
|---|---|---|
| P0 | `xingai-enterprise-ai-design` | courses, COURSE-STANDARD, cited articles/guides |
| P0 | `xingai-enterprise-ai-pocs` | POC README/architecture/PRODUCTION-READINESS, docs/adr, **demo UX screenshots if present** |
| P1 | `xingai-engineering-system` | Decision Ledger, loops, cache/worker, agent gates |
| P1 | `xingai-tech-blog` | architecture teaching posts |
| P2 | `xingai-dot-app` | learning-catalog only; marketing hero PNGs only if a wiki product page needs them |
| Skip | private, secrets, binaries (except needed UX PNG), node_modules |

Prefer snapshoting EN+ZH source peers when they exist under `raw/` (courses already bilingual).

### 5. Snapshot

Mirror under `raw/`. Prefer local public clones; else `gh`/temp clone.

**UX PNGs:** when a product/concept wiki page will discuss chrome/flow/theme, also copy selected screenshots into `wiki/assets/ux/<slug>/` (light/dark pairs when theme-dependent). Do not bulk-copy every image in the repo — only what the page needs. See `~/.cursor/skills/xingai-wiki-ingest/references/ux-png.md`.

### 6–7. Update wiki/ (EN then ZH same pass)

Follow `AGENTS.md` Ingest + Epistemic + bilingual + UX rules.

Page shapes (each as EN+ZH pair):

- **Course** — path role; POC instantiation; untested claims
- **Product/POC** — vs siblings; PRODUCTION-READINESS as Missing; **UX embed when UI is part of the story**
- **Concept** — definition; aliases; open Debate
- **Synthesis** — multi-source map changes

Reject: README mirrors; EN-only; abbreviated ZH; “see the mock” with no PNG.

### 8. Lint

Per `AGENTS.md`, plus:

- Private-product dumps; broken sibling links
- Guess + critique audits
- **Bilingual audit:** every touched content page has `.zh.md`; section parity; language headers
- **UX audit:** chrome/flow pages embed `wiki/assets/ux/...` on EN+ZH when assets exist; no third-party-authored marketing posters; no orphan UX files

### 9–10. Log + summary

Log ingest/lint (EN). Report pages changed **per language**, UX assets added, offer push.

## Modes

| Ask | Behavior |
|---|---|
| Full sync | P0–P1 (+ P2 if relevant), bilingual wiki updates + needed UX |
| One repo | Visibility → snapshot → EN+ZH wiki update (+ UX if needed) |
| Lint only | Steps 1 + 8–9 |
| Query | From wiki; durable answers → EN+ZH synthesis |

## Pairing with ad-hoc ingest

| Skill | Input |
|---|---|
| `xingai-ai-learning-wiki` | Public xingaiapp GitHub repos |
| `xingai-wiki-ingest` | URL / image / UX png / context / file |

Shared UX convention: `~/.cursor/skills/xingai-wiki-ingest/references/ux-png.md`.

## Additional resources

- `$WIKI/AGENTS.md`
- `$WIKI/raw/_llm-wiki-pattern.md`
- [examples.md](examples.md)
- Checklist: `~/.cursor/skills/xingai-wiki-ingest/references/epistemic-checklist.md`
- UX PNGs: `~/.cursor/skills/xingai-wiki-ingest/references/ux-png.md`
