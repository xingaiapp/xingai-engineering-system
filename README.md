# XingAI Engineering System

**Version:** 0.3.31

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
- `xingai-cache-seo-aeo-geo.mdc` — one HTML for SEO/AEO/GEO; separate cache layers; no generic TTL sheet on xingai.app, Invest, or Travel
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
- `project-init` — initialize new XingAI apps (Invest-style en/zh/ko, hero light/dark + OG, **XNP** notifications)
- `growth-deploy` — build, push, and Fly-deploy Growth Monitor
- `invest-deploy` — push + Fly-deploy Invest AI API (`xingai-invest-ai-api`)
- `project-ship` — generic pull + build + push + Fly deploy for the current repo
- `xingai-docs-pack` — ADR + tech blog + enterprise design + wiki docs pack
- `xingai-docs-sync` — bilingual ADR / README / BDR convention sync
- `xingai-ai-learning-wiki` — scan public xingaiapp repos into the AI-Learning Wiki
- `xingai-wiki-ingest` — ingest URL / image / notes into the wiki
- `xingai-ux-png` — critique + draw original UX PNG for wiki courses
- `xingai-daily-stock-intelligence` — daily US market intelligence report (watchlist is a private template)
- `xingai-video` — XingAI alias for web-video-presentation (axing-daily STYLE notes only; no private PPTX)
- `web-video-presentation` — clickable 16:9 web-video stages (upstream garden skill)
- `universal-diagram` — presentation-ready 16:9 architecture / product diagrams
- `draw-it` — thin alias for `universal-diagram` (`/draw-it`)
- `xingai-team-visual` — fixed six-character team illustration system (星哥 + five leaders 至尊宝 / 牛夫人 / 小甜甜 / 二当家 / 华安)
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
- `shared-intelligence-layer.md` — Internet→…→Learning spine; shared Evidence/Audit/Outcome ownership (no central DB)
- `product-upgrade-rule.md` — rules for upgrading product dependencies and frameworks
- `loop-engineering-three-layer.md` — Context / Harness / Loop three-layer agent architecture with guardrails
- `micro-loop-engine.md` — dynamic agent assembly from reusable skills, tools, memory, and loop configs
- `executable-knowledge-pipeline.md` — encode team standards as CLAUDE.md / Skills / MCP so quality and velocity compound

## Install

See [`docs/HOW-TO-INSTALL.md`](docs/HOW-TO-INSTALL.md) (Cursor; [中文](docs/HOW-TO-INSTALL.zh-CN.md)), [`docs/INSTALL-CLAUDE-CODE.md`](docs/INSTALL-CLAUDE-CODE.md) (Claude Code; [中文](docs/INSTALL-CLAUDE-CODE.zh-CN.md)), [`docs/ASSET-INDEX.md`](docs/ASSET-INDEX.md), and [`docs/REPO-RULE-BUNDLES.md`](docs/REPO-RULE-BUNDLES.md).

## Reusability Principle

Favor systems over one-off solutions, but avoid premature abstraction.

If XingAI will likely use a pattern at least 3 times in the next 90 days, consider turning it into a rule, skill, prompt, template, or architecture pattern.

If it will likely be used once, solve it directly and do not abstract yet.

## Version Notes / Changelog

### 0.3.31

- `docs/HOW-TO-INSTALL.md` / `.zh-CN.md`: fix `xingai-team-visual` description — six-character bible (星哥 + five leaders), matching the skill
- `xingai-team-visual`: localized personality nameplates now follow the live xingai.app `/team` copy (Joker, Lady Bull, Second Master, 싱게 …) with titles and taglines; ko / en org-chart images are art references only for names

### 0.3.30

- Add `docs/HOW-TO-INSTALL.zh-CN.md` — Chinese translation of the Cursor install guide; language switch links in both versions and README

### 0.3.29

- Add `docs/INSTALL-CLAUDE-CODE.zh-CN.md` — Chinese translation of the Claude Code install guide; language switch links in both versions, README and HOW-TO-INSTALL

### 0.3.28

- `docs/INSTALL-CLAUDE-CODE.md`: document the symlink layout — two-hop chain `~/.claude/skills` → `~/.cursor/skills` → repo, repo-linked vs. private local copies, and a one-line layout check; install steps now follow the chain

### 0.3.27

- `xingai-team-visual`: add Korean and English strings for the personality nameplate set (고집 끝판왕 / Never Backs Down …) plus localized taglines

### 0.3.26

