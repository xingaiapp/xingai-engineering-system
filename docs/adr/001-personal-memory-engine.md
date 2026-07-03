# ADR-001: Personal Memory Engine — Cross-Product User Context

**Date:** 2026-07-01
**Status:** Accepted
**Author:** Xing @ XingAI
**Supersedes:** —
**Superseded by:** —
**Also available:** [中文](001-personal-memory-engine.zh.md)

## Context

XingAI products (Invest AI, Meal AI, SAT AI, Decision Engine, Opportunity Radar) each maintain isolated user profiles. A user who sets "I have fatty liver" in Meal AI and "I'm 55 years old, conservative risk tolerance" in Invest AI cannot benefit from that context being available across products. Each product starts from scratch.

This creates three problems:

1. **Repetition** — user must re-enter the same personal context in every product.
2. **Missed cross-domain insight** — "conservative investor + fatty liver + 55 years old" is a coherent health-financial profile that could improve both investment risk recommendations and meal plans; neither product sees the full picture.
3. **No foundation for a Decision OS** — the XingAI product vision (Personal Decision Operating System) requires a memory layer that persists context across all recommendation domains.

## Decision

### What the Personal Memory Engine stores

```
UserMemory
├── user_id                string   — Supabase auth user id
├── age                    int?
├── goals                  string[] — e.g. ["retire at 60", "lose 20 lbs", "daughter to med school"]
├── constraints            string[] — e.g. ["no alcohol", "low sodium diet", "conservative investor"]
├── health_conditions      string[] — e.g. ["fatty_liver", "high_blood_pressure"]
├── financial_profile      object   — { risk_tolerance, investment_horizon, monthly_savings, net_worth_range }
├── family_members         object[] — [{ role, age, health_conditions[], goals[] }]
├── preferences            object   — product-keyed { meal: {...}, invest: {...}, sat: {...} }
├── decision_style         enum?    — "analytical" | "intuitive" | "collaborative"
├── language               enum     — "en" | "zh" | "ko"
├── updated_at             datetime
└── version                int      — optimistic concurrency
```

### Where it lives

`UserMemory` is stored in **Supabase** (PostgreSQL), one row per user, in a new `user_memory` table. This is the only XingAI cross-product resource that uses a shared database — justified because:

- Auth is already in Supabase; this is an extension of the auth user, not a new service.
- Memory is user-scoped; there is no cross-user query (no JOIN across users in the hot path).
- The alternative (each product polls every other product's memory endpoint) creates an O(N²) dependency graph as products grow.

### Read path

Each product's FastAPI layer reads `user_memory` at request time for the user's `user_id`. This is a fast primary-key lookup (< 5ms). The result is injected into the LLM system prompt by the worker — not cached separately, since memory changes are rare and the cost of a stale prompt is high.

### Write path

Memory is written by:
1. **Explicit user input** — settings / profile pages in any product.
2. **Worker inference** — when a worker detects a new constraint from a user's decision history (e.g., user ignores every high-sodium meal plan → worker adds `"low_sodium"` to constraints after 3 consecutive ignores). Worker-inferred updates go through a `pending_memory_update` queue; a human-visible confirmation is shown before writing.

No product writes directly to another product's tables. Memory writes go to the shared `user_memory` table via a thin `memory-service` FastAPI on Fly.io.

### What stays product-local

- Domain-specific recommendation history (Invest AI daily briefs, Meal AI plans)
- Decision Ledger rows ([decision-ledger-schema.md](../patterns/decision-ledger-schema.md)) — these stay per-product
- Detailed financial positions, meal logs — product-specific internals

The rule: **if it's useful to another product, it belongs in `user_memory`; if it only matters within one product, it stays local.**

## Consequences

Positive:
- A user's context follows them across XingAI products without re-entry.
- The LLM system prompt for every product gets richer automatically as the user's profile grows.
- Enables cross-domain recommendations (e.g., "Given your conservative financial profile and fatty liver, avoid stress-trading volatile stocks — here's why both Invest AI and Meal AI agree").

Tradeoffs:
- Shared database is the exception to the per-product boundary rule; justified by the auth colocation and primary-key access pattern, but must not expand into cross-user queries.
- Worker-inferred memory updates require a confirmation step — adds UX complexity but is necessary to prevent silent profile mutations.
- Privacy surface grows: `user_memory` contains sensitive health and financial data; row-level security in Supabase is mandatory (user can only read/write their own row).

## Privacy and security requirements

- Supabase row-level security (RLS) policy: `user_id = auth.uid()` on all operations.
- `health_conditions` and `financial_profile` are never logged in plaintext in application logs.
- User can view, edit, and delete all `user_memory` content from a "My Profile" page in any XingAI product.
- GDPR/CCPA: `DELETE /api/memory` hard-deletes the row and triggers cascade delete in each product's decision ledger.

## Alternatives considered

- **Each product stores its own memory slice** — rejected; creates O(N²) polling graph and requires the user to update context N times.
- **Central memory service with its own database** — deferred to v2; Supabase colocation is sufficient at current scale and avoids a new deployment.
- **LLM-inferred memory only (no explicit profile)** — rejected; implicit inference is opaque to the user and difficult to correct.

## Related

- [patterns/decision-ledger-schema.md](../patterns/decision-ledger-schema.md)
- [patterns/worker-cache-boundary.md](../patterns/worker-cache-boundary.md)
- [Invest AI ADR-005: Legal Disclaimers](https://github.com/xingaiapp/xingai-invest-ai/blob/main/docs/adr/005-legal-disclaimers-v1.md)
