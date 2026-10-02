---
name: xingai-wiki-ingest
description: >-
  Ingests URL, image, pasted context, or local files into the XingAI AI-Learning
  Wiki as a critical bilingual (EN+中文) knowledge base: known/missing/rethink/
  debate, never guess. Includes UX PNGs in the wiki when visuals are needed.
  Use when attaching links, screenshots, or notes for the wiki, or
  /xingai-wiki-ingest. Companion to xingai-ai-learning-wiki.
---

# XingAI Wiki Ingest (URL / Image / Context)

Companion to **`xingai-ai-learning-wiki`** (public GitHub repo sync).

Ad-hoc sources → `raw/external/` → `wiki/` per `AGENTS.md`. Goal: a **knowledge
base**, not a scrapbook. Every wiki update must separate **known / missing /
rethink / debate**, ship **English + 中文** together, and refuse to invent facts.
When a page needs a **UX visual**, ship the PNG with the wiki page (not
text-only “see the mock”).

**Wiki path (default):**  
`/path/to/ai-projects-work-space/xingai-ai-learning-wiki`

## When to apply

- Ingest URL / image / paste / file into the wiki
- Product or UX **PNG/screenshot** that should appear on a wiki page
- `/xingai-wiki-ingest`
- Mixed sources in one turn

**Not for:** bulk public-repo sync → `xingai-ai-learning-wiki`.  
**Not for:** private ADRs, secrets, or unpublished product internals.  
**Not for:** third-party-authored marketing posters with a clear non-XingAI credit.

## Hard rules

1. **Public / user-owned only** — no private-repo dumps.
2. **Read `$WIKI/AGENTS.md` first** — Epistemic standard + synthesis bar + bilingual rule + UX PNG rule.
3. **Snapshot then critique** — raw holds the artifact; wiki argues with it.
4. **No guessing as fact** — if evidence is thin, write `unknown` / `needs evidence`.
5. **Bilingual required** — every new/updated wiki content page is `name.md` **and** `name.zh.md` in the **same** pass. Do not finish with EN-only.
6. **UX PNG when needed** — if the page is about chrome/flow/theme/demo UI (or the user attached a UX shot), copy into `wiki/assets/ux/<slug>/` and embed in **both** EN and ZH. See [references/ux-png.md](references/ux-png.md).
7. **Absolute links** in wiki pages (`https://...`); internal wiki links use the matching language sibling.
8. **Do not commit/push** unless asked.
9. **Label uncertainty** in `SOURCE.md` (`verified: yes | partial | no`).

## Epistemic standard (required on every wiki write)

Do **not** stop at “what it is.” Each touched wiki page (EN and ZH) must include:

| Section | Purpose |
|---|---|
| **Known** / **已知** | Claims grounded in source and/or verified wiki/raw. Cite `raw/...` or URL. |
| **Missing** / **缺失** | What the source omits that matters for XingAI learning. |
| **Rethink** / **需重新思考** | Oversimplifications vs courses/POCs. |
| **Debate** / **争议** | Open design forks — not resolved by vibes. |
| **Needs evidence** / **待证** | Open questions; no speculation. |

**Forbidden:** paraphrasing as the whole page; guessing; EN-only ship; abbreviated ZH that drops sections; UX discussion with no linked PNG when one is available.

Shared detail: `$WIKI/AGENTS.md` → Epistemic standard + bilingual convention + UX PNG.

## Bilingual page pair (required)

```text
wiki/<area>/<slug>.md       # English
wiki/<area>/<slug>.zh.md    # 中文 — same structure, full localization
```

- EN header: `Chinese: [slug.zh.md](slug.zh.md)`
- ZH header: `English: [slug.md](slug.md)`
- Same heading order and epistemic blocks; localize prose, keep code/`raw/` paths.
- Internal links: EN→`foo.md`, ZH→`foo.zh.md`.
- Embedded UX images: **same** `wiki/assets/ux/...` path on both pages (localize alt text only).
- If `index` / `overview` change → update **both** language files.
- `wiki/log.md` stays English-only (ops).

## Input types

| Type | Action |
|---|---|
| **url** | Fetch; save excerpt + canonical URL |
| **image** | Read image; `notes.md` + `assets/`; if UX → also `wiki/assets/ux/` + embed |
| **ux png** | Product/mock screenshot — required path in [references/ux-png.md](references/ux-png.md) |
| **context** | Save user wording; User vs Agent interpretation |
| **file** | Copy/excerpt; record path |
| **mixed** | One package; one critical bilingual pass |

## Workflow

```
Wiki ingest (ad-hoc):
- [ ] 1. Locate wiki + read AGENTS.md
- [ ] 2. Classify inputs (incl. UX PNG vs third-party poster)
- [ ] 3. Gate: public / user-consented? drop non-XingAI-authored marketing posters
- [ ] 4. raw/external/YYYY-MM-DD-<slug>/ + SOURCE.md
- [ ] 5. Fetch / describe / copy (UX → assets/ux under raw package)
- [ ] 6. Map to wiki target
- [ ] 7. If UX needed: copy to wiki/assets/ux/<slug>/ 
- [ ] 8. Write EN page (Known/Missing/Rethink/Debate/Needs evidence) + embed PNG
- [ ] 9. Write matching .zh.md in the same pass (same embeds)
- [ ] 10. Update index.md + index.zh.md if needed; append log.md
- [ ] 11. Bilingual + epistemic + UX lint; summarize; offer push
```

### Raw package

```text
raw/external/YYYY-MM-DD-<slug>/
  SOURCE.md
  content.md      # optional
  notes.md
  assets/         # diagrams / UX pngs
  assets/ux/      # prefer for product UI screenshots
```

`SOURCE.md` stays English (manifest). Wiki pages are bilingual.

### Map to wiki targets

Prefer updating existing concept/product/course (**both** language files). New synthesis when the source changes the map. Avoid one vanity page per URL/image.

UX PNGs usually attach to **product** or **concept** pages (chrome, decision card), not a new synthesis per screenshot.

### Lint additions

- Page only restates the source → fail.
- Confident claim with no citation → demote or delete.
- Image-only code claims without `verified: partial|no` → fail.
- **Missing `.zh.md` for a new/updated content page → fail; write it before done.**
- ZH missing an epistemic section that EN has → fail.
- **UX page without embedded PNG when asset exists / was attached → fail.**
- **Third-party-authored marketing poster as wiki page → fail; do not ingest.**

## Modes

| Ask | Behavior |
|---|---|
| Single / mixed ingest | Full bilingual workflow (+ UX assets if needed) |
| Snapshot only | Steps 1–5 + log |
| Query | Answer from wiki; file-back as EN+ZH synthesis if durable |

## Pairing

| Skill | Input |
|---|---|
| `xingai-ai-learning-wiki` | Public xingaiapp repos (incl. UX PNGs when product pages need them) |
| `xingai-wiki-ingest` | URL / image / UX png / context / file |
| `xingai-ux-png` | “draw UX png” / redraw third-party posters as XingAI maps (`GenerateImage` + `wiki/assets/ux/`) |

## Additional resources

- `$WIKI/AGENTS.md`
- [examples.md](examples.md)
- [references/source-types.md](references/source-types.md)
- [references/epistemic-checklist.md](references/epistemic-checklist.md)
- [references/ux-png.md](references/ux-png.md)