- Add `xingai-cache-seo-aeo-geo` rule. Same core HTML for users and crawlers. Vercel static HTML stays on the deployment alias. Invest stays worker-cache read-only. Do not implement the generic 5–60 minute / 30–60 second TTL sheet.

### 0.3.25

- ADR-004 Team Visual Character System (EN + 中文) — platform cast: 星哥 + five leaders (incl. 华安); skill owns bible, `xingai-dot-app` owns public `/team`; org chart deferred on marketing Team by default

### 0.3.24

- `xingai-team-visual`: keep two official nameplate sets — personality set (嘴最硬 / 最会追责 / 最会哄人 / 背锅侠 + 情报员 / 最会写码) for posters and About pages, org-role set (QA总闸 / 内容策略 / 发布 / 复核 / 代码技术工具) for org charts; never mix them in one image

### 0.3.23

- `xingai-team-visual`: add the Korean full org chart (`xingai-team-org-chart-full-ko.jpg`); list every reference image (core five, character bible, org chart zh / en / ko) in SKILL.md

### 0.3.22

- `xingai-team-visual`: refresh Character Bible + org-chart reference assets (EN/KO org charts, updated core five)

### 0.3.21

- `xingai-team-visual`: align the Character Bible with the reference images — core is now 星哥 + five leaders (adds 华安（唐伯虎）), roles / nameplates follow the org chart (QA总闸, 内容策略, 发布, 复核, 代码技术工具), team structure is 星哥 → each leader, 至尊宝 deep blue vs 华安 sky blue

### 0.3.20

- `xingai-team-visual`: add a no-image-tool path for Claude Code — output a ready prompt, review returned images against the Quality Checklist, build SVG / HTML layouts from the reference images

### 0.3.19

- Add `xingai-team-visual` skill — XingAI five-character Team Visual System (Character Bible, master + reference-continuation prompts, core-five + org-chart reference images)

### 0.3.18

- Add `docs/INSTALL-CLAUDE-CODE.md` — install `cursor/skills/*` into Claude Code (`~/.claude/skills/`) on another machine via symlinks; `universal-diagram` worked example, update / edit / uninstall flow
- Sync README header version with `VERSION` (was still showing 0.3.17)

### 0.3.17

- `project-init`: force desktop left-menu mid-edge toggle + fixed menu / content shift; add `references/desktop-sidebar.md`
- `xingai-web-design`: publish bilingual helpers (`SKILL.zh-CN.md`, `README.zh-CN.md`, `references/*`); keep English `SKILL.md` as source of truth

### 0.3.16

- Add `draw-it` alias skill → `universal-diagram` (`/draw-it`)

### 0.3.15

- Sync more public-safe personal Cursor skills into `cursor/skills/`: `invest-deploy`, `xingai-docs-pack`, `xingai-docs-sync`, `xingai-ai-learning-wiki`, `xingai-wiki-ingest`, `xingai-ux-png`, `xingai-daily-stock-intelligence` (watchlist scrubbed to placeholders), `universal-diagram`, `web-video-presentation`, `xingai-video` (STYLE.md only; no private PPTX/media)
- Paths scrubbed to `/path/to/...` or `~/.cursor/skills` — see `docs/PRIVACY-SAFETY-CHECKLIST.md`

### 0.3.14

- ADR-003 Shared Intelligence Layer + `patterns/shared-intelligence-layer.md` — one Evidence→…→Learning spine across sites; reuse Evidence Engine / Decision Ledger / Agent Firewall; no per-product rebuild, no central shared DB.

### 0.3.13

- Add workspace `AGENTS.md` (Product Upgrade Rule + Meal/Cook/Invest examples; Invest decision boundary).
- Sync `xingai-foundation` + `anti-ai-writing-style` rules; drop dependency on deleted root markdown guides.
- Add `xingai-brand-story` skill pointer updates.

### 0.3.12

- Add `human-overlay-cache` pattern + Cursor Rule — separate `v1:review:` (human) from worker verify cache; validated by evidence-engine ADR-009

### 0.3.11

- Expand `project-init` Language: match Invest AI dashboard multilanguage — `en`/`zh`/`ko`, `LangProvider` + `tr()`, `LANGUAGE_MENU` header switcher, `localStorage` `app_language`, nav/label tables; block default next-intl URL routing

### 0.3.10

- Expand `project-init`: require **XingAI Notification Platform (XNP)** for SMS/email/push — tenant id, env placeholders, no direct Twilio/Resend/FCM in new apps; fake adapter allowed until XNP Phase 5+

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
