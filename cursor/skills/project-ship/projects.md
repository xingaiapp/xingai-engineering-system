# XingAI Fly + Build Registry

Agent: read this file when [SKILL.md](SKILL.md) auto-detection is ambiguous.

Direct API hostnames are not published in this public catalog. Use the product's public domain when it proxies the API, or the API host from your local (private) copy of this skill.

| Repo folder | Build command | Fly deploy cwd | Fly app | Health check |
|-------------|---------------|----------------|---------|------------|
| `xingai-invest-ai` | `cd stock-ai-front-end && npm run build` | repo root | `xingai-invest-ai-api` | `https://invest.xingai.app/api/v1/health` and `/api/v2/health` (public, proxied) |
| `xingai-growth-monitor` | `npm run build` (repo root) | `back-end/` | `xingai-growth-api` | `/health` on the API host |
| `xingai-research-ai` | `npm run build` (repo root) | repo root | `xingai-research-ai-api` | `/api/v2/health` on the API host |
| `eddy-sat-ai` | `cd ui && npm run build` | repo root | `eddy-sat-api` | `/health` on the API host |

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
