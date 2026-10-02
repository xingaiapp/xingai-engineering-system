---
name: invest-deploy
description: >-
  Push xingai-invest-ai to git and deploy Fly.io backend (xingai-invest-ai-api).
  Use when the user invokes /invest-deploy or asks to push/deploy Invest AI,
  invert ai, or xingai-invest-ai to Fly.io. Runs commit, push, flyctl deploy,
  and health checks end-to-end.
---

# Invest AI — Git Push + Fly Deploy

**Quick invoke:** User picked `/invest-deploy` — run the full workflow now. Do not ask for confirmation unless git is dirty with ambiguous files or decision-cache boundary is violated.

## Repo

```text
Path:   /path/to/ai-projects-work-space/xingai-invest-ai
Remote: https://github.com/xingaiapp/xingai-invest-ai.git
Branch: main
```

Not `invest-t-advisor`. Not `xingai-dot-app`.

## Steps

1. **Inspect** — parallel: `git status`, `git diff`, `git log -3`, `branch -vv`
2. **Commit** — only if changes exist. Never commit: `.env*`, `stock-ai-back-end/sessions/`, `*.db`, secrets. Warn if FastAPI adds request-time decision logic (worker owns decisions).
3. **Push** — `git push origin main`
4. **Deploy** — `flyctl deploy --app xingai-invest-ai-api --remote-only` from repo root
5. **Smoke** — curl `/api/v1/health` and `/api/v2/health` → `{"status":"ok"}`
6. **Reply** — 中文 summary: commit, push, deploy, health, untracked leftovers

## Production

```text
Fly app:  xingai-invest-ai-api
API URL:  https://xingai-invest-ai-api.fly.dev
Frontend: https://invest.xingai.app (Vercel auto-deploy from main)
Runbook:  xingai-invest-ai/docs/deploy/release-runbook.md
```

No `fly secrets set` unless user explicitly asks.
