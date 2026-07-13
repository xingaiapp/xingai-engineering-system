# XingAI MCP Checklist

Apply rows that match the change. Mark N/A with a reason.

## Design

- [ ] Tools split into read-only vs side-effect
- [ ] Naming uses a consistent prefix + verb
- [ ] Descriptions are short; pagination/limits defined for lists
- [ ] Annotations (`readOnlyHint`, `destructiveHint`, …) match real behavior
- [ ] No second write path around the gateway/policy layer

## Security

- [ ] Account ids / numbers masked in outputs
- [ ] No tokens/secrets in tool results, logs, or fixtures committed to git
- [ ] Write path opt-in flag defaults off
- [ ] Unwired gates fail closed
- [ ] Human approval for irreversible actions (G1 or product equivalent)
- [ ] Input validation on tool args (Pydantic/Zod/equivalent)
- [ ] Scope check and domain policy both enforced when both exist

## Runtime

- [ ] Timeouts on upstream calls
- [ ] Actionable errors for auth / gate / policy failures
- [ ] Ledger or audit row for gated writes
- [ ] Readonly path does not import write handlers

## Verify

- [ ] Unit tests for sanitize / deny / policy
- [ ] Mock drill if forwarding semantics changed
- [ ] Live readonly check preferred before live write enablement
- [ ] README / ADR / version notes if operational or architectural

## UI consumers

- [ ] Browser does not call upstream write tools
- [ ] Copy says draft / pending / not auto-trade where applicable
- [ ] Control-plane or BFF used for approve/deny and snapshots
