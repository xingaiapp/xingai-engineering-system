---
name: project-ship
description: >-
  Work on this project, get latest code and build no error push to git and fly.io.
  Use when the user invokes /project-ship or asks to pull latest, build cleanly,
  push to git, and deploy the current repo to Fly.io. Auto-detects repo, build
  command, fly.toml, and health checks. For xingai-invest-ai or xingai-growth-monitor,
  product-specific skills (invest-deploy, growth-deploy) are equivalent shortcuts.
---

# Project Ship — Pull, Build, Push, Fly Deploy

**Quick invoke:** User picked `/project-ship` or asked to ship the current project — run the full workflow now. Do not ask for confirmation unless git is dirty with ambiguous files, pull conflicts need human input, or secrets would be committed.

## Goal

On the **current repo**:

1. Get latest code from git
2. Build with **zero errors**
3. Push to git
4. Deploy to Fly.io (when `fly.toml` exists)

## Step 0 — Detect project

From the working directory:

```bash
git rev-parse --show-toplevel
git remote -v
git branch --show-current
```

Then locate deploy config:

```bash
# Prefer nearest fly.toml (repo root or back-end/)
find . -maxdepth 3 -name fly.toml -not -path '*/node_modules/*'
```

| Signal | Action |
|--------|--------|
| `fly.toml` at repo root | Deploy from root; read `app = "..."` |
| `back-end/fly.toml` | Deploy from `back-end/` |
| No `fly.toml` | Build + push only; skip Fly; say frontend may auto-deploy on Vercel |
| Repo matches a row in [projects.md](projects.md) | Use that row's build dir, Fly app, health URL |

Product shortcuts (same outcome, less detection):

- `xingai-invest-ai` → `invest-deploy` skill
- `xingai-growth-monitor` → `growth-deploy` skill

## Step 1 — Inspect git (parallel)

```bash
git status
git diff
git diff --staged
git log -3 --oneline
git branch -vv
```

Never commit: `.env`, `.env.*`, `*.db`, `sessions/`, `.next/`, secrets, local credentials.

## Step 2 — Get latest code

```bash
git fetch origin
```

**Clean working tree:**

```bash
git pull --rebase origin "$(git branch --show-current)"
```

**Dirty working tree** (uncommitted local work):

1. Commit local changes first (Step 4) **or** `git stash push -u -m "project-ship"` if changes are not ready to commit.
2. `git pull --rebase origin "$(git branch --show-current)"`
3. If stashed: `git stash pop` — resolve conflicts before build.

Stop on merge/rebase conflicts; report files and wait for user unless trivial to fix.

## Step 3 — Build (must pass)

Detect build command in this order:

1. [projects.md](projects.md) entry for this repo
2. `docs/deploy/*.md` or README deploy section
3. Root `package.json` with `"build"` script → `npm run build` at repo root
4. `stock-ai-front-end/package.json` → `cd stock-ai-front-end && npm run build`
5. `ui/package.json` → `cd ui && npm run build`
6. No JS build script → skip npm build; note backend-only Fly deploy

Run the build. **Stop on failure.** Fix errors, rebuild, only then continue.

Optional sanity (when script exists): `npm run lint` or `tsc --noEmit` — do not block ship if repo does not use them in CI.

## Step 4 — README / version (required on every push)

**Always** update `README.md` before push — no exceptions.

1. Find the visible version line (e.g. `**Version:** x.y.z` or `version` in package.json if README has no line — add one).
2. **Bump patch** (`x.y.z` → `x.y.(z+1)`) unless the user explicitly asked for minor/major.
3. Add a short **Version Notes** entry for this ship (what changed, 1–2 lines).
4. If the repo has no Version Notes section, add one under the version line.

Do this even for internal-only or worker-only changes — the note can say "internal/worker" but the bump is still required.

Include README changes in the commit that gets pushed (same commit as code, or a dedicated `docs: bump README version for ship` commit immediately before push).

## Step 5 — Commit

Commit **only when** uncommitted changes remain after build (including Step 4 README edits):

- Follow `git log` message style
- HEREDOC commit message
- Do not commit ignored secrets or build artifacts unless repo already tracks them

## Step 6 — Push

```bash
git push origin "$(git branch --show-current)"
```

Use `-u origin HEAD` when branch has no upstream.

## Step 7 — Deploy Fly.io

Skip if no `fly.toml`.

```bash
# From directory containing fly.toml
flyctl deploy --app <app-from-fly.toml> --remote-only
```

Use `--remote-only` for XingAI API apps (invest, research, eddy). Growth Monitor deploys from `back-end/` without `--remote-only` unless docs say otherwise.

Do **not** run `fly secrets set` unless the user explicitly asks.

## Step 8 — Smoke test

Curl the health endpoint from [projects.md](projects.md) or repo deploy docs. Expect `200` and documented JSON (e.g. `{"status":"ok"}`).

## Step 9 — Reply

Short summary:

- Repo name and branch
- Pull result (commits behind/ahead)
- Build command and pass/fail
- README version bumped to (required)
- Commit hash (if any)
- Push result
- Fly app + deploy result (or "no Fly app")
- Health check result
- Note: Vercel frontends on `*.xingai.app` often auto-deploy from `main` after push

## Boundaries

- **Invest AI** — worker owns decisions; do not add request-time decision logic in FastAPI before shipping.
- **Growth Monitor** — worker owns scans; FastAPI reads cache only.
- **No force push** to `main` unless user explicitly requests.
- **No amend** unless user rules allow and HEAD is unpushed local commit.

## Common mistakes

- Building before pull and missing remote changes
- Deploying from repo root when `fly.toml` lives in `back-end/`
- Pushing with a failing build
- Committing `.env` or SQLite DB files
- Skipping frontend build on monorepos (invest `stock-ai-front-end`, eddy `ui/`)
