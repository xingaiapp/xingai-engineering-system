# ADR-002: Agent Execution Safety — the Sixth XingAI Global Principle

**Date:** 2026-07-05
**Status:** Accepted
**Author:** Xing @ XingAI
**Supersedes:** —
**Superseded by:** —
**Also available:** [中文](002-agent-execution-safety.zh.md)

## Context

The five XingAI global principles (worker architecture, i18n, theme, SEO, AEO) govern how products are *built*. None governs what an *agent acting inside a product* may execute. Three developments make that gap unacceptable:

1. Mozilla 0din demonstrated that a clean-looking repo can prompt-inject Claude Code into running malicious commands — the injection arrives through content the agent is supposed to read, so model-level guardrails cannot close it.
2. Microsoft's "To Copilot and Beyond" research found developers want **bounded delegation**: agents doing assembly work within explicit authority, not open-ended autonomy.
3. XingAI has independently reinvented execution gating three times — Invest AI ADR-028 (G1–G7 trade gates), Polymarket AI ADR-003 (live CLOB execution gates), and Agent Firewall ADR-001..005 (policy engine, turn-scoped provenance, pin + YAML suggestion). Three domains, one shared standard.

## Decision

**Agent execution safety becomes the sixth global principle.** Any XingAI product where an agent (or MCP tool) can cause an external effect — execute a command, place an order, write outside its sandbox, send a message, spend money — MUST apply the [agent-execution-gate pattern](../../patterns/agent-execution-gate.md):

1. **Least privilege by default** — read tools ship first; write/execute tools are gated behind explicit enablement that never defaults on (`*_ENABLED=true` is always opt-in).
2. **Deterministic gate, promptable advisor** — the allow/deny decision comes from rules that attacker-controlled content cannot rewrite. An LLM may *advise* (raise scrutiny), never *authorize*.
3. **Authority scope declared** — each agent surface documents what it may do without asking, what needs approval, and what it must never do (the bounded-delegation contract).
4. **Fail closed end-to-end** — gate unreachable → block; human unreachable → block (timeout resolves to deny).
5. **Every verdict in the ledger** — one Decision row per gated action, shared schema (`patterns/decision-ledger-schema.md`), including human overrides.
6. **Honest threat model** — each implementation states what it does and does not stop (e.g. the firewall stops a tricked agent, not a malicious local user).

Reference implementations: `xingai-agent-firewall` (general tool calls), Invest AI ADR-028 (domain-specific trade gates). New products adopt by writing their own short ADR mapping these six requirements onto their surface — same adoption mechanic as the Decision Ledger.

## Consequences

Positive:
- The fourth product to need gating copies a standard instead of reinventing one; reviewers can reject ungated write tools by citing this ADR.
- The bounded-delegation contract (point 3) becomes writable documentation, which is what enterprise buyers ask for.

Tradeoffs:
- Adds a required ADR + gate wiring to any product that grows an execution surface — deliberate friction, applied exactly where mistakes are irreversible.
- Six requirements are a floor, not a ceiling; domain-specific gates (Invest's G1–G7) remain the product's own responsibility.

## Related

- [patterns/agent-execution-gate.md](../../patterns/agent-execution-gate.md)
- [patterns/decision-ledger-schema.md](../../patterns/decision-ledger-schema.md)
- xingai-agent-firewall ADR-001..005 (interception, scoring, approval, provenance, deny+add-rule); xingai-invest-ai ADR-028; xingai-polymarket-ai ADR-002/003
- Tech blog: [turn-scoped taint](https://github.com/xingaiapp/xingai-tech-blog/blob/main/posts/2026-07-11-agent-firewall-origin-provenance-adr-004.md), [deny + add rule](https://github.com/xingaiapp/xingai-tech-blog/blob/main/posts/2026-07-11-agent-firewall-deny-add-rule-adr-005.md)
