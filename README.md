# XingAI Engineering System

**Version:** 0.2.0

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
- `version-readme-before-push.mdc` — README/version notes before push
- `poc-bilingual-design-reference.mdc` — POCs must reference EN + 中文 design docs
- `reusable-xingai-engineering-system.mdc` — identify reusable assets without over-engineering
- `legal-protection-all-repos.mdc` — require disclaimers and liability protection across public repos

### Cursor Skills

- `project-init` — initialize new XingAI apps
- `xingai-web-design` — build and refine XingAI web UI surfaces
- `xingai-worker-setup` — scaffold worker/cache boundary architecture for AI products
- `api-error-handling` — standardize error responses across FastAPI and Next.js APIs
- `apply-worktree-safely` — apply agent worktree changes back to main without unsafe commits or silent overwrites
- `research-ai-loading-ux` — loading/status UX for AI, search, polling, RAG, and long-running jobs
- `multi-agent-poc` — build and demo orchestrator + specialist agent POCs for Enterprise Agent Platform validation

### Prompts

- `reusable-asset-review.md` — decide whether a solution should become a reusable asset
- `architecture-review.md` — review a project or POC for reusable architecture patterns
- `multi-agent-poc-review.md` — review multi-agent POCs before team or leadership demos
- `code-review.md` — XingAI-specific code review covering boundaries, i18n, mobile, security
- `pr-description.md` — write consistent PR descriptions across XingAI repos

### Templates

- `product-readme.md`
- `poc-readme.md`
- `enterprise-agent-poc-readme.md` — Phase 1 MVP Validation Layer POC docs
- `adr-template.md` — expanded with stakeholders, risks, rollback plan, cost impact
- `prd-template.md` — expanded with success metrics, phases, timeline, risk table
- `disclaimer-template.md`

### Patterns

- `worker-cache-boundary.md` — worker computes, API reads cache
- `orchestrator-trace-governance.md` — multi-agent orchestration + trace audit trail
- `cache-first-before-llm.md` — hash-based input/analysis cache before LLM calls
- `env-validation-pattern.md` — Zod/Pydantic env validation with demo mode fallback
- `error-boundary-pattern.md` — Next.js error.tsx, not-found.tsx, loading.tsx, and FastAPI exception handlers

## Install

See [`docs/HOW-TO-INSTALL.md`](docs/HOW-TO-INSTALL.md).

## Reusability Principle

Favor systems over one-off solutions, but avoid premature abstraction.

If XingAI will likely use a pattern at least 3 times in the next 90 days, consider turning it into a rule, skill, prompt, template, or architecture pattern.

If it will likely be used once, solve it directly and do not abstract yet.

## Version Notes

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
