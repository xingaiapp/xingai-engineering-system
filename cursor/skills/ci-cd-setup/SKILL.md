---
name: ci-cd-setup
description: >-
  Sets up GitHub Actions CI/CD for XingAI Next.js and FastAPI repos. Use when
  adding CI to a new project, adding a missing CI step, or wiring automated
  tests, security scans, and deploy previews.
---

# CI/CD Setup

Use this skill to add or fix GitHub Actions CI/CD in a XingAI repo.

Enterprise rule: **CI must pass before any PR can merge.** `main` is always green.

See templates in `templates/github-actions/` for copy-paste workflow files.

---

## Next.js CI Pipeline

Required steps on every PR:

1. Type-check (`tsc --noEmit`)
2. Lint (`next lint` or `eslint`)
3. Test (`vitest run`)
4. Coverage gate (`vitest run --coverage`)
5. Build (`next build`)
6. Security scan (`npm audit --audit-level=high`)
7. Accessibility check (Playwright + axe-core on key routes)

```yaml
# .github/workflows/ci.yml — copy from templates/github-actions/nextjs-ci.yml
```

Deploy: Vercel handles preview deploys on PR and production deploy on `main` merge automatically via Vercel GitHub integration. No deploy step needed in the Actions workflow.

---

## FastAPI CI Pipeline

Required steps on every PR:

1. Lint (`ruff check .`)
2. Type-check (`mypy .`)
3. Test + coverage (`pytest --cov-fail-under=70`)
4. Security scan (`pip-audit`)
5. Build check (`python -m py_compile main.py`)

```yaml
# .github/workflows/ci.yml — copy from templates/github-actions/fastapi-ci.yml
```

---

## Setting Up Secrets in GitHub

Actions secrets needed per repo:

```
VERCEL_TOKEN           ← only if using Vercel CLI in Actions (usually not needed)
OPENAI_API_KEY         ← for integration tests that call real AI (optional — use demo mode)
```

Set via: GitHub repo → Settings → Secrets and variables → Actions → New repository secret.

Never hardcode secrets in workflow files.

---

## Branch Protection (wire after CI is green)

In GitHub → Settings → Branches → Add rule for `main`:

```
✅ Require status checks: ci / test, ci / lint, ci / build
✅ Require branches to be up to date before merging
✅ Require at least 1 approval
✅ Dismiss stale reviews on push
✅ No force pushes
✅ No deletions
```

---

## Commitlint (enforce conventional commits in CI)

```yaml
# Add to .github/workflows/commitlint.yml
name: Commitlint
on: [pull_request]
jobs:
  commitlint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with: { fetch-depth: 0 }
      - uses: wagoid/commitlint-github-action@v6
```

```bash
npm install --save-dev @commitlint/cli @commitlint/config-conventional
```

```js
// commitlint.config.js
export default { extends: ['@commitlint/config-conventional'] };
```

---

## Dependency Update Automation (Dependabot)

Add to every XingAI repo:

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: npm
    directory: /
    schedule: { interval: weekly }
    open-pull-requests-limit: 5
    labels: [chore, dependencies]

  - package-ecosystem: pip
    directory: /backend
    schedule: { interval: weekly }
    open-pull-requests-limit: 5
    labels: [chore, dependencies]

  - package-ecosystem: github-actions
    directory: /
    schedule: { interval: monthly }
```

---

## Workflow Caching (speed up CI)

```yaml
# Node — add to every Next.js workflow
- uses: actions/cache@v4
  with:
    path: ~/.npm
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
    restore-keys: ${{ runner.os }}-node-

# Python — add to every FastAPI workflow
- uses: actions/cache@v4
  with:
    path: ~/.cache/pip
    key: ${{ runner.os }}-pip-${{ hashFiles('**/requirements*.txt') }}
    restore-keys: ${{ runner.os }}-pip-
```

---

## CI Checklist

```markdown
- [ ] .github/workflows/ci.yml created
- [ ] Type-check step present
- [ ] Lint step present
- [ ] Test + coverage step present (≥ 70% gate)
- [ ] npm audit / pip-audit step present
- [ ] Branch protection on main requires CI to pass
- [ ] .github/dependabot.yml added
- [ ] commitlint workflow added
- [ ] No secrets hardcoded in workflow files
```

## Common Mistakes

- CI passes because coverage threshold is not set — tests run but 0% coverage is fine.
- Secrets in workflow YAML — use `${{ secrets.NAME }}` always.
- No caching — CI takes 5+ minutes for a simple lint run.
- Branch protection not configured — engineers merge directly to `main`.
- Dependabot PRs ignored for months — security debt accumulates silently.
