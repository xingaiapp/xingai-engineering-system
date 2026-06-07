---
name: xingai-web-design
description: >-
  Builds and refines XingAI web UIs for *.xingai.app products. Applies
  decision-system UX, version inheritance, mobile chrome, oklch tokens,
  light/dark theme, i18n, and anti-AI-slop rules.
---

# XingAI Web Design

Use this skill for front-end work on XingAI product apps, marketing pages, and public UI surfaces.

## When To Apply

- New screens, components, CSS, or theme work in `xingai-*` repos
- Mobile header, side menu, bottom nav, light/dark theme
- Product UI polish
- User asks for XingAI style, decision UI, or V1-aligned upgrade

Not for backend APIs, workers, Vercel-only config, or non-visual scripts.

## Non-Negotiable Product Rules

1. Upgrade, do not replace. Later versions inherit prior UX, product identity, and main flow.
2. Do not expose internal labels like V1/V2/V3 in user-facing UI.
3. Decision systems, not generic chatbots. One primary outcome per screen.
4. Finance/invest surfaces need risk-first copy and no guaranteed returns.

## Workflow

1. Read existing `globals.css`, layout files, sibling components, and README.
2. Identify the current design system: tokens, spacing, radius, typography, icons, and motion.
3. Declare the design direction before large diffs.
4. Build mobile first at ~375px.
5. Add desktop refinements after the mobile base works.
6. Verify light/dark theme, EN/zh/ko strings, safe areas, and touch targets.

## Default Design Tokens

Use repo tokens first. If the repo has no tokens yet, start with a calm green decision-system palette.

| Role | Light | Dark |
|---|---|---|
| Background | `oklch(0.985 0.004 145)` | `oklch(0.14 0.01 145)` |
| Foreground | `oklch(0.22 0.02 150)` | `oklch(0.98 0 0)` |
| Primary | `oklch(0.52 0.19 145)` | `oklch(0.62 0.18 145)` |
| Card | `oklch(1 0 0)` | `oklch(0.19 0.02 145)` |
| Border | `oklch(0.9 0.02 145)` | `oklch(0.3 0.03 145)` |

## Mobile Chrome

- Top bar: menu, product title, language, theme, profile/login where applicable.
- Drawer: full nav, settings fallback, legal/help links.
- Bottom nav: primary destinations only, mobile only.
- Content bottom padding must clear the bottom nav and safe area.
- Never hide language/theme on mobile unless repeated in the drawer.

## Anti-Patterns

- Inter + blue default SaaS styling without product reason
- Purple/pink gradient glass UI for every app
- Emoji as primary icons
- Fake testimonials
- Generic AI chatbot dashboard replacing the product's main flow
- Big desktop controls that overlap mobile title/chrome
- Hard-coded UI strings outside i18n

## Pre-Delivery Checklist

```markdown
- [ ] Matches existing repo tokens/theme
- [ ] Mobile layout works at ~375px
- [ ] Touch targets are at least 44px
- [ ] Light and dark are readable
- [ ] Language/theme reachable on mobile
- [ ] Main decision path is visible without extra navigation
- [ ] No internal version labels in user-facing UI
- [ ] Legal/help links remain reachable
```
