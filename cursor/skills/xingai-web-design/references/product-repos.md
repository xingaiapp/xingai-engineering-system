# XingAI web product repos

Workspace root (typical): `ai-projects-work-space/`

| Domain | Repo | Front-end root | Notes |
|--------|------|----------------|-------|
| xingai.app | xingai-dot-app | `/app` | Next.js marketing |
| meal.xingai.app | xingai-meal-coach-ai | meal_v1 (full), meal_v4 (demo) | Vercel Root Directory = subfolder |
| cook.xingai.app | xingai-cook-ai | cook_v1 | |
| routine.xingai.app | xingai-routine-ai | routine_v1 | |
| invest.xingai.app | xingai-invest-ai | stock-ai-front-end | Decision board, bilingual |
| sat.xingai.app | xingai-sat-ai | `/app` | SAT prep; teal-green oklch hue ~165, `html[data-theme]` |
| travel / outfit / parent | xingai-travel-ai, etc. | per repo | Same upgrade rules |

## Deploy

- Each app subfolder has `vercel.json` + `VERCEL.md` when using monorepo layout.
- Root Directory in Vercel must match one config mode (empty **or** subfolder — not both).

## Local-only (gitignored at workspace root)

- `web-design-engineer/` — upstream skill clone; use `~/.cursor/skills/xingai-web-design/` for XingAI rules instead.
