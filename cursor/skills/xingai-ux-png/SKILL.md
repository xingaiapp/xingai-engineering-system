---
name: xingai-ux-png
description: >-
  Evaluates source posters/diagrams against XingAI courses, fixes wrong claims,
  adds corrections, then draws an original UX PNG (never a copy). Files under
  wiki/assets/ux; optional bilingual critique. Use when the user says draw UX
  png, /xingai-ux-png, or attaches an infographic that needs a corrected XingAI
  map. Companion to xingai-wiki-ingest.
version: 1.2.0
---

# XingAI UX PNG

**Quick invoke:** `/xingai-ux-png` or “draw UX png”.

Personal: `~/.cursor/skills/xingai-ux-png/`  
Workspace mirror: `.cursor/skills/xingai-ux-png/`

**Wiki default:**  
`/path/to/ai-projects-work-space/xingai-ai-learning-wiki`

Companion: **`xingai-wiki-ingest`** · **`xingai-web-design`**.

## Core principle (non-negotiable)

**Evaluate → Fix → Correct → Draw.** Never copy the original.

Order is mandatory:

1. **Evaluate** the source against XingAI courses / ADRs / POCs / foundation rules  
2. **Fix** wrong, misleading, or unsafe claims (do not leave them in the diagram)  
3. **Add** XingAI corrections that the source omitted  
4. **Draw** a new PNG from that corrected understanding only  

The source is **stimulus + critique target**, not a layout template.

| Allowed | Forbidden |
|---|---|
| Critique then redraw from corrected XingAI model | Restyle / clone / near-copy source layout or step order |
| Show corrected bands, walls, stop conditions | Keep false exclusivity, tool shopping lists, “deploy = security done” |
| Cite source under `raw/` as reference | `reference_image_paths` on third-party posters |
| XingAI product screenshots | Embed third-party credited poster on wiki pages |

If the wiki PNG still teaches the source’s mistakes, **fail and regenerate**.

## When to apply

- Draw / generate a UX PNG or architecture map  
- Attached infographic / poster needs a **corrected** XingAI visual  
- `/xingai-ux-png`

**Not for:** “make the poster prettier.”  
**Not for:** bulk repo sync → `xingai-ai-learning-wiki`.  
**Not for:** paste/URL ingest without a draw ask → `xingai-wiki-ingest`.

## Hard rules

1. **Evaluate first** — list what is right, wrong, missing, and dangerous vs XingAI. No draw until this exists.  
2. **Fix wrong parts before drawing** — wrong claims must not appear as “correct” steps on the PNG.  
3. **Add corrections in need** — MCP two-wall, untrusted observations, durable workflow, evidence stop, Course links, etc.  
4. **Never copy original art** — different layout/framing; no third-party `reference_image_paths`.  
5. **Original art only on wiki** — GenerateImage or XingAI screenshots; posters → `raw/.../*-reference.png` only.  
6. **No orphan assets** — EN + ZH both link the PNG (or delete).  
7. **Bilingual if wiki write** — Known / Missing / Rethink / Debate / Needs evidence.  
8. **Do not commit/push** unless asked.  
9. **Anti-slop** — oklch green / neutrals; no purple-indigo; no cream+terracotta; no emoji; no glow; no zigzag viral snake.  

## Modes

| Ask | Behavior |
|---|---|
| **draw only** | Evaluate → fix → correct → draw → path; warn if orphan |
| **draw + wiki** (default when poster attached) | Same + raw + EN/ZH critique (errors + corrections explicit) + index + log |
| **product chrome** | Real XingAI screenshots; not GenerateImage clones of marketing art |

## Workflow

