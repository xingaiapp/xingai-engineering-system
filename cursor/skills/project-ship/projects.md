# XingAI Fly + Build Registry

Agent: read this file when [SKILL.md](SKILL.md) auto-detection is ambiguous.

| Repo folder | Build command | Fly deploy cwd | Fly app | Health URL |
|-------------|---------------|----------------|---------|------------|
| `xingai-invest-ai` | `cd stock-ai-front-end && npm run build` | repo root | `xingai-invest-ai-api` | `https://xingai-invest-ai-api.fly.dev/api/v1/health` and `/api/v2/health` |
| `xingai-growth-monitor` | `npm run build` (repo root) | `back-end/` | `xingai-growth-api` | `https://xingai-growth-api.fly.dev/health` |
| `xingai-research-ai` | `npm run build` (repo root) | repo root | `xingai-research-ai-api` | `https://xingai-research-ai-api.fly.dev/api/v2/health` |
| `eddy-sat-ai` | `cd ui && npm run build` | repo root | `eddy-sat-api` | `https://eddy-sat-api.fly.dev/health` |

## Vercel-only (no Fly in repo)

Build + push ships frontend; no Step 7.

| Repo folder | Build command | Production URL |
|-------------|---------------|----------------|
| `xingai-dot-app` | `npm run build` | `https://xingai.app` |
| `xingai-travel-ai` | `npm run build` | `https://travel.xingai.app` |
| `xingai-cook-ai/cook_v1` | `npm run build` | `https://cook.xingai.app` |
| `xingai-meal-coach-ai/meal_v4` | `npm run build` | `https://meal.xingai.app` |
| `xingai-routine-ai/routine_v1` | `npm run build` | `https://routine.xingai.app` |

## Runbooks

- Invest: `xingai-invest-ai/docs/deploy/release-runbook.md`
- Growth: `xingai-growth-monitor/docs/adr/002-fly-vercel-deploy-split.md`
- Research: `xingai-research-ai/docs/deploy/fly-io.md`
