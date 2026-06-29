# Decision Ledger Schema

Use this pattern when a product makes a recommendation a human will act on outside the system (buy/sell a stock, eat a meal, study a topic, approve a trade) and you want that decision to be queryable, explainable, and improvable later — across XingAI products, not just within one.

## Core Rule

Every product that produces a recommendation writes one `Decision` row to its **own** database, in a **shared minimal shape**. No central database, no shared service, no new repo. The schema is the contract; storage stays local to each product.

```text
Decision
├── id                 string   — product-local primary key (cuid/uuid)
├── product            enum    — "invest-ai" | "invest-decision-engine" | "meal-ai" | "sat-ai" | "founder" | ...
├── domain              string  — free-text sub-category, e.g. "rebalance", "meal-plan", "sat-topic"
├── question            string  — what the user asked or what triggered this
├── recommendation      string  — the system's suggested action
├── reasoning           string[] — bullet list, human-readable, matches what the user saw
├── confidence          float    — 0.0–1.0, calibrated meaning defined per-product (see Common Mistakes)
├── alternatives        string[] — other options considered, optional
├── risks               string[] — known risks/caveats, optional
├── action_taken        enum?   — "followed" | "ignored" | "modified" | null (unknown/pending)
├── outcome             string? — filled in later, free text or structured per-product
├── outcome_recorded_at  datetime?
├── created_at          datetime
└── source_ref          string? — pointer back to the product's own detailed record (e.g. opportunity id, score-export id)
```

This is intentionally **thin**. Each product keeps its own rich, domain-specific tables (e.g. `daily_scores.v1.json` in Invest Decision Engine, `Opportunity` in Founder) and writes one row here that summarizes the decision in a shape any other XingAI surface can read without understanding that product's internals.

## Each Product Owns

- Generating the recommendation (unchanged — this pattern doesn't touch how decisions get made)
- Writing one `Decision` row when a recommendation is shown to the user
- Updating `action_taken` / `outcome` later if it ever gets a signal of what happened (many products won't, and that's fine — `outcome` staying null is a valid, common state, not a bug)
- Mapping its own enums/fields into this shape — the product does the translation, the shared schema does not grow product-specific columns

## Cross-Product Surface Owns (when/if built)

- Reading `Decision` rows from each product's local store (no shared DB — read via each product's own export/API, same boundary discipline as [worker-cache-boundary.md](./worker-cache-boundary.md))
- Rendering a unified "decision history" view across products
- Computing aggregate stats (e.g. "How many recommendations did I follow this month?") — this is the only place that needs cross-product visibility, and it's additive, not a prerequisite

## Why It Works

- No big-bang migration: any product can adopt this by adding one new table and one write call, without touching its existing logic or rewriting its stack.
- Confidence calibration stays per-product (Invest AI's "confidence" and a meal plan's "confidence" are not the same kind of number) — the shared schema doesn't pretend otherwise.
- A cross-product decision history becomes possible later without requiring it to exist first. The schema is useful even with zero products feeding a unified UI — it's just better-shaped logging until then.
- Matches the existing human-in-the-loop boundary already established in Invest Decision Engine ([ADR-003](https://github.com/xingaiapp/xingai-invest-decision-engine/blob/main/docs/adr/003-human-in-the-loop.md)) and Invest AI ([ADR-015](https://github.com/xingaiapp/xingai-invest-ai/blob/main/docs/adr/015-v4-agentic-platform.md)): this schema records what a human decided to do, it never triggers an action itself.

## Common Mistakes

- Treating `confidence` as comparable across products without saying so — a 0.8 in a meal plan and a 0.8 in a stock pick mean different things; don't build a cross-product leaderboard on raw confidence values without normalizing first.
- Building the central database before any product has adopted the schema — adopt in one product, prove the shape is right, then add a second.
- Letting `recommendation`/`reasoning` drift from what the user actually saw in the product UI — the ledger should be a faithful record, not a re-summary written after the fact.
- Using this pattern to justify rewriting a product's existing stack (see `product-upgrade-rule.md`) — adopting the ledger is an additive integration, not a reason to migrate frameworks.

## Adoption Checklist (per product)

- [ ] Add a `Decision` table (or equivalent) matching the shape above, in the product's own existing database
- [ ] Write one row per recommendation shown to a user, at the point the recommendation is generated
- [ ] Document the product-specific `domain` values and confidence semantics in that product's own ADR
- [ ] Leave `action_taken`/`outcome` null until/unless the product has a real signal — do not fabricate outcomes
- [ ] No new service, no new repo, no shared database — this lives inside the adopting product

## Related

- [worker-cache-boundary.md](./worker-cache-boundary.md) — same "compute locally, expose a thin read contract" discipline
- [product-upgrade-rule.md](./product-upgrade-rule.md) — why this isn't a rewrite trigger
- Invest Decision Engine [ADR-003: Human-in-the-loop](https://github.com/xingaiapp/xingai-invest-decision-engine/blob/main/docs/adr/003-human-in-the-loop.md)
- Invest Decision Engine [ADR-011: Daily score export contract](https://github.com/xingaiapp/xingai-invest-decision-engine/blob/main/docs/adr/011-score-export-contract.md) — an existing example of a thin, versioned cross-repo contract this pattern follows
- Invest AI [ADR-015: V4 Agentic Platform boundary](https://github.com/xingaiapp/xingai-invest-ai/blob/main/docs/adr/015-v4-agentic-platform.md)
