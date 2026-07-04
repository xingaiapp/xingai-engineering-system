# Loop Engineering Three-Layer Architecture

Use this pattern when designing a production AI agent or AI-native system that needs to be more than a prompt wrapper.

Validated in: `xingai-invest-ai` (worker-cache + macro regime loop), `xingai-invest-decision-engine` (multi-timeframe scoring loop), `xingai-polymarket-ai` (scanner-to-confirm loop), `xingai-enterprise-ai-pocs` (supervisor + specialist agents).

## Core Rule

**Separate Context (what the model knows) from Harness (how work executes) from Loop (when work happens and stops).** Mixing these layers produces agents that can't be debugged, audited, or cost-controlled.

```text
┌──────────────────────────────┐
│ Layer 3: Loop Engineering    │
│ Entry point • Loop body •    │
│ Stop condition • Guardrails  │
└──────────────────────────────┘
┌──────────────────────────────┐
│ Layer 2: Harness Engineering │
│ Tools • Skills • Memory •    │
│ Multi-Agent • Permissions    │
└──────────────────────────────┘
┌──────────────────────────────┐
│ Layer 1: Context Engineering │
│ Prompt • RAG • User profile •│
│ Conversation • Runtime state │
└──────────────────────────────┘
```

## Layer 1: Context Engineering

Owns what the model sees before it starts reasoning.

- System prompt and examples
- User profile and preferences (see `personal-memory-engine` ADR)
- Retrieved knowledge (RAG)
- Tool results from prior steps
- Runtime state (current iteration, budget remaining)

**Test:** If you remove a context element and the model makes worse decisions, that element belongs in this layer.

## Layer 2: Harness Engineering

Owns how the model's decisions get executed.

- Tool registry and calling (MCP servers, APIs, databases)
- Skill selection (reusable procedures)
- Memory persistence (write-back from agent runs)
- Multi-agent collaboration (orchestrator + specialists)
- Structured output enforcement
- Permission and sandbox boundaries

**Test:** If you swap the model and the execution still works the same way, the harness is well-separated.

## Layer 3: Loop Engineering

Owns when work happens, what repeats, and when it stops.

Every production loop defines three things:

1. **Entry point** — user request, cron, webhook, GitHub event, Slack message
2. **Loop body** — Plan → Execute → Evaluate → Reflect
3. **Stop condition** — goal achieved, max iterations, budget exhausted, time limit, no progress

### Required Guardrails

| Guardrail | Example | Why |
|-----------|---------|-----|
| Max iterations | 5 cycles per task | Prevents infinite loops |
| Token budget | 100K tokens per run | Controls cost at harness level |
| No-progress detection | 2 stalled iterations → stop | Prevents burning tokens on stalled loops |
| Wall-clock timeout | 5 minutes max | Catches hung agents |
| Human approval gate | Before deploy, send, or trade | High-risk actions require escalation |

**Test:** If you remove the stop condition and the agent runs forever, your loop layer is missing.

## Anti-Patterns

| Anti-pattern | Fix |
|-------------|-----|
| Stop condition in the prompt ("stop when you're done") | Move to harness: enforce max iterations + budget programmatically |
| Tool permissions in the prompt ("don't call delete") | Move to harness: tool allowlist per agent role |
| Context packed into the harness config | Move to context layer: system prompt, RAG, user profile |
| Loop logic inside a single LLM call | Separate into explicit plan-execute-evaluate-reflect steps |

## When to Use

- Building any agent that runs more than one LLM call per task
- Designing a multi-agent system with an orchestrator
- Adding autonomy to an existing AI feature
- Evaluating whether an agent can run unsupervised

## XingAI Examples

| Product | Context | Harness | Loop |
|---------|---------|---------|------|
| Invest AI | Market data + user portfolio + macro regime | Worker + cache + decision core | Daily worker cycle: fetch → score → cache → notify |
| Decision Engine | Multi-timeframe price data + indicators | Read-only broker + pandas scoring | Score loop per symbol per timeframe |
| Polymarket AI | Market CLOB data + Kelly parameters | Scanner + Telegram notify | Scan → size → human confirm → execute |
| Enterprise POC | Claim documents + policy RAG | Supervisor + specialist agents | Intake → fraud → adjudicate → human approve |

## Related Patterns

- [Worker-Cache Boundary](./worker-cache-boundary.md) — harness-layer pattern for separating compute from reads
- [Orchestrator + Trace Governance](./orchestrator-trace-governance.md) — harness-layer pattern for multi-agent routing
- [Decision Ledger Schema](./decision-ledger-schema.md) — cross-layer pattern for recording agent decisions
