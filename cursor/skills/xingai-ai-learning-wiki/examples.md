# Examples — XingAI AI-Learning Wiki skill

## Full public sync (epistemic + bilingual)

After snapshotting P0 POCs, product pages must include Missing from PRODUCTION-READINESS and Debate where ADRs disagree — as **`foo.md` + `foo.zh.md`** in one pass.

## Single-repo ingest

**Pass:** EN+ZH pages with epistemic sections and language headers.  
**Fail:** Feature list from README; EN-only.

## UX PNG on a product page

Public POC (or marketing site) has a demo screenshot needed to explain chrome/flow.

**Pass:** selected PNG(s) under `wiki/assets/ux/<slug>/` (light/dark if theme-dependent); embedded on EN+ZH product pages; Sources cite `raw/` origin.

**Fail:** prose-only “mobile bottom nav”; dumping every PNG from the repo; ingesting a third-party-authored marketing poster as wiki content.

## Lint-only

Guess + critique + **bilingual** + **UX** audits (orphan `.md` without `.zh.md`; chrome page missing embed).

## Query → synthesis

Durable answers → file `syntheses/….md` **and** `….zh.md`.
