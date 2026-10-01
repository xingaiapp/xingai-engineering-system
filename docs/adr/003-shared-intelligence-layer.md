# ADR-003: Shared Intelligence Layer — Evidence Runtime Across XingAI Sites

**Date:** 2026-10-01
**Status:** Accepted
**Author:** Xing @ XingAI
**Supersedes:** —
**Superseded by:** —
**Also available:** [中文](003-shared-intelligence-layer.zh.md)

## Context

XingAI products repeatedly invent the same spine:

```text
Internet → Evidence → Verification → Decision → Execution → Outcome → Learning
```

Pieces already exist in different repos:

| Stage / component | Existing home |
|-------------------|---------------|
| Evidence ingest + claim verify | `xingai-evidence-engine` (ADR-001 one engine, two products) |
| Source registry / scan pipeline | `xingai-founder` ADR-007; Opportunity Radar sources |
| Evidence + entity/claim tables | `xingai-founder` ADR-012 |
| Evidence contract (research → decision) | Invest AI ADR-055 |
| Decision rows + outcome fields | `patterns/decision-ledger-schema.md`; Decision Engine ADR-015/016 |
| Execution gates, permissions, audit of tool calls | ADR-002 + `xingai-agent-firewall`; Invest ADR-028 |
| Agent runs / traces | Founder `AgentRun`; POCs Decision Ledger + orchestrator-trace |
| Replay / paper execution trail | Invest AI ADR-037 paper trading ledger; InvestSim execution evidence |
| Outcome → learning | Decision Ledger `action_taken` / `outcome`; InvestSim feedback ADR-0020 |

Without a platform rule, the next product will rebuild Evidence Store, Claim Graph, Verification, Agent Logs, Audit, Replay, and Outcome Tracking again. That wastes time and makes a future cross-site “Decision History / Intelligence” view impossible.

What must stay true: XingAI already rejected a **central shared database** for decisions ([Decision Engine ADR-016](https://github.com/xingaiapp/xingai-invest-decision-engine/blob/main/docs/adr/016-cross-product-decision-ledger.md); [decision-ledger-schema](../../patterns/decision-ledger-schema.md)). Learn AI ADR-001 also says products share **patterns**, not a shared runtime dependency. This ADR must name the shared layer without undoing those boundaries.

## Decision

**Shared Intelligence Layer is a platform contract + selective engines — not a new mega-service and not a shared production database.**

Every XingAI site that turns internet/input into a recommendation or gated action MUST map its pipeline onto this stage model and **reuse** the shared component listed below instead of inventing a parallel one.

### Stage model (required vocabulary)

```text
Internet
   ↓
Evidence          — durable facts/citations with source refs
   ↓
Verification      — support / contradict / unreachable / human review
   ↓
Decision          — recommendation or gated allow/deny (ledger-shaped)
   ↓
Execution         — external effect only after fail-closed gates
   ↓
Outcome           — followed / ignored / modified / measured result
   ↓
Learning          — feed back into scores, prompts, gates, or research packs
```

Products may skip stages they do not need (e.g. Meal AI may have thin Evidence). They may not rename the spine or invent a second parallel spine for the same job.

### Shared components (do not rebuild per product)

| Component | What is shared | What stays product-local |
|-----------|----------------|--------------------------|
| **Evidence Store** | Shape + worker-writes-cache rule; prefer `xingai-evidence-engine` verify cache when claim/citation verification is the job | Product DB rows that cite evidence ids |
| **Source Registry** | Registry pattern (id, URL, trust tier, fetch policy) | Actual source lists per domain |
| **Claim Graph** | Claim → evidence → verdict edges (Evidence Engine / Founder EvidenceClaim) | Domain entities (tickers, meals, cities) |
| **Verification** | Verdict vocabulary + worker ownership of verify | Human overlay / review UI |
| **Agent Logs** | Run id, agent, model/provider, timestamps, status | Domain payload |
| **Tool Calls** | Tool name, args hash, result status, gate verdict | Domain adapters |
| **Permissions** | Least privilege + opt-in write tools (ADR-002) | Role matrices |
| **Audit Trail** | Append-only Decision / gate / review rows | Retention policy per product |
| **Replay** | Ability to re-run from stored evidence + inputs (no live refetch required for audit) | Domain simulators |
| **Outcome Tracking** | Decision Ledger `action_taken` / `outcome` | Product-specific metrics |

### Ownership map (extend, don't fork)

1. **Contracts & patterns** → this repo (`patterns/shared-intelligence-layer.md`, decision ledger, agent-execution-gate, worker-cache-boundary, human-overlay-cache).
2. **Claim / citation Evidence Runtime** → `xingai-evidence-engine` (reference engine). New products adopt via short product ADR + consume/export, not a third verify stack.
3. **Cross-product decision + outcome** → Decision Ledger schema; each product writes locally; unified UI reads per-product APIs (ADR-016).
4. **Execution permissions / tool audit** → ADR-002 + Agent Firewall (or domain gates that meet the same six requirements).
5. **Research fan-out** → Opportunity Radar ADR-008 (one research pack → many assets) sits **on top of** Verification/Decision outputs; it does not replace Evidence Runtime.

### Explicit non-goals (30–90 days)

- No new `xingai-shared-intelligence` production service required to ship product features.
- No single SQLite/Postgres that all `*.xingai.app` apps write into.
- No forcing Meal/Cook/Travel through full Evidence Engine if their risk surface only needs Decision Ledger + thin sources.
- No duplicating Evidence Engine inside Invest, Research, Founder, or Radar as a second claim-verify pipeline.

### Adoption rule

When a product needs a shared component for the first time:

1. Point at this ADR + the owning pattern/engine.
2. Write a short product ADR: which stages are in scope, which existing engine/schema is reused, what is product-local.
3. Prefer upgrade of the owning engine/schema over a new repo.

## Consequences

Positive:
- Reviewers can reject “we built our own evidence store / audit trail / claim graph” without a platform ADR citing this one.
- Cross-site history and learning become feasible via shared shapes, without coupling deploys.
- Evidence Engine, Decision Ledger, and Agent Firewall stop looking like three unrelated projects — they are layers of one spine.

Tradeoffs:
- Products must document stage coverage; thin products still name which stages they skip.
- Contract discipline is slower than copy-paste schemas; that friction is intentional.
- Full Replay + Learning loops will remain uneven until more products fill Outcome fields.

## Related

- [patterns/shared-intelligence-layer.md](../../patterns/shared-intelligence-layer.md)
- [patterns/decision-ledger-schema.md](../../patterns/decision-ledger-schema.md)
- [patterns/agent-execution-gate.md](../../patterns/agent-execution-gate.md)
- [patterns/worker-cache-boundary.md](../../patterns/worker-cache-boundary.md)
- [ADR-002 Agent Execution Safety](./002-agent-execution-safety.md)
- Evidence Engine ADR-001; Invest AI ADR-055 / ADR-037; Founder ADR-012; Decision Engine ADR-016; Opportunity Radar ADR-008
