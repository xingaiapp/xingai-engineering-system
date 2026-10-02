# XingAI portfolio: known documentation conventions per repo

Observed conventions — not guesses. **Re-read 2–3 of the newest real files before writing**; this table drifts. For next ADR numbers, always use the live `docs/adr/README.md` (and any “Not yet filed” section), never the examples below as authoritative counts.

If a repo is not listed here, fall back to the workflow in `SKILL.md`: find `docs/adr/README.md` (or equivalent) and read recent entries directly.

## Cross-cutting (same as SKILL hard rules)

- Bilingual ADR pairs EN + `.zh.md`
- Extend existing repos; new repos are rare and flagged
- Pricing / competitive strategy detail → `business-plan` only; flag product-repo leaks
- CQRS: worker writes decisions/cache; API reads only
- Cross-repo links: `https://github.com/xingaiapp/<repo>/blob/main/...`

---

## `xingai-invest-ai`

- ADRs: `docs/adr/NNN-slug.md` — **3-digit** (`001`, `002`, …)
- Index: `docs/adr/README.md` — table columns `# | Title | 中文 | Status | Layer`, plus Mermaid `flowchart TD` dependency graph and (further down) a roadmap `timeline`. Update **table + flowchart** when an ADR depends on / is depended on by others.
- “Not yet filed” (or equivalent) at bottom of index — update next free number.
- Root `README.md`: `## Version Notes`, entries as `### 0.1.NN` (patch-bump per shipped doc+feature). **Newest first.**
- Layers seen: Product, AI, Data, Infra, Risk, Platform, Worker, API, Frontend/Auth, DevOps, Repo/Process, Product/Legal, Product/Cost, Product/Notifications, Product/Reporting — pick what fits; cross-cutting ok (e.g. `Worker / API / Data`).

## `invest-performance-sim`

- ADRs: `docs/adr/NNNN-slug.md` — **4-digit** (`0001`, `0002`, …). Different from Invest AI — **do not** use 3-digit here.
- Index: `docs/adr/README.md` — simpler table `ADR | Title (EN) | 中文`; confirm whether a dependency graph exists before assuming none.
- Also maintains plan docs beyond ADRs: `docs/PLAN.md` (phase checklists `- [x]` / `- [ ]`) and integration plans such as `docs/AUTO-TRADING-INTEGRATION-PLAN.md` (phased executable plan + acceptance criteria). When an ADR implements part of a plan: tick checkboxes and update “Current Next Step” / “Recommended Next”.
- Root `README.md`: version header up top, then `### Current version notes (x.y.z)` plus a stack of `### Previous version notes (x.y.z)` descending. On release: retitle previous Current → Previous, insert new Current, bump semver in header (patch default; minor for meaningful features).
- Unverifiable schema/DB changes: state in ADR “Known limitation” **and** README changelog — do not claim “ships” if verification was blocked.

## `xingai-research-ai`

- ADRs: `docs/adr/NNN-slug.md` — 3-digit.
- Index: `docs/adr/README.md` — `# | Title | 中文 | Status | Layer` + Mermaid graph (`A001 --> A002` style). Update both.
- Root `README.md`: `## Current version notes`, newest first; entries start with `` `0.1.N` `` + short description.
- ADR proposes code not yet implemented → README mark “Planned, not yet shipped” (or similar); **do not** bump version until behavior is real and at least logically verified.

## `claims-mcp-server`

- ADRs: `docs/adr/NNN-slug.md` — 3-digit. `docs/adr/` may be missing on first look — check before assuming.
- Index: `docs/adr/README.md` — `ADR | Title (EN) | 中文`.
- Root `README.md`: tools table + version line; bump with `package.json` `"version"` together. Prose summaries (“N tools across M domains”) need updating when tools ship — easy to miss.

## `xingai-robinhood-mcp` (and similar MCP gateways)

- Prefer `docs/adr/NNN-slug.md` **3-digit** if the repo already uses that pattern; confirm from live index.
- README version notes + ADR index together when shipping gateway/evidence/gate behavior.
- Never document live trading as default; paper / draft / human-gate language must stay accurate.

## `xingai-skill-registry`

- ADRs: `docs/adr/NNN-slug.md` — 3-digit.
- Prisma-dependent: if `prisma generate` / `db push` cannot run (blocked engine CDN is a recurring sandbox issue), say so explicitly — do not claim schema verified when only `tsc --noEmit` ran.

## `business-plan` (private — not a product repo)

- Not ADRs — **Business Decision Records**: `business-plan/decisions/BDR-NNN-slug.md`.
- Index: `business-plan/decisions/README.md` — convention + table; statuses `Proposed → Accepted → Superseded` (not ADR Accepted/Deprecated).
- Template: Status/Date/Owner → Context → Honest assessment → Decision → Consequences → Alternatives considered → Action items (checkboxes; human-only actions stay unchecked and called out) → Related.
- **Only place** in the portfolio where full pricing / competitive-strategy numbers are allowed in detail.

## Wiki / knowledge-base style repos

- Course pages, product pages, synthesis pages, `index.md` + `log.md` ingest tracking — **not** the ADR pattern.
- Read that repo’s `AGENTS.md` first (bilingual layout, folder rules). Prefer skills `xingai-ai-learning-wiki` / `xingai-wiki-ingest` for ingest loops.

## Repo not in scope yet?

Look for `docs/adr/`, `docs/adr/README.md`, or root `AGENTS.md` / `CONTRIBUTING.md` mentioning docs conventions. If none exist, this repo has not opted in — treat introducing the pattern as a **user decision**, not a unilateral setup.
