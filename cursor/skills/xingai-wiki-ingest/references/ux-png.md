# UX PNG as part of the wiki

When a wiki page needs a **visual** to be understood (product chrome, flow,
decision card, light/dark theme, POC demo UI), include the PNG in the wiki —
do not leave “see the mock” as text-only.

## When UX PNG is required

Include a UX PNG **if any** of these are true:

- The page argues about **UI / chrome / navigation / layout** (mobile top bar,
  drawer, bottom nav, decision surface).
- Light vs dark (or locale) changes what the user sees — prefer a **pair**.
- A POC/product claim is easier to verify from a screenshot than from prose.
- The user attaches a product/UX screenshot and asks for ingest.
- Public-repo sync finds durable UX under `docs/ux*`, `public/`, `assets/`,
  or README-linked screenshots that the product/concept page should show.

Skip bulk dumps of every image in a repo. **Need** beats completeness.

## Ownership gate (required)

| Keep / ingest | Drop |
|---|---|
| XingAI-owned (public repo assets, product screenshots, user-owned UX) | Third-party-authored marketing posters with a clear non-XingAI credit (e.g. named influencer / “Follow X”) |
| Unattributed diagrams only when they ground a **critique** against XingAI courses/POCs | Random stock / viral stacks with no wiki job |

If an image has a **non-XingAI author credit**, do not create a wiki synthesis
page for it (align with public-wiki scrub policy). UX PNGs for XingAI products
are in-scope.

## Where files live

```text
# Snapshot (source of truth under raw/)
raw/<mirror>/.../                 # when copied from a public repo path
raw/external/YYYY-MM-DD-<slug>/assets/ux/<name>.png

# Wiki-facing copies (when the page embeds the image)
wiki/assets/ux/<slug>/<name>.png
# theme pairs:
wiki/assets/ux/<slug>/<name>.light.png
wiki/assets/ux/<slug>/<name>.dark.png
```

Prefer copying the durable UX into `wiki/assets/ux/` so GitHub-rendered wiki
pages keep working if `raw/` paths are remirrored. Still cite the `raw/` origin
in `## Sources` / `SOURCE.md`.

## How to embed (EN + ZH)

Both language pages use the **same** relative image path and alt text that
describes the UI (alt may be localized):

```markdown
![Cook mobile home — light](../assets/ux/cook-home/home.light.png)
```

- Do not replace the epistemic sections with a gallery.
- Caption in prose: what the shot proves (Known) vs what it does not (Missing).
- For theme pairs, show both or state which theme is shown and note the peer file.

## Lint

- Product/concept page discusses chrome/flow but has **no** linked UX PNG when
  one exists in `raw/` or was attached → fail; add asset + embed.
- Third-party-authored marketing PNG filed as wiki “truth” → fail; delete.
- Orphan `wiki/assets/ux/` files with no linking wiki page → remove or link.
- EN embeds an image and ZH omits it → fail; same assets on both pages.
