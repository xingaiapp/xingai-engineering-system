# Repo Rule Bundles

Which engineering-system assets to install per repo type.

## Product app (Next.js) — e.g. `xingai-founder`, `xingai-learn`

**Rules** (copy to `.cursor/rules/`):

- `xingai-foundation.mdc`
- `typescript-quality.mdc`
- `security-baseline.mdc`
- `accessibility-baseline.mdc`
- `anti-ai-writing-style.mdc`
- `legal-protection-all-repos.mdc`
- `version-readme-before-push.mdc`

**Skills** (copy to `~/.cursor/skills/` or `.cursor/skills/`):

- `xingai-web-design`
- `research-ai-loading-ux`
- `api-error-handling`
- `testing-baseline`
- `ci-cd-setup`

**Templates:** `github-actions/nextjs-ci.yml`, `disclaimer-template.md`

## Enterprise POC — e.g. `xingai-enterprise-ai-pocs`

**Rules:** Product bundle + `poc-bilingual-design-reference.mdc`

**Skills:** `multi-agent-poc`, `system-design-docs`

## Design / docs — e.g. `xingai-enterprise-ai-design`

**Rules:** `anti-ai-writing-style.mdc`, `legal-protection-all-repos.mdc`

**Skills:** `system-design-docs`

## Engineering system repo

All rules and skills; maintain `docs/ASSET-INDEX.md`.
