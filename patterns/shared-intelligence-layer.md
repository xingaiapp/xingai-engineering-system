# Shared Intelligence Layer

Use this pattern when a XingAI product turns internet or user input into a recommendation, gated action, or research artifact — and you are tempted to invent a new evidence store, claim graph, audit log, or outcome table.

## Core Rule

All XingAI sites share **one stage vocabulary** and **one ownership map**. They do **not** share one production database or one required runtime service.

```text
Internet → Evidence → Verification → Decision → Execution → Outcome → Learning
```

Do not rebuild Evidence Store, Source Registry, Claim Graph, Verification, Agent Logs, Tool Calls, Permissions, Audit Trail, Replay, or Outcome Tracking as product-private inventions when a platform owner already exists.

## Stage Checklist

| Stage | Minimum bar | Skip only if… |
|-------|-------------|----------------|
| Evidence | Durable record with source ref or explicit “no source” | Pure UI/settings with no factual claim |
| Verification | Status other than “model said so” (even if `UNVERIFIED` is honest) | No factual claims leave the system |
| Decision | Ledger-shaped row when a human may act on the output | Output is never a recommendation |
| Execution | Fail-closed gate before external side effects | No tool/order/message/write outside sandbox |
| Outcome | Nullable `action_taken` / `outcome` fields exist | Product never learns from user follow-through |
| Learning | Documented path from outcome → score/prompt/gate/pack | Explicitly deferred in product ADR |

## Ownership Map

| Need | Own here | Not here |
|------|----------|----------|
| Claim / citation verify runtime | `xingai-evidence-engine` | Second verify stack inside Invest/Research/Founder |
| Decision + outcome shape | `patterns/decision-ledger-schema.md` | Central decision DB |
| Tool / agent execution safety | ADR-002 + `agent-execution-gate` / Agent Firewall | Prompt-only “be careful” |
| Worker vs API | `worker-cache-boundary.md` | Request-path verify or decide |
| Human review overlays | `human-overlay-cache.md` | Overwriting worker verify cache |
| Source lists | Source Registry **pattern**; lists stay in product | One global URL list for all domains |
| Research → many assets | Opportunity Radar ADR-008 | Replacing Evidence Runtime |

## Implementation Shape

1. Product ADR names which stages are in scope and which are skipped.
2. New tables map to shared field names where possible (`verificationStatus`, `source_ref`, ledger `outcome`).
3. Prefer calling or exporting from the owning engine over copying schemas.
4. Cross-product UI reads **per-product** APIs; never merges into a shared write store.

## Common Mistakes

- Building `xingai-*-evidence` as a fourth verify service because “our domain is special.”
- Shared Intelligence Layer interpreted as “one Fly app all products must call to ship.”
- Skipping Verification vocabulary and storing only LLM prose as “evidence.”
- Execution without Permissions / Audit (violates ADR-002).
- Outcome Tracking only in analytics events, never on the Decision row — Learning cannot close.

## Related

- Platform ADR: [003-shared-intelligence-layer.md](../docs/adr/003-shared-intelligence-layer.md)
- [decision-ledger-schema.md](./decision-ledger-schema.md)
- [agent-execution-gate.md](./agent-execution-gate.md)
- [worker-cache-boundary.md](./worker-cache-boundary.md)
- [human-overlay-cache.md](./human-overlay-cache.md)
