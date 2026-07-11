---
name: growth-deploy
description: >-
  Build, push xingai-growth-monitor to git, and deploy Fly.io backend (xingai-growth-api).
  Use when the user invokes /growth-deploy or asks to push/deploy Growth Monitor,
  growth.xingai.app, or xingai-growth-api to Fly.io. Runs npm build, commit (if needed),
  push, flyctl deploy from back-end/, and health checks end-to-end.
---

# Growth Monitor — Build + Git Push + Fly Deploy

**Quick invoke:** User picked `/growth-deploy` — run the full workflow now. Do not ask for confirmation unless git is dirty with ambiguous files or secrets would be committed.

## Repo

```text
Path:     xingai-growth-monitor/  (workspace root)
Remote:   https://github.com/xingaiapp/xingai-growth-monitor.git
Branch:   main
Back-end: back-end/  (Fly deploy runs here)
```

Not `xingai-dot-app`. Frontend and back-end live in the **same repo**.

## Steps

1. **Build** — from repo root:
   ```bash
   cd xingai-growth-monitor && npm run build
   ```
   Stop if build fails. Fix errors before commit/push/deploy.

2. **Inspect** — parallel:
   ```bash
   git status
   git diff
   git diff --staged
   git log -3 --oneline
   git branch -vv
   ```

3. **README / version** — if the diff is user-visible or operational, confirm `README.md` version notes (workspace rule `version-readme-before-push`). Say why if skipped.

4. **Commit** — only when the user asked to push **and** there are uncommitted changes:
   - Never commit: `.env`, `.env.local`, secrets, `*.db`, `.next/`
   - Follow repo commit message style from `git log`
   - Use HEREDOC for commit message

5. **Push** — `git push origin main` (or current branch with `-u` if needed)

6. **Deploy Fly** — back-end only:
   ```bash
   cd back-end && flyctl deploy --app xingai-growth-api
   ```
   Do **not** run `fly secrets set` unless the user explicitly asks.

7. **Smoke** — after deploy:
   ```bash
   curl -sS https://xingai-growth-api.fly.dev/health
   curl -sS -o /dev/null -w "%{http_code}" https://xingai-growth-api.fly.dev/api/v2/overview
   ```
   Expect health JSON and overview `200` (or documented empty state).

8. **Reply** — short summary: build OK, commit hash (if any), push, Fly deploy, health status. Note that **Vercel** redeploys the frontend from `main` automatically when connected.

## Production

```text
Fly app:   xingai-growth-api
API URL:   https://xingai-growth-api.fly.dev
Frontend:  https://growth.xingai.app  (Vercel — auto-deploy from main)
Volume:    growth_monitor_data → /app/data  (SQLite)
Cron:      supercronic daily 02:00 UTC (back-end/crontab)
Manual:    POST /api/v2/cron/run
ADRs:      docs/adr/
Secrets:   back-end/scripts/sync-fly-secrets.sh  (only when user asks)
```

## Boundaries

- **Worker owns scans** — FastAPI reads cache; do not add request-time scan/GSC/OpenAI logic in route handlers (see ADR-003).
- **Frontend-only changes** — still run `npm run build`; Fly deploy optional but harmless if back-end unchanged.
- **Back-end-only changes** — still run `npm run build` if any shared types/proxy routes changed; otherwise build is a quick sanity check.

## Common mistakes

- Deploying from repo root instead of `back-end/`
- Pushing without running build first
- Committing `.env` or Fly secrets
- Forgetting Vercel picks up frontend from git push separately from Fly
