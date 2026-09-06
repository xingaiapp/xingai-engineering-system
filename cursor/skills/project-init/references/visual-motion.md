# Visual presence — images, icons, motion

Project-init **forces** these on every public XingAI UI. Text chrome alone fails the skill.

## Images (required)

| Asset | Purpose | Notes |
|-------|---------|--------|
| Hero light | In-app primary route | Product-specific illustration or mock |
| Hero dark | In-app primary route | Separate file; theme swap |
| OG / Twitter | Social metadata | Not a substitute for in-app hero |
| dot-app `src` + `srcDark` | Marketing card | When registered on xingai.app |

**Fails:** CSS-only gradients, favicon-as-hero, one PNG stretched for both themes, “add images later.”

See [hero-visuals.md](hero-visuals.md).

## Icons (required)

- Logo mark + favicon / `icon.svg` / apple-touch (as framework allows).
- Primary nav destinations and key actions: SVG or the repo’s icon set.
- Match oklch product tokens; keep marks simple and on-brand.

**Fails:** emoji as primary icons; default Next favicon only; text-only brand with no mark.

## Motion (required)

Ship **≥2–3 intentional** motions on the primary route in the same init pass:

1. **Entrance** — hero or main decision surface (short fade/slide, ~200–400ms).
2. **Interaction** — primary CTA hover/press or tab active state.
3. **Presence** — one more: drawer/sheet transition, list stagger, or theme toggle polish.

Rules:

- Prefer CSS (`transition`, `@keyframes`, Tailwind `animate-*` if already in repo).
- Do **not** add Framer Motion / GSAP unless the repo already uses them or the user asks.
- Wrap non-essential motion in `@media (prefers-reduced-motion: reduce)` (disable or snap).
- Motion supports hierarchy — not noise, not infinite logo spin.

## Agent order of work

1. Create icon + hero light/dark + OG files under `public/` (or `public/brand/`).
2. Wire them into layout / hero / metadata.
3. Add the 2–3 motions with reduced-motion guards.
4. Only then mark project-init visual baseline complete.

## Verification

- [ ] Light and dark heroes both visible on primary route
- [ ] Logo/favicon present in tab and chrome
- [ ] Nav icons are SVG (or repo set), not emoji
- [ ] Primary CTA / button labels are vertically centered in the control
- [ ] ≥2 motions observable without being distracting
- [ ] `prefers-reduced-motion` softens or disables non-essential motion
- [ ] OG + (if registered) dot-app light/dark screenshots exist
