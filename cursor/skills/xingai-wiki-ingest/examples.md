# Examples — xingai-wiki-ingest

## URL with critique

User: ingest an MCP auth article

**Pass:** Known cites the article; Missing/Debate as required; **both** `….md` and `….zh.md` written same pass with mutual language headers.

**Fail:** three-paragraph EN summary only; or EN page with “TODO: translate.”

## UX PNG (product screenshot)

User: attaches Cook / Meal / claims POC mobile screenshot (or light+dark pair)

**Pass:** files under `raw/external/.../assets/ux/` and `wiki/assets/ux/<slug>/`; EN+ZH product/concept page embeds the same path; Known says what the shot shows; Missing notes what chrome/flow is not proven.

**Fail:** notes-only description with no wiki embed; EN embeds and ZH omits; third-party “Layers of AI” poster treated as UX.

## Third-party marketing poster

User: attaches infographic credited to a non-XingAI author

**Pass:** refuse wiki synthesis page (or snapshot-only archive if user insists); explain ownership gate.

**Fail:** new `wiki/syntheses/*-vs-xingai.md` for that poster.

## Image with critique (unattributed, useful)

User: attaches uncredited architecture crop that maps to courses/POCs

**Pass:** EN+ZH synthesis with Known/Missing/Rethink/Debate/Needs evidence; `verified: partial`; no fake author claim.

**Fail:** restating labels only; ZH omitted.

## Paste

User context filed as synthesis pair EN+ZH; Needs evidence if ADR not re-read.
