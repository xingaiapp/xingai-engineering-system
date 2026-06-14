# Orchestrator + Trace Governance

Use this pattern when a XingAI product or POC uses **multiple specialist agents** and must explain **what happened behind the scenes** to engineers, architects, or leadership.

Validated in: `xingai-enterprise-ai-pocs/pocs/multi-agent-lab/`, `xingai-founder`, `xingai-learn` (decision pipeline).

## Core Rule

**Orchestrator owns routing and aggregation. Specialists own one domain. Trace owns auditability.**

```text
User Goal
   ↓
Orchestrator (plan + log decision)
   ↓
Specialist Agents (structured JSON output)
   ↓
Tools (optional, behind agents — MCP in production)
   ↓
Orchestrator (synthesize final answer)
   ↓
Trace Log + User-facing result
```

## Orchestrator Owns

- Intent / goal interpretation
- Agent selection and ordering
- Handoff planning (logged as trace step 1)
- Final aggregation (logged as last step)
- Never do all specialist work itself in V1 demos

## Specialist Agent Owns

- One role, one goal, one output schema
- Structured JSON (not long prose) for reliable handoffs
- Optional tool calls scoped to its domain

## Trace Owns

Every step stores:

```text
request_id
step
agent_name
input
output
tool_used
duration_ms
timestamp
```

Trace is **governance at POC level**. It is not full enterprise audit retention, RBAC, or compliance — but it proves the architecture.

## UI Rule

Show:

- Execution timeline (who ran, status, duration)
- Final answer (result / summary / artifacts tabs)
- Trace detail on step click

Do **not** show hidden chain-of-thought or raw model reasoning streams.

## Observability Minimum

- `GET /demo/trace/{request_id}` or equivalent
- Metrics: total requests, success rate, avg step latency
- Phase label: `Phase 1 · MVP Validation Layer`

## Enterprise Evolution

| POC (Phase 1) | Platform (Phase 2–3) |
|---|---|
| SQLite trace_logs | Long-retention audit store |
| HTML timeline | Full observability dashboard |
| fake_research_tool | MCP Registry → enterprise systems |
| Sync pipeline | Event Bus + async workers |

## Why It Works

Non-agent audiences trust systems they can **see collaborate**. Trace proves orchestration without magic chatbot behavior.

## Common Mistakes

- One LLM call labeled as "multi-agent."
- Trace stored only in memory (lost on restart).
- Specialist agents return incompatible output shapes.
- Governance claimed without request_id or tool attribution.
