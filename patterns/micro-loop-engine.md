# Micro Loop Engine

Use this pattern when a platform needs to serve multiple business problems with different agent configurations instead of hardcoding one agent per use case.

Validated (design-level) in: `xingai-enterprise-ai-pocs` (ENTERPRISE-AGENT-PLATFORM.md), `xingai-enterprise-ai-design` (Beyond Prompt Engineering article). Partially validated in: `xingai-invest-ai` (worker selects different decision paths per symbol type).

## Core Rule

**Don't build one agent per business problem. Build a runtime that assembles purpose-built agents on demand from reusable components.**

```text
Business Request
      │
      ▼
Micro Loop Engine
      │
      ├─ Select Skills
      ├─ Select Tools
      ├─ Select Memory
      ├─ Select Agents
      ├─ Configure Loop (entry, body, stop)
      │
      ▼
Deploy Runtime
```

## Components Selected at Assembly Time

| Component | What gets selected | Example |
|-----------|-------------------|---------|
| Skills | Reusable procedures for the task domain | `research-deep-dive`, `financial-score`, `meal-plan` |
| Tools | MCP servers and API connectors | GitHub MCP, Robinhood read-only, Supabase |
| Memory | Which memory stores to attach | `user_memory` table, conversation history, decision ledger |
| Agents | Specialist agents and their roles | Intake agent, fraud agent, planner agent |
| Loop config | Entry point, max iterations, budget, stop criteria | Cron daily, max 5 iterations, 50K token budget |

## How It Differs from Hardcoded Agents

| Hardcoded | Micro Loop Engine |
|-----------|-------------------|
| One agent, one config, one deployment | One engine, many configurations, many runtimes |
| Change = redeploy | Change = reconfigure |
| Skills baked into agent code | Skills selected from registry |
| Memory schema per agent | Shared memory with scoped access |
| Stop conditions per codebase | Stop conditions per loop config |

## Assembly Flow

```text
1. Receive business request (API call, admin config, or auto-detect)
2. Match request to a loop template (or compose from primitives)
3. Resolve skills → check skill registry for required capabilities
4. Resolve tools → check tool registry for required MCP servers / APIs
5. Resolve memory → attach relevant memory stores with correct scopes
6. Configure loop → set entry point, body steps, stop conditions, guardrails
7. Deploy runtime → spin up the assembled agent (container, serverless, or in-process)
8. Monitor → observe via traces, cost, iteration count, quality metrics
```

## Platform Analogy

This mirrors the monolith-to-microservices shift:

| Era | Unit | Reuse |
|-----|------|-------|
| Monolith | One app, one workflow | Copy-paste |
| Microservices | One service per domain | API contracts |
| AI Monolith | One agent per problem | None |
| Micro Loop Engine | One runtime, many configs | Skills, tools, memory, loops |

## Guardrails at the Engine Level

The engine enforces guardrails that individual agents can't override:

- **Global token budget** per organization per day
- **Tool allowlists** per agent role (read-only broker can't call trade endpoints)
- **Memory isolation** per user and per product
- **Loop caps** — no assembled agent can exceed platform-wide max iterations

## When to Use

- Platform serves 3+ distinct business problems
- Multiple agents share the same tools or memory stores
- Business needs change faster than engineering can redeploy
- Cost control requires centralized budget enforcement

## When NOT to Use

- Single-purpose product with one agent (just build the agent directly)
- Prototype or POC stage (premature abstraction)
- The component registry doesn't have enough reusable pieces yet

## Related Patterns

- [Loop Engineering Three-Layer](./loop-engineering-three-layer.md) — the architecture each assembled agent follows
- [Orchestrator + Trace Governance](./orchestrator-trace-governance.md) — how multi-agent routing works inside a loop
- [Worker-Cache Boundary](./worker-cache-boundary.md) — execution pattern reused across assembled agents
