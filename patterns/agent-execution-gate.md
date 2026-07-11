# Agent Execution Gate

Use this pattern when an agent or MCP tool can cause an **external effect**: run a shell command, place an order, write outside its workspace, send a notification, spend money. The gate sits between the agent's *intent* and the *effect*, and it — not the model — decides what proceeds.

Mandated by [ADR-002](../docs/adr/002-agent-execution-safety.md). Proven three times before it became a pattern: Invest AI ADR-028 (trade gates G1–G7), Polymarket AI ADR-003 (CLOB execution gates), Agent Firewall (general tool-call policy engine). Firewall ADR-004/005 extend the pattern with origin provenance and pin-vs-YAML policy discipline. `xingai-robinhood-mcp` ADR-001 is the first **MCP gateway proxy** interception point (vs. a harness hook) — and the first reference implementation to ship with most gates deliberately unwired: it fails closed on 4 of Invest AI's 7 gates by construction until cross-repo dependencies exist, rather than faking a pass.

## Core Rule

```text
agent intent (tool call / order / message)
      ↓
[1] interception point   — a place the agent cannot route around
      ↓
[2] deterministic policy — rules + weighted signals → allow | deny | review
      ↓   (optional) origin from turn-scoped taint when the surface reads untrusted content
[3] human approval       — review holds synchronously; timeout → deny
      ↓   deny+add-rule = instant pin + reviewed YAML suggestion (never live-edit policy files)
[4] ledger               — one Decision row per verdict (shared schema)
      ↓
effect executes (or never does)
```

The verdict at [2] must be **deterministic**: same input → same verdict, every fired rule listed. An LLM may contribute an advisory signal that raises scrutiny; it must never be able to authorize what rules deny — a judge that reads attacker-controlled content inherits the injection vulnerability it exists to stop.

When the agent reads repos, web pages, or inbound documents, add **turn-scoped provenance** (Agent Firewall ADR-004): snapshot a trusted baseline at session start, taint on untrusted reads, clear on the next human turn. Derive the origin signal in the engine — do not trust a caller-supplied field. Prefer turn scope over arbitrary time or call-count windows.

## Each Product Owns

- Choosing its interception point (harness hook, MCP gateway proxy, API gateway, a gate function before the broker call) and documenting what that point does and does not cover — the honest threat model
- Its domain signals and weights, in config not code (`policies/*.yaml`, following config-driven-parameters discipline)
- Its authority-scope declaration: acts freely / needs approval / never — the bounded-delegation contract
- Writing the Decision row, including human overrides (`action_taken: modified` is the highest-value tuning data)
- If it ships "deny + add rule": split **runtime pin** (reversible) from **durable YAML** (git-reviewed) — Agent Firewall ADR-005

## Defaults That Are Not Optional

- **Fail closed:** gate unreachable → block; approval timeout → deny
- **Write tools opt-in:** `*_ENABLED=true` never ships as default
- **Session-scoped approvals** expire with the session; permanent policy changes go through config review, like code
- **No live YAML mutation** from the gate service — pins are runtime state; suggestions queue human edits
- **Regression corpus as release gate:** known-bad intents must never be silently allowed, known-good workflow must never be blocked — run it on every policy change

## Common Mistakes

- Gating with a system-prompt instruction ("never run rm -rf") — that is a request, not a gate; 0din-class injection walks straight past it
- Async approval (fail the call, approve a retry later) — the agent treats the failure as an error and improvises around it; hold synchronously instead
- Audit-only ("we log everything") — by audit time the payload has run; logging is requirement [4], not a substitute for [2] and [3]
- Score thresholds that silently allow single meaningful signals — set the allow ceiling below your lightest signal that warrants a human look
- Building one central gate service for all products — each product gates its own surface with its own signals; what's shared is the pattern and the ledger schema, not a runtime dependency
- Whole-session taint after one web fetch — use turn-scoped clear (UserPromptSubmit / equivalent), not "tainted until logout"
- One-click rewrite of `policies/*.yaml` from the running service — collapses the review boundary the gate exists to protect
- Stubbing an unimplemented gate to return "pass" so the checklist looks complete — fail closed and name the specific unwired gate instead (`xingai-robinhood-mcp` ADR-001: 4 of 7 gates reject by construction until their cross-repo dependencies exist)

## Adoption Checklist (per product)

- [ ] Short ADR mapping the six ADR-002 requirements onto this product's execution surface
- [ ] Interception point implemented where the agent cannot route around it
- [ ] Policy in config with named signals and thresholds
- [ ] Approval flow with timeout-to-deny
- [ ] Decision rows written, including overrides
- [ ] Regression corpus in CI
- [ ] If reading untrusted content: turn-scoped provenance (or explicit "out of scope" in the threat model)
- [ ] If shipping deny+add-rule: pin table + suggestion queue, not live YAML edits

## Reference Implementations

- `xingai-agent-firewall` — general coding-agent tool calls (hook interception, YAML signals, approval queue, ledger, [ADR-004](https://github.com/xingaiapp/xingai-agent-firewall/blob/main/docs/adr/004-origin-provenance-tracking.md) provenance, [ADR-005](https://github.com/xingaiapp/xingai-agent-firewall/blob/main/docs/adr/005-deny-add-rule.md) pin + suggestion)
- `xingai-invest-ai` ADR-028 — domain gates for trade execution (G1–G7, phased rollout R0–R3)
- `xingai-polymarket-ai` ADR-002/003 — human-confirm boundary and live execution gates
- `xingai-robinhood-mcp` [ADR-001](https://github.com/xingaiapp/xingai-robinhood-mcp/blob/main/docs/adr/001-mcp-gateway-proxy.md) — MCP gateway proxy interception point (not a harness hook); implements Invest AI's G1/G6/G7 in code, G2–G5 fail-closed pending cross-repo wiring; tested only against a local mock upstream, never the real Robinhood endpoint
