# GenerateImage prompt templates (XingAI UX PNG)

Prompt from the **post-fix** XingAI understanding map only.  
Never “redraw / restyle / clean up” the source.  
Never pass the source via `reference_image_paths`.

Include corrected claims on the diagram; do **not** illustrate unrepaired source errors.

## Architecture map (16:9) — default

```text
ORIGINAL XingAI educational architecture diagram (NOT a copy or restyle of any third-party poster).
Landscape 16:9. Title: "<TITLE> (XingAI map)".
Soft off-white + cool oklch green. No purple. No cream/terracotta. No influencer credit. No vendor logo walls.

Structurally different from viral posters: vertical numbered spine OR labeled bands —
never a winding rainbow snake or the source’s card zigzag.

This diagram shows CORRECTED XingAI teaching (errors in the source were fixed before drawing):
  Band A "<NAME>": …   (corrected claims only)
  Band B "<NAME>" (optional green "walls"): …
  Band C "<NAME>": …

Each step: short corrected name + one-line purpose.
Footer: "<DETERMINISM / COURSES LINE>" and "not a tool shopping list".

Style: flat vector, thumbnail-readable, no emoji, no glow, no multi-layer shadows.
Explicit: do not recreate or resemble any attached marketing infographic.
Do not depict the source’s wrong framings as if they were correct.
```

## Mobile chrome (9:16)

```text
ORIGINAL XingAI product mobile UI mock, portrait 9:16.
Product: "<PRODUCT>". Top: menu · brand · language + theme.
Main: <ONE PRIMARY DECISION SURFACE — corrected per product rules>.
Bottom tab bar. Safe-area. oklch green. No fake OS status bar.
```

## Decision card (4:3 or 16:9)

```text
ORIGINAL XingAI decision-card UI with product-correct confidence wording,
evidence bullets, "not advice" footer. Title: "<PRODUCT> decision surface (XingAI)".
```

## Style bans (always append)

- Do not copy source layout, path, card grid, or color sequence  
- Do not keep wrong source steps “for familiarity”  
- No purple-indigo; no cream+terracotta; no emoji; no “Follow @…”  
- No “redraw this image”

## After generate

1. Vision-read the PNG.  
2. Fail if copy-like **or** if it still teaches an unrepaired source error.  
3. Save `wiki/assets/ux/<slug>/xingai-map.png`.
