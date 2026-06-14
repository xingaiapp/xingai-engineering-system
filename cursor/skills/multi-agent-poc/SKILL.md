---
name: multi-agent-poc
description: >-
  Builds and demos XingAI multi-agent POCs that validate Enterprise Agent
  Platform architecture. Use when creating orchestrator + specialist agent
  pipelines, trace timelines, agent registry, MCP placeholders, or team demos
  for non-agent audiences.
---

# Multi-Agent POC

Use this skill when the user asks to build, extend, or demo a **multi-agent POC** — especially one positioned as **Phase 1 · MVP Validation Layer** for the XingAI Enterprise Agent Platform.

Reference implementation: `xingai-enterprise-ai-pocs/pocs/multi-agent-lab/`

## Positioning (say this in README and demo)

```text
Today:   Multi-Agent POC (Phase 1)
Tomorrow: XingAI Enterprise Agent Platform
```

The POC validates architecture — it is not merely an AI chatbot demo.

## Required POC Capabilities

Every multi-agent POC should demonstrate:

| Capability | Minimum implementation |
|---|---|
| Agent orchestration | Orchestrator plans handoffs and aggregates final answer |
| Specialized collaboration | ≥3 specialist agents with distinct roles |
| Tool execution | At least one tool behind an agent (simulated MCP OK in V1) |
| Trace logging | SQLite or equivalent: request_id, agent, input, output, tool, duration, timestamp |
| Governance (POC level) | Trace = audit trail; no hidden chain-of-thought in UI |
| Observability (POC level) | Timeline UI + basic metrics endpoint |

## Default Agent Set (Phase 1)

| Agent | Role |
|---|---|
| Orchestrator Agent | Plan, route, synthesize |
| Research Agent | Insight, trend, evidence |
| Product Agent | Concept, MVP features, value prop |
| Tech Agent | Architecture, API, deployment |
| Critic Agent | Risks and mitigations |

Phase 2+ agents (Security, Compliance, Data, Support, Finance, HR) may appear in registry as **planned** — do not implement all in V1.

## Recommended Stack (V1)

- Python FastAPI backend
- SQLite for trace + cache
- OpenAI API with structured JSON + fallback when key missing
- Simple HTML workspace (two columns: Final Output | Execution Timeline)
- No async queue, vector DB, or real MCP in V1

## Project Structure

```text
pocs/<name>/
├─ README.md
├─ architecture.md
├─ flow.mmd
├─ references.md
├─ enterprise-mapping.md      # POC → Platform mapping
└─ backend/
   ├─ main.py
   ├─ agents/
   │  ├─ orchestrator.py
   │  ├─ research_agent.py
   │  ├─ product_agent.py
   │  ├─ tech_agent.py
   │  └─ critic_agent.py
   ├─ tools/
   ├─ trace.py
   ├─ platform_registry.py
   └─ static/index.html
```

## API Endpoints (minimum)

| Endpoint | Purpose |
|---|---|
| `POST /demo/run` | Run orchestrator pipeline |
| `GET /demo/trace/{request_id}` | Fetch trace timeline |
| `GET /demo/metrics` | Observability counters |
| `GET /demo/agents` | Agent + MCP registry (active vs planned) |
| `GET /` | Demo workspace UI |

## Trace Step Schema

Log every agent step:

```text
request_id · step · agent_name · input · output · tool_used · duration_ms · timestamp
```

UI must show a **timeline**, not raw model reasoning. Trace detail on click is OK.

## Demo Script (5 minutes)

1. Frame: Phase 1 of Enterprise Agent Platform — same architecture, fewer agents.
2. Run sample goal (Product Ideation).
3. Walk Execution Timeline: Orchestrator → specialists → synthesis.
4. Click a step — show input, output, tool, duration.
5. Run same prompt again — show cache hit if applicable.
6. Close: extend agents and MCP later — do not rebuild architecture.

## V1 Do Not Build

- Real web crawling
- Production auth / RBAC / multi-tenant
- Async job queues
- Vector DB enterprise memory
- Full MCP gateway

Mark these as Phase 2/3 in sidebar or registry.

## Related Engineering Assets

- Pattern: `patterns/orchestrator-trace-governance.md`
- Pattern: `patterns/cache-first-before-llm.md`
- Template: `templates/enterprise-agent-poc-readme.md`
- Prompt: `prompts/multi-agent-poc-review.md`
- Architecture doc: `xingai-enterprise-ai-pocs/docs/ENTERPRISE-AGENT-PLATFORM.md`

## Common Mistakes

- Single chatbot disguised as multi-agent (no trace, no handoffs).
- Exposing hidden chain-of-thought instead of structured trace.
- Over-scoping V1 with MCP, events, and memory layers.
- POC with no fallback when OpenAI key is missing (demo fails live).
