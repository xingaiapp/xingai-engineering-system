# XingAI Engineering System

**Version:** 0.1.0

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
- `version-readme-before-push.mdc` — README/version notes before push
- `poc-bilingual-design-reference.mdc` — POCs must reference EN + 中文 design docs
- `reusable-xingai-engineering-system.mdc` — identify reusable assets without over-engineering

### Cursor Skills

- `project-init` — initialize new XingAI apps
- `xingai-web-design` — build and refine XingAI web UI surfaces

### Prompts

- `reusable-asset-review.md` — decide whether a solution should become a reusable asset
- `architecture-review.md` — review a project or POC for reusable architecture patterns

### Templates

- `product-readme.md`
- `poc-readme.md`
- `adr-template.md`
- `prd-template.md`

## Install

See [`docs/HOW-TO-INSTALL.md`](docs/HOW-TO-INSTALL.md).

## Reusability Principle

Favor systems over one-off solutions, but avoid premature abstraction.

If XingAI will likely use a pattern at least 3 times in the next 90 days, consider turning it into a rule, skill, prompt, template, or architecture pattern.

If it will likely be used once, solve it directly and do not abstract yet.

## Version Notes

### 0.1.0

- Initial public engineering system repo
- Add reusable Cursor Rules, Skills, prompts, templates, and patterns
- Add install guide and contribution guidance
