# Source types — detail

## URL

- Prefer canonical article/docs URLs over homepage hubs.
- GitHub: only **public** files/blobs. Use raw or permalink (`/blob/<sha>/`).
- Video pages: store title, channel, URL, and a short outline; do not claim transcript accuracy without one.
- Paywall / login: stop and ask for a paste.

## Image (generic)

- Screenshots of whiteboards, sequence diagrams, slide crops, UI flows.
- Always produce `notes.md` with: title guess, components, data/control arrows, readable text, unknowns.
- Copy into `assets/` only if the file is small and the diagram is the durable artifact; otherwise description is enough.
- Never invent code paths from icons alone.
- **Third-party-authored marketing posters** (clear non-XingAI credit on-image) → do **not** create wiki synthesis pages; refuse or snapshot-only if the user insists on archival, and say so in the log.

## UX PNG (product / mock UI)

When the image is XingAI product UI, chrome, flow, theme pair, or POC demo:

1. Treat as first-class wiki media — see [ux-png.md](ux-png.md).
2. Save under `raw/external/.../assets/ux/` **and** copy to `wiki/assets/ux/<slug>/`.
3. Embed in **both** EN and ZH wiki pages with the same relative path.
4. Prefer light+dark pairs when the shot is theme-dependent.
5. Caption what the shot **proves** (Known) and what it does **not** (Missing).

Do not leave product/chrome pages text-only when a UX PNG was attached or exists in the public source tree.

## Context

- User paste is first-class evidence of *intent*, weaker evidence of *facts*.
- Split user text vs agent interpretation in the raw package.
- If context contradicts wiki pages, prefer filing a synthesis that names the tension over silently overwriting.

## File

- Local markdown/text: copy.
- PDF: extract text if tools allow; else ask for the relevant excerpt.
- UX/diagram PNG/WebP: follow Image / UX PNG above.
- Skip binaries that aren't diagrams or needed UX (zips, node_modules, databases).

## Mixed packages

One slug, multiple files, single `SOURCE.md` with `types: mixed` and a bullet list of parts. Wiki update should treat them as one ingest event in `log.md`. If any part is UX PNG, run the UX path for those files.
