# Epistemic checklist (before finishing a wiki page)

Use after every ingest (repo or ad-hoc). If any **Fail** trips, rewrite before log/commit.

## Pass

- [ ] **Known** claims each cite `raw/...` or a public URL (or “verified by running X”).
- [ ] **Missing** names at least one material gap (or explicitly “no material gap found in sources Y”).
- [ ] **Rethink** or **Debate** appears when siblings/courses disagree — not forced empty theater.
- [ ] **Needs evidence** lists open questions instead of guessed answers.
- [ ] Image/OCR/paywall material marked `verified: partial|no` in SOURCE.md and not treated as code truth.
- [ ] Page would still be useful if the reader already read the raw README once.
- [ ] **Bilingual:** matching `name.zh.md` exists; same section order / epistemic blocks; mutual `Chinese:` / `English:` headers; internal links language-matched.
- [ ] ZH is a full localization — not a shortened summary of EN.
- [ ] **UX PNG when needed:** chrome/flow/theme/demo pages embed `wiki/assets/ux/...` on both EN and ZH (or explicitly note “no UX asset available”).

## Fail

- [ ] Page is a shortened README / article paraphrase / file list.
- [ ] “Probably”, “likely”, “must be” used to close a factual gap.
- [ ] Production / security / correctness claimed without PRODUCTION-READINESS, tests, or cited code.
- [ ] Debate resolved without ADR or verified implementation.
- [ ] Private-repo internals introduced.
- [ ] Citations to files not in `raw/` and not fetched this session.
- [ ] **EN content page without `.zh.md` (or ZH missing sections EN has).**
- [ ] UX discussed / screenshot attached but wiki page has no embedded PNG.
- [ ] Third-party-authored marketing poster kept as a wiki synthesis page.

## Phrasing that helps

- “Per `raw/pocs/.../PRODUCTION-READINESS.md`, auth is deferred.”
- “Course 04 requires X; this POC only shows Y — Missing.”
- “ADR-006 vs ADR-007 leave auth-first vs coverage-first as Debate.”
- “Needs evidence: whether Phase 4 OAuth was implemented (not in snapshot).”
- “UX (light): `wiki/assets/ux/claims-workflow/home.light.png` — bottom nav + decision card.”

## Phrasing that hurts

- “This ensures enterprise-ready security.”
- “Obviously agents need…”
- “The diagram proves the system does…”
- “See the Figma / mock” with no PNG in the wiki.
