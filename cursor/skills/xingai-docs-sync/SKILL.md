---
name: xingai-docs-sync
description: >-
  Syncs XingAI product docs to each repo's real conventions: bilingual ADRs,
  ADR index/graphs, README version notes, plan checkboxes, BDRs in
  business-plan, and CQRS/cross-repo link rules. Use when adding or updating
  ADRs, README version notes, docs indexes, InvestSim/Invest AI/Research AI
  docs, business-plan BDRs, docs sync, or /xingai-docs-sync. Complements
  xingai-docs-pack (blog/design/wiki pack); this skill owns per-repo ADR+README
  convention fidelity.
---

# XingAI Docs Sync — Per-Repo ADR / README Conventions

**Quick invoke:** `/xingai-docs-sync` or “sync ADRs and README to repo conventions.”

Write documentation the way **this** repo already does — not a generic ADR template. Companion to `xingai-docs-pack` (cross-surface pack). This skill owns **portfolio repo convention fidelity**.

## Hard rules (every XingAI repo in scope)

1. **Evidence first.** Re-read 2–3 of the newest real ADRs / README version notes in the target repo before writing. The conventions table goes stale; live files win.
2. **Bilingual by default.** `NNN-slug.md` (EN) always ships with `NNN-slug.zh.md` (中文) in the same pass. Do not defer translation.
3. **Extend, don't fork.** Before proposing a new repo, check whether an existing repo's scope already covers the work. New repos are a deliberate, flagged decision — never a quiet default.
4. **Pricing / strategy numbers live only in `business-plan`.** If concrete pricing or competitive strategy appears in a public product repo's docs, **flag it to the user** — do not silently move or shrink files (that changes public surface; needs confirmation).
5. **CQRS in product repos.** Worker/cron computes and writes; API only reads precomputed cache; nothing computes at request time. Any new ADR for a read API must say which side of that line it is on.
6. **Cross-repo links use GitHub URLs** (`https://github.com/xingaiapp/<repo>/blob/main/docs/adr/...`), not local relative paths across separate repos.
7. **Unverified schema / blocked tooling.** If `prisma generate`, network CDN, or similar blocks verification, say so in the ADR “Known limitation” and the README changelog — do not claim the feature “ships” when only `tsc` ran.
8. **Do not invent a docs convention.** If the repo has no `docs/adr/`, ADR index, or `AGENTS.md`/`CONTRIBUTING.md` docs convention, **ask before** introducing one.

## Workflow

```text
Docs sync:
- [ ] 0. Identify repo + read live conventions
- [ ] 1. Next ADR number + bilingual pair
- [ ] 2. Update ADR index (+ Mermaid graph if this repo has one)
- [ ] 3. Update plan checkboxes / Current Next Step (if plan docs exist)
- [ ] 4. README version notes (repo-specific format)
- [ ] 5. Flag business-sensitive content / new-repo / convention-intro decisions
- [ ] 6. Report paths + what was left for the user
```

### 0 — Identify repo + read live conventions

```bash
git rev-parse --show-toplevel
ls docs/adr 2>/dev/null | tail -20
head -80 docs/adr/README.md 2>/dev/null
rg -n "^## |^### " README.md | head -40
```

Then open [repo-conventions.md](repo-conventions.md) for the matching repo. If the repo is **not listed**, fall back to reading `docs/adr/README.md` and the 2–3 newest ADRs directly.

### 1 — ADR pair

- Match **numbering width** for that repo (3-digit vs 4-digit). Never cross-contaminate styles.
- Copy structure from the newest similar ADR in the same repo (Status, Context, Decision, Consequences, Known limitations, Related).
- Write EN + 中文 together.
- For read APIs: explicitly confirm CQRS side (cache read vs worker write).

### 2 — Index

- Update `docs/adr/README.md` table.
- If the index has a Mermaid dependency graph and/or “Not yet filed” / next-number note, update those too.

### 3 — Plan docs (when present)

Some repos keep executable plans (`PLAN.md`, `AUTO-TRADING-INTEGRATION-PLAN.md`, etc.). When an ADR implements a checklist item: tick boxes and refresh “Current Next Step” / “Recommended Next” so plan and ADR index do not drift.

### 4 — README version notes

Follow that repo’s version-note shape from [repo-conventions.md](repo-conventions.md). Only bump version + write a normal changelog when behavior is real and at least logically verified. Planned-but-unimplemented ADRs → mark “Planned, not yet shipped” (or equivalent) without a fake ship bump.

### 5 — Flag, don’t silently decide

Ask the user before:

- introducing ADR/BDR structure into a repo that never had it
- creating a new repo instead of extending an existing one
- moving pricing/strategy content out of a product README into `business-plan`

## vs `xingai-docs-pack`

| Need | Skill |
|------|--------|
| ADR + README + index fidelity in **one product repo** | **this skill** |
| Missing ADR **and** tech blog + enterprise design + wiki + push | `xingai-docs-pack` |

Often: run this skill’s conventions while writing the ADR step inside a docs-pack run.

## Anti-AI writing

Follow workspace `anti-ai-writing-style`. No hype; short; specific paths and version numbers.

## Output to the user

When done, report:

- ADR paths (EN + ZH)
- Index / plan / README files touched
- Version bump (or why none)
- Any flags awaiting user confirmation

## Reference

- Per-repo numbering, README shapes, BDR template: [repo-conventions.md](repo-conventions.md)