```
XingAI UX PNG:
- [ ] 1. Classify input (XingAI shot | third-party poster | concept)
- [ ] 2. Ownership gate — third-party → raw reference ONLY
- [ ] 3. EVALUATE source vs XingAI (right / wrong / missing / dangerous)
- [ ] 4. FIX wrong parts — rewritten corrected claims
- [ ] 5. ADD corrections XingAI requires
- [ ] 6. Write understanding map (keep / fix / drop / add / regroup)
- [ ] 7. Choose slug + one-glance claim for the CORRECTED diagram
- [ ] 8. GenerateImage from corrected map ONLY (no source as reference_image)
- [ ] 9. Vision lint — not a copy; does not teach source mistakes
- [ ] 10. Save wiki/assets/ux/<slug>/xingai-map.png
- [ ] 11. Wiki mode: SOURCE.md + notes.md (evaluation + fixes + corrections)
- [ ] 12. Wiki mode: EN+ZH; epistemic sections; index + log
- [ ] 13. Lint + offer push
```

### Steps 3–6 — Evaluation & correction (required template)

Write in `notes.md` (wiki mode) or in the turn (draw only) **before** drawing:

```markdown
## Source evaluation (vs XingAI)
- Source claim (1 line): …
- Right (keep): …
- Wrong (must fix): …
  - Error: … → Correction: …
  - Error: … → Correction: …
- Missing (add if needed): …
- Dangerous if followed as-is: …

## XingAI understanding map (post-fix)
- Keep (only after eval): …
- Fixed claims (appear on PNG): …
- Drop: … (logos, zigzag, author credit, uncorrected false steps, …)
- Add (corrections): …
- Regroup: …
- One-glance claim for NEW PNG: …
```

**Rule:** If a source step is wrong, the PNG shows the **correction**, not the original wording with a green skin.

### Paths

```text
wiki/assets/ux/<slug>/xingai-map.png
raw/external/YYYY-MM-DD-<slug>/
  SOURCE.md
  notes.md              # evaluation + fixes + understanding map
  assets/ux/<author>-reference.png
```

### SOURCE.md minimum

```markdown
- type: mixed | image
- ownership gate: third-party reference-only | XingAI-owned
- copy_policy: not a copy — evaluate → fix → correct → draw (see notes.md)
- verified: partial | yes | no
- wiki_target: wiki/syntheses/...
- note: wiki embeds wiki/assets/ux/... only
```

### Wiki critique page

EN+ZH must make evaluation visible:

- **Known** — what source got right (cited)  
- **Missing** — omitted XingAI controls  
- **Rethink** — wrong framing that was fixed for the PNG  
- **Debate** / **Needs evidence** as usual  
- Embed **only** the corrected XingAI PNG  

## GenerateImage brief

Prompt from the **post-fix understanding map** only — never “redraw this poster.”

Required:

1. Title “(XingAI map)” or product name  
2. Layout different from source  
3. **Corrected** groups / walls / stop conditions  
4. Footer: determinism / courses / “not a tool shopping list” when relevant  
5. Style bans + do not resemble source  
6. Aspect: `16:9` maps · `9:16` mobile  

Templates: [references/prompt-template.md](references/prompt-template.md).

## Vision fail conditions (regenerate)

- Looks like a copy/restyle of the source  
- Still shows uncorrected wrong claims from the source  
- Same step order with only cosmetic changes  
- Author credit / “Follow @…” / vendor sticker row from source  

## Pairing

| Situation | Skill |
|---|---|
| Paste/URL → critique wiki | `xingai-wiki-ingest` |
| Evaluate + fix + draw UX | **this skill** |
| Both | Eval/fix/draw here; ingest for extra sources if needed |

## Lint checklist

- [ ] Source evaluation written (right / wrong / missing / dangerous)  
- [ ] Wrong parts have explicit Error → Correction  
- [ ] Corrections added before GenerateImage  
- [ ] No third-party `reference_image_paths`  
- [ ] Vision: not a copy; does not teach source mistakes  
- [ ] Wiki embeds XingAI PNG only; EN + ZH; no orphan  
- [ ] No commit unless asked  

## Examples

See [examples.md](examples.md).

## Additional resources

- [references/prompt-template.md](references/prompt-template.md)
- `xingai-wiki-ingest` → `references/ux-png.md`
- `$WIKI/wiki/assets/ux/README.md`
- `$WIKI/AGENTS.md`
