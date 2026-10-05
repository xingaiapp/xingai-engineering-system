# XingAI Engineering System — Asset Index

Quick reference for rules, skills, prompts, templates, and patterns in this repo.

## Cursor Rules (`cursor/rules/`)

| Rule | When to use |
|------|-------------|
| `xingai-foundation.mdc` | All XingAI product apps — mobile, i18n, legal, SEO |
| `xingai-cache-seo-aeo-geo.mdc` | xingai.app, Invest, Travel — one HTML, separate cache layers, no generic TTL sheet |
| `typescript-quality.mdc` | TypeScript / Next.js projects |
| `security-baseline.mdc` | All repos with API or user data |
| `accessibility-baseline.mdc` | UI with React components |
| `anti-ai-writing-style.mdc` | User-facing copy and docs |
| `legal-protection-all-repos.mdc` | Public repos — disclaimers |
| `conventional-commits.mdc` | Git commit format |
| `branch-strategy.mdc` | PR workflow |
| `poc-bilingual-design-reference.mdc` | Enterprise POC repos |
| `reusable-xingai-engineering-system.mdc` | Promoting patterns to this repo |
| `human-overlay-cache.mdc` | Worker-first apps with human accept/reject/edit overlays |
| `enterprise-coding-behavior.mdc` | All code changes — think / simple / surgical / verify |

## Cursor Skills (`cursor/skills/`)

| Skill | Trigger |
|-------|---------|
| `enterprise-coding-behavior` | Features, fixes, refactors, Karpathy-style behavior, AGENTS.md fragments |
| `enterprise-agent-team` | Multi-agent Planner/Research/Coding/Reviewer/Architect teams |
| `xingai-mcp-builder` | New/extend MCP servers, gateways, tools, OAuth MCP, control-plane contracts |
| `xingai-project-pick` | Radar issue/email → one XingAI create/upgrade Decision Card (EN/ZH) |
| `project-init` | New `*.xingai.app` product |
| `growth-deploy` | Growth Monitor build + Fly |
| `invest-deploy` | Invest AI git push + Fly API |
| `project-ship` | Generic pull + build + push + Fly |
| `xingai-web-design` | Web UI / dashboard work |
| `xingai-docs-pack` | ADR + blog + design + wiki pack |
| `xingai-docs-sync` | ADR/README/BDR convention sync |
| `xingai-ai-learning-wiki` | Public-repo → AI-Learning Wiki |
| `xingai-wiki-ingest` | URL/image/notes → wiki |
| `xingai-ux-png` | Critique + original UX PNG |
| `xingai-daily-stock-intelligence` | Daily US market intelligence brief |
| `xingai-video` | Web-video alias + axing-daily STYLE |
| `web-video-presentation` | 16:9 clickable web-video stages |
| `universal-diagram` | 16:9 architecture / product diagrams |
| `draw-it` | Alias for `universal-diagram` (`/draw-it`) |
| `xingai-team-visual` | XingAI team / About illustrations (星哥 + five leaders; [ADR-004](adr/004-team-visual-character-system.md)) |
| `research-ai-loading-ux` | AI waits >2s |
| `xingai-worker-setup` | Worker + cache boundary |
| `api-error-handling` | API routes, error shapes |
| `testing-baseline` | Vitest / pytest setup |
| `ci-cd-setup` | GitHub Actions CI |
| `multi-agent-poc` | Enterprise agent POCs |
| `system-design-docs` | Bilingual architecture docs + UX PNGs |
| `apply-worktree-safely` | Multi-worktree git apply |

## Prompts (`prompts/`)

| Prompt | Purpose |
|--------|---------|
| `reusable-asset-review.md` | Should this become a reusable asset? |
| `architecture-review.md` | Architecture / boundary review |
| `multi-agent-poc-review.md` | Pre-demo POC review |
| `code-change.md` | Implement any feature/fix with scope + acceptance |
| `code-review.md` | PR review checklist |
| `pr-description.md` | Standard PR body |

## Templates (`templates/`)

| Template | Purpose |
|----------|---------|
| `product-readme.md` | Product repo README |
| `poc-readme.md` | Generic POC |
| `enterprise-agent-poc-readme.md` | Phase 1 agent POC |
| `adr-template.md` | Architecture decision record |
| `prd-template.md` | Product requirements |
| `disclaimer-template.md` | Legal disclaimer |
| `github-actions/*.yml` | CI workflows |

## Patterns (`patterns/`)

| Pattern | Status note |
|---------|-------------|
| `worker-cache-boundary.md` | Reference: invest-ai style |
| `human-overlay-cache.md` | Validated: evidence-engine ADR-009 |
| `cache-first-before-llm.md` | Validated: learn, founder |
| `orchestrator-trace-governance.md` | Reference: multi-agent-lab |
| `env-validation-pattern.md` | Target for Next.js env.ts |
| `error-boundary-pattern.md` | Target for App Router |
| `structured-logging-pattern.md` | JSON logs + request_id |
| `product-upgrade-rule.md` | V2 inherits V1 UX |
| `decision-ledger-schema.md` | Proposed: cross-product decision history, zero adopters yet |

## Install

See [docs/HOW-TO-INSTALL.md](docs/HOW-TO-INSTALL.md) and [docs/REPO-RULE-BUNDLES.md](docs/REPO-RULE-BUNDLES.md) (when present).
