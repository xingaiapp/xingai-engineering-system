# XingAI Engineering System

**Version:** 0.3.9

Reusable Cursor rules, skills, prompts, templates, and workflows that power XingAI apps, docs, blogs, design systems, and POCs.

This repository is the shared engineering operating system for XingAI. Product code stays in product repos. Reusable working methods live here.

## Connected Public Repositories

- [xingai-dot-app](https://github.com/xingaiapp/xingai-dot-app) — public website and product registry
- [xingai-tech-blog](https://github.com/xingaiapp/xingai-tech-blog) — engineering writeups and lessons learned
- [xingai-enterprise-ai-design](https://github.com/xingaiapp/xingai-enterprise-ai-design) — architecture articles and design patterns
- [xingai-enterprise-ai-pocs](https://github.com/xingaiapp/xingai-enterprise-ai-pocs) — runnable POCs for architecture patterns

## What Belongs Here

- Cursor Rules for persistent standards
- Cursor Skills for repeatable workflows
- Claude / Cursor prompts for repeatable analysis or writing
- Templates for README, ADR, PRD, POC docs, and launch docs
- Architecture and design patterns that apply across XingAI products
- Beginner-friendly instructions for using AI-assisted development tools

## What Does Not Belong Here

- Secrets, API keys, tokens, private credentials, or customer data
- Product source code
- One-off prompts that will not be reused
- Private local machine paths
- Project-specific deploy scripts with production-only details

## Repository Structure

```text
cursor/
  rules/
  skills/
prompts/
templates/
patterns/
docs/
```

## Starter Assets

### Cursor Rules

- `xingai-foundation.mdc` — mobile-first, i18n, theme, legal, SEO/AEO baseline
- `anti-ai-writing-style.mdc` — human writing style for UI/docs/marketing
- `typescript-quality.mdc` — strict mode, no-any, Zod validation, typed errors
- `conventional-commits.mdc` — feat/fix/chore/refactor commit format and commitlint setup
- `security-baseline.mdc` — secrets hygiene, dependency scanning, input validation, auth, CORS, rate limiting
- `accessibility-baseline.mdc` — WCAG 2.1 AA: semantic HTML, ARIA, contrast, keyboard nav, axe-core
- `branch-strategy.mdc` — trunk-based dev, branch naming, PR size, merge strategy, release tags
- `version-readme-before-push.mdc` — README/version notes before push
- `poc-bilingual-design-reference.mdc` — POCs must reference EN + 中文 design docs
- `reusable-xingai-engineering-system.mdc` — identify reusable assets without over-engineering
- `legal-protection-all-repos.mdc` — require disclaimers and liability protection across public repos
- `enterprise-coding-behavior.mdc` — Karpathy-inspired coding behavior + architecture consistency + production mindset (always on)

### Cursor Skills

- `enterprise-coding-behavior` — Think / Simplicity / Surgical / Goal-driven + enterprise Architecture Consistency and Production Mindset; includes agent-roles, checklists, ARCHITECT.md fragment
- `enterprise-agent-team` — multi-agent Planner / Research / Coding / Reviewer / Architect overlays on the shared behavior bar
- `xingai-mcp-builder` — build/extend XingAI MCP gateways and tools (Python-first, read/write split, fail-closed gates, mock-before-live)
- `xingai-project-pick` — from Opportunity Radar issue/email context, pick one XingAI project to create or upgrade (Decision Card EN/ZH)
- `project-init` — initialize new XingAI apps (hero light/dark pair + OG separation)
- `growth-deploy` — build, push, and Fly-deploy Growth Monitor
- `project-ship` — generic pull + build + push + Fly deploy for the current repo
- `xingai-web-design` — build and refine XingAI web UI surfaces
- `xingai-worker-setup` — scaffold worker/cache boundary architecture for AI products
- `api-error-handling` — standardize error responses across FastAPI and Next.js APIs
- `testing-baseline` — Vitest (Next.js) and pytest (FastAPI) setup with worker/cache test patterns
- `ci-cd-setup` — GitHub Actions CI pipelines, branch protection, Dependabot, commitlint
- `apply-worktree-safely` — apply agent worktree changes back to main without unsafe commits or silent overwrites
- `research-ai-loading-ux` — loading/status UX for AI, search, polling, RAG, and long-running jobs
- `multi-agent-poc` — build and demo orchestrator + specialist agent POCs for Enterprise Agent Platform validation
- `system-design-docs` — bilingual enterprise system design docs, 5W framework, system-design UX mockup PNGs (architecture posters, not web UI)

### Prompts

- `reusable-asset-review.md` — decide whether a solution should become a reusable asset
- `architecture-review.md` — review a project or POC for reusable architecture patterns
- `multi-agent-poc-review.md` — review multi-agent POCs before team or leadership demos
- `code-change.md` — implement any code change with explicit scope, out-of-scope, and acceptance checks
- `code-review.md` — XingAI-specific code review covering boundaries, i18n, mobile, security, a11y
- `pr-description.md` — write consistent PR descriptions across XingAI repos

### Templates

- `product-readme.md`
- `poc-readme.md`
- `enterprise-agent-poc-readme.md` — Phase 1 MVP Validation Layer POC docs
- `adr-template.md` — with stakeholders, risks, rollback plan, cost impact
- `prd-template.md` — with success metrics, phases, timeline, risk table
- `disclaimer-template.md`
- `github-actions/nextjs-ci.yml` — lint, type-check, test, build, npm audit
- `github-actions/fastapi-ci.yml` — ruff, mypy, pytest, pip-audit
- `github-actions/commitlint.yml` — conventional commit validation on PRs
- `github-actions/dependabot.yml` — weekly dep updates for npm, pip, and Actions

### Patterns

- `worker-cache-boundary.md` — worker computes, API reads cache
- `orchestrator-trace-governance.md` — multi-agent orchestration + trace audit trail
- `cache-first-before-llm.md` — hash-based input/analysis cache before LLM calls
- `env-validation-pattern.md` — Zod/Pydantic env validation with demo mode fallback
- `error-boundary-pattern.md` — Next.js error.tsx, not-found.tsx, loading.tsx, and FastAPI exception handlers
- `structured-logging-pattern.md` — JSON structured logs with request_id, event, duration_ms using pino (TS) and Python logging
- `decision-ledger-schema.md` — cross-product schema for recording AI recommendations + human outcomes
- `product-upgrade-rule.md` — rules for upgrading product dependencies and frameworks
- `loop-engineering-three-layer.md` — Context / Harness / Loop three-layer agent architecture with guardrails
- `micro-loop-engine.md` — dynamic agent assembly from reusable skills, tools, memory, and loop configs
- `executable-knowledge-pipeline.md` — encode team standards as CLAUDE.md / Skills / MCP so quality and velocity compound

## Install

See [`docs/HOW-TO-INSTALL.md`](docs/HOW-TO-INSTALL.md), [`docs/ASSET-INDEX.md`](docs/ASSET-INDEX.md), and [`docs/REPO-RULE-BUNDLES.md`](docs/REPO-RULE-BUNDLES.md).

## Reusability Principle

Favor systems over one-off solutions, but avoid premature abstraction.

If XingAI will likely use a pattern at least 3 times in the next 90 days, consider turning it into a rule, skill, prompt, template, or architecture pattern.

If it will likely be used once, solve it directly and do not abstract yet.

## Version Notes

### 0.3.9

- Add `xingai-project-pick` skill — Radar issue / newsletter context → one XingAI portfolio bet (Decision Card); CLI in `xingai-opportunity-radar` ADR-005

### 0.3.8

- Add `xingai-mcp-builder` skill — XingAI fork of generic MCP builder skills: Python-first, surgical vs full path, gateway/gate boundaries, sanitize/mask, mock drill, lite eval; refs robinhood-mcp + claims OAuth POC

### 0.3.7

- Add `enterprise-coding-behavior` skill + always-on rule — Karpathy four principles adapted for XingAI, plus Architecture Consistency and Production Mindset; `ARCHITECT.md` drop-in for `AGENTS.md` / `CLAUDE.md`
- Add `enterprise-agent-team` skill — shared system prompt block and Planner / Research / Coding / Reviewer / Architect role overlays for multi-agent POCs and Cursor Task teams
- Sync `VERSION` file with README (was lagging at 0.3.4)

### 0.3.6

- Extend `worker-cache-boundary`: any external HTTP in a request handler is a violation (not only LLM calls) — cite Invest AI secondary-quote-check fix

### 0.3.5

- Add `prompts/code-change.md` — copy-paste prompt for implementing any XingAI code change (scope, out-of-scope, acceptance, short variant); pairs with `code-review.md` and `pr-description.md`

### 0.3.4

- Extend `agent-execution-gate`: MCP gateway proxy as interception point; fail-closed on unwired gates (`xingai-robinhood-mcp` ADR-001)

### 0.3.3

- Extend `agent-execution-gate` with turn-scoped provenance and pin-vs-YAML deny+add-rule (Agent Firewall ADR-004/005)
- Update ADR-002 related links to firewall ADR-001..005 and matching tech-blog posts

### 0.3.2

- Add `growth-deploy` and `project-ship` Cursor Skills for build/push/Fly workflows
- Expand `project-init` hero rules: in-app light/dark visual pair, mobile strip, OG separate from hero
- Document new skills in `docs/HOW-TO-INSTALL.md`

### 0.3.1

- Add `system-design-docs` Cursor Skill — bilingual EN/ZH architecture docs, 5W framework, layered system-design UX mockup PNGs, dual-audience writing, XingAI pattern alignment
- Add `template.md` and `ux-mockup-prompt.md` supporting files under `cursor/skills/system-design-docs/`

### 0.3.0

- Add `conventional-commits.mdc` rule — feat/fix/chore/refactor format with commitlint setup
- Add `security-baseline.mdc` rule — secrets hygiene, npm/pip audit, CORS, rate limiting, CSP
- Add `accessibility-baseline.mdc` rule — WCAG 2.1 AA: semantic HTML, ARIA, contrast, axe-core
- Add `branch-strategy.mdc` rule — trunk-based dev, PR size limits, branch naming, release tags
- Add `testing-baseline` Cursor Skill — Vitest for Next.js, pytest for FastAPI, worker/cache test patterns, 70% coverage gates
- Add `ci-cd-setup` Cursor Skill — GitHub Actions setup, branch protection, Dependabot, commitlint
- Add `structured-logging-pattern.md` — pino (TS) + Python JSON logging with request_id, event schema, PII rules
- Add GitHub Actions templates: `nextjs-ci.yml`, `fastapi-ci.yml`, `commitlint.yml`, `dependabot.yml`

### 0.2.0

- Add `xingai-worker-setup` Cursor Skill — scaffolds worker/cache boundary architecture with Python + Next.js patterns
- Add `api-error-handling` Cursor Skill — standardizes error shapes, exception handlers, and localized error UI across FastAPI and Next.js
- Add `typescript-quality.mdc` rule — strict mode, no-any, Zod validation, typed errors for all XingAI TS projects
- Add `env-validation-pattern.md` — Zod/Pydantic env validation at startup with demo mode fallback
- Add `error-boundary-pattern.md` — Next.js error.tsx / not-found.tsx / loading.tsx templates + FastAPI catch-all handlers
- Add `code-review.md` prompt — XingAI-specific review covering worker boundaries, i18n, mobile, security, accessibility
- Add `pr-description.md` prompt — consistent PR description format for all XingAI repos
- Improve `adr-template.md` — add stakeholders, impact, risks, rollback plan, cost/resource impact
- Improve `prd-template.md` — add status, owner, success metrics, phases, timeline, risk table

### 0.1.4

- Add `multi-agent-poc` Cursor Skill (orchestrator + specialist agents + trace demos)
- Add patterns: `orchestrator-trace-governance`, `cache-first-before-llm`
- Add prompt `multi-agent-poc-review.md` and template `enterprise-agent-poc-readme.md`
- Promoted from `xingai-enterprise-ai-pocs`, `xingai-learn`, and `xingai-founder` work

### 0.1.3

- Add `research-ai-loading-ux` Cursor Skill for trustworthy AI/search loading states
- Standardize staged status boxes with elapsed time, progress, completion, and retry behavior

### 0.1.2

- Add `apply-worktree-safely` Cursor Skill for safer multi-worktree agent workflows
- Document a patch-based apply flow that avoids temporary commits and refuses silent untracked-file overwrites

### 0.1.1

- Add global legal protection rule for all XingAI repos
- Add reusable disclaimer template for public repos, POCs, docs, prompts, and code examples

### 0.1.0

- Initial public engineering system repo
- Add reusable Cursor Rules, Skills, prompts, templates, and patterns
- Add install guide and contribution guidance
