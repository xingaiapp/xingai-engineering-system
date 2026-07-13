---
name: enterprise-agent-team
description: >-
  Runs XingAI multi-agent team workflows with shared enterprise coding behavior
  and role overlays for Planner, Research, Coding, Reviewer, and Architect. Use
  when designing agent teams, writing orchestrator prompts, splitting Cursor Task
  agents, reviewing multi-agent POCs, or aligning Sedgwick/MCP/enterprise demos
  on one behavior bar.
---

# Enterprise Agent Team

Shared behavior bar for multi-agent work. Do not let each agent invent its own quality standard.

**Depends on:** [enterprise-coding-behavior](../enterprise-coding-behavior/SKILL.md) (six principles).  
**Role details:** [agent-roles.md](../enterprise-coding-behavior/agent-roles.md)  
**Checklists:** [checklists.md](../enterprise-coding-behavior/checklists.md)

---

## When To Use

- Building or extending a multi-agent POC (`multi-agent-poc` skill)
- Splitting work across Planner / Research / Coding / Reviewer / Architect
- Enterprise demos (claims, MCP OAuth, gateway gates, human-in-the-loop)
- Writing system prompts so every specialist inherits the same global rules

---

## Team Topology

```text
User goal
   ↓
Planner  →  (optional) Research
   ↓
Coding
   ↓
Reviewer  ↔  Architect (when boundaries / MCP / cross-service)
   ↓
Verified change + notes
```

| Agent | Skill focus | Success looks like |
|-------|-------------|-------------------|
| Planner | Decompose, risks, success criteria | Verifiable plan; clear out-of-scope |
| Research | Official docs, RFCs, ADRs, in-repo code | Cited findings; fact vs inference |
| Coding | Six principles + test/verify loop | Smallest green diff |
| Reviewer | Security, performance, maintainability, architecture | Severity-tagged findings |
| Architect | DDD/events only if repo uses them; MCP; cloud of *this* stack; consistency | One approved approach; ADR follow-ups |

Stack note: XingAI defaults are TypeScript/Next.js, Python/FastAPI, workers, Fly, MCP gateways. Do not inject .NET/Azure checklists unless the target repo actually uses them.

---

## Shared System Prompt Block

Paste into every agent (or orchestrator preamble):

```text
You follow XingAI enterprise coding behavior:
1) Think before coding — no silent assumptions; never invent APIs/MCP tools.
2) Simplicity first — minimum code; no speculative abstractions.
3) Surgical changes — no drive-by refactors.
4) Goal-driven execution — define verify steps; loop until green.
5) Architecture consistency — match existing ADRs/patterns; one style per concern.
6) Production mindset — errors/timeouts/logging/security, or explicit POC deferral.

Read existing implementation first. Fail closed on unwired agent/MCP write paths.
```

Then append the role overlay from `agent-roles.md` for that agent only.

---

## Orchestrator Rules

1. Planner runs before Coding unless the task is trivial.
2. Research runs when APIs, RFCs, MCP auth, or cloud behavior are unclear.
3. Coding may not expand Planner out-of-scope without a new plan.
4. Reviewer blocks on Critical; Architect required for new boundaries or write tools.
5. Demo scripts must show: plan → evidence → gated action → audit/trace — not only a chat answer.

---

## POC vs Production

| | POC | Production product |
|--|-----|--------------------|
| Auth | Real OAuth OK if that is the lesson; else labeled placeholder | Required |
| Gates | Show fail-closed even if some gates are stubs | All write gates wired |
| Observability | Trace timeline minimum | Logs + metrics + alerts as product standard |
| Claims | "Validates architecture" | No "enterprise-ready" without named gaps |

---

## Related Assets

- Skill: `multi-agent-poc` — build orchestrator + specialists
- Prompt: `multi-agent-poc-review.md` — pre-demo review
- Prompt: `code-change.md` / `code-review.md`
- Patterns: `agent-execution-gate`, `orchestrator-trace-governance`, `loop-engineering-three-layer`
- Skill: `xingai-mcp-builder` — when adding MCP tools or gateways
- Drop-in fragment: [ARCHITECT.md](../enterprise-coding-behavior/ARCHITECT.md)
