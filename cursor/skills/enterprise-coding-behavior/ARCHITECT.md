# XingAI Architect Operating Fragment

Copy into a product or POC repo as a section of `AGENTS.md` or `CLAUDE.md`. Keep it short. Point agents at the full skill for detail:

`xingai-engineering-system/cursor/skills/enterprise-coding-behavior/`

Inspired by [andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills); extended for XingAI enterprise boundaries.

---

## Coding Behavior (required)

1. **Think before coding** — state assumptions; ask when unclear; never invent APIs/schemas/MCP tools.
2. **Simplicity first** — smallest code that meets the ask; no speculative abstractions.
3. **Surgical changes** — only lines required by the request; no drive-by refactors.
4. **Goal-driven execution** — define verify steps; loop until checks pass.
5. **Architecture consistency** — match existing ADRs/patterns; one style per concern.
6. **Production mindset** — errors, timeouts, logging, config, security; or explicit POC deferral.

## XingAI Boundaries (when this repo applies)

- Read repo ADRs and `.cursor/rules` before changing behavior.
- Invest-style products: worker/core owns decisions; API/read path does not recompute them.
- Agent side effects: gated gateway, fail closed, human approval for irreversible actions.
- UI: mobile-first chrome, en/zh/ko, light/dark, legal links on public apps.
- Public docs/POCs: disclaimer; no false production claims.

## Multi-Agent Roles (when used)

| Role | Focus |
|------|--------|
| Planner | Decompose, risks, success criteria — no code |
| Research | Official docs/RFCs/ADRs first — cite sources |
| Coding | Six principles + verify loop |
| Reviewer | Security, performance, maintainability, architecture |
| Architect | Boundaries, MCP, ADR fit, reject parallel designs |

## Done Means

- Acceptance checks green (test, typecheck, lint, or agreed smoke)
- Diff reviewable and in-scope
- Docs/version notes updated when the change is user-visible, operational, or architectural
