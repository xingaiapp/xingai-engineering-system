# Agent Execution Gate

Use this pattern when an agent or MCP tool can cause an **external effect**: run a shell command, place an order, write outside its workspace, send a notification, spend money. The gate sits between the agent's *intent* and the *effect*, and it — not the model — decides what proceeds.

Mandated by [ADR-002](../docs/adr/002-agent-execution-safety.md). Proven three times before it became a pattern: Invest AI ADR-028 (trade gates G1–G7), Polymarket AI ADR-003 (CLOB execution gates), Agent Firewall (general tool-call policy engine).

## Core Rule

```text
agent intent (tool call / order / message)
      ↓
[1] interception point   — a place the agent cannot route around
      ↓
[2] deterministic policy — rules + weighted signals → allow | deny | review
      ↓
[3] human approval       — review holds synchronously; timeout → deny
      ↓
[4] ledger               — one Decision row per verdict (shared schema)
      ↓
effect executes (or never does)
```

The verdict at [2] must be **deterministic**: same input → same verdict, every fired rule listed. An LLM may contribute an advisory signal that raises scrutiny; it must never be able to authorize what rules deny — a judge that reads attacker-controlled content inherits the injection vulnerability it exists to stop.

## Each Product Owns

- Choosing its interception point (harness hook, API gateway, a gate function before the broker call) and documenting what that point does and does not cover — the honest threat model
- Its domain signals and weights, in config not code (`policies/*.yaml`, following config-driven-parameters discipline)
- Its authority-scope declaration: acts freely / needs approval / never — the bounded-delegation contract
- Writing the Decision row, including human overrides (`action_taken: modified` is the highest-value tuning data)

## Defaults That Are Not Optional

- **Fail closed:** gate unreachable → block; approval timeout → deny
- **Write tools opt-in:** `*_ENABLED=true` never ships as default
- **Session-scoped approvals** expire with the session; permanent policy changes go through config review, like code
- **Regression corpus as release gate:** known-bad intents must never be silently allowed, known-good workflow must never be blocked — run it on every policy change

## Common Mistakes

- Gating with a system-prompt instruction ("never run rm -rf") — that is a request, not a gate; 0din-class injection walks straight past it
- Async approval (fail the call, approve a retry later) — the agent treats the failure as an error and improvises around it; hold synchronously instead
- Audit-only ("we log everything") — by audit time the payload has run; logging is requirement [4], not a substitute for [2] and [3]
- Score thresholds that silently allow single meaningful signals — set the allow ceiling below your lightest signal that warrants a human look
- Building one central gate service for all products — each product gates its own surface with its own signals; what's shared is the pattern and the ledger schema, not a runtime dependency

## Adoption Checklist (per product)

- [ ] Short ADR mapping the six ADR-002 requirements onto this product's execution surface
- [ ] Interception point implemented where the agent cannot route around it
- [ ] Policy in config with named signals and thresholds
- [ ] Approval flow with timeout-to-deny
- [ ] Decision rows written, including overrides
- [ ] Regression corpus in CI

## Reference Implementations

- `xingai-agent-firewall` — general coding-agent tool calls (hook interception, YAML signals, approval queue, ledger)
- `xingai-invest-ai` ADR-028 — domain gates for trade execution (G1–G7, phased rollout R0–R3)
- `xingai-polymarket-ai` ADR-002/003 — human-confirm boundary and live execution gates
