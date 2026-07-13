# XingAI MCP Boundaries

Use with [SKILL.md](SKILL.md). These rules override generic “cover every API endpoint” advice when they conflict.

---

## 1. Interception Point

Any side-effecting MCP tool call that can move money, change brokerage state, submit claims, or mutate external systems must pass through a documented interception point the agent cannot route around.

XingAI default: **MCP gateway proxy** (`xingai-robinhood-mcp` ADR-001) or equivalent policy layer in the MCP server (claims POC `policies.py` + scopes).

See `patterns/agent-execution-gate.md`.

---

## 2. Read-Only First

| Stage | Allowed | Forbidden |
|-------|---------|-----------|
| R0 | Real upstream read tools / shape check | place/cancel/submit |
| R1 | Sanitized overlay / monitor display | Browser calling write tools |
| R2 | Draft + human approve (ledger G1) | Upstream write without gates |
| R3 | Opt-in forwarding after mock drill | Unsupervised loops that skip G1 |

Readonly checkers refuse to run when trade/write enable flags are true.

---

## 3. Decision Cache Boundary

MCP tools and FastAPI-style handlers must **not** recompute investment recommendations, confidence, ranking, or risk budgets. They may:

- Read worker-generated cache fields
- Cite snapshot ids for G4/G5-style gates
- Render sanitized account/portfolio shapes

See `patterns/worker-cache-boundary.md` and Invest AI ADR-028 family.

---

## 4. Auth Models

| Pattern | When |
|---------|------|
| Upstream OAuth (vendor MCP) | Operator completes vendor auth; gateway/UI show `auth_required` states |
| OAuth 2.1 + PKCE + JWT (XingAI POC) | Claims MCP OAuth POC — real auth, not ADR-003 placeholder |
| Control-plane bearer | Private UI ↔ gateway HTTP (robinhood ADR-008); loopback default |

Never put bearer/OAuth secrets in tool results, chat, or git.

---

## 5. Two Walls (when both apply)

1. **OAuth scopes** — can the client call this tool at all?
2. **Domain policy** — is this claim amount / order size / account type allowed?

A valid token alone is not authorization for the business action (claims POC lesson).

---

## 6. Observability

- One ledger/decision row per gated write attempt (approve, deny, expire, forward/block reason).
- Mask PII and account identifiers in logs and tool payloads.
- Prefer structured errors with gate ids (`G1`, `G4`, …) over opaque failures.

---

## 7. Control Plane vs Tool Surface

Private operator UIs should call a **control-plane HTTP API** (summary, pending, approve/deny, readonly snapshot) that wraps ledger + readonly scripts — not embed MCP write clients in the browser.

Contract shape reference: `xingai-robinhood-mcp/docs/api/control-plane-v1.md`.

---

## 8. Language and Docs

- Match the repo: Python gateway → Python.
- Public/POC repos: EN + 中文 ADRs when the change is architectural; disclaimer for non-production claims.
- Design links for enterprise POCs: EN + 中文 (or TODO for missing ZH).
