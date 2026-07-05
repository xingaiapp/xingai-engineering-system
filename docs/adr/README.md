# XingAI Engineering System — Architecture Decision Records

Platform-level decisions that apply across all XingAI products.

| ADR | Title | Status |
|-----|-------|--------|
| [001](./001-personal-memory-engine.md) | Personal Memory Engine — Cross-Product User Context | Accepted |
| [002](./002-agent-execution-safety.md) | Agent Execution Safety — the Sixth Global Principle | Accepted |

## How to add a platform ADR

Platform ADRs belong here when the decision:
- Affects ≥2 XingAI products
- Defines a shared schema, service, or pattern
- Cannot be owned by a single product repo

Product-specific decisions go in that product's own `docs/adr/` directory.
