---
name: xingai-mcp-builder
description: >-
  Builds or extends XingAI MCP servers and gateways (Python-first) with
  read/write separation, fail-closed gates, sanitized outputs, and mock-before-live
  drills. Use when creating MCP tools, FastMCP/Python MCP SDK servers, Robinhood
  or claims MCP gateways, control-plane APIs for MCP UIs, or when the user mentions
  MCP builder, tool annotations, OAuth/PKCE MCP, or agent execution gates.
---

# XingAI MCP Builder

Enterprise fork of generic “MCP server builder” skills. Optimized for **XingAI** products and POCs — not a greenfield TypeScript-first tutorial pasted as-is.

**Default stack:** Python (MCP SDK / FastMCP / FastAPI gateway). Use TypeScript only when the target repo is already TS.

**Pair with:**

- Skill `enterprise-coding-behavior` (Think / Simplicity / Surgical / Goal-driven)
- Pattern `patterns/agent-execution-gate.md`
- Pattern `patterns/worker-cache-boundary.md` (decisions stay in worker; request path does not recompute)
- Refs: [xingai-boundaries.md](xingai-boundaries.md) · [checklist.md](checklist.md) · [eval-lite.md](eval-lite.md)

**Reference implementations:**

| Repo | Role |
|------|------|
| `xingai-robinhood-mcp` | Gateway proxy, G1–G7, readonly check, mock drill, control-plane contract ADR-008 |
| `xingai-enterprise-ai-pocs/pocs/claims-mcp-oauth-poc` | Real OAuth 2.1 + PKCE + two-wall auth (scopes + policy) |
| `xingai-enterprise-ai-design` | MCP-in-production articles + OAuth/PKCE lab guides |

---

## When To Use Which Path

| Situation | Path |
|-----------|------|
| Add/fix one tool or gate in an existing XingAI MCP repo | **Surgical path** (below) |
| New MCP server / new gateway / new write surface | **Full path** (phases 1–4) |
| UI that only displays MCP state | Do **not** put write tools in the browser; use control-plane HTTP (ADR-008 style) + skill stops at contract |

Always load `enterprise-coding-behavior` first. Never invent tool names, env vars, or upstream APIs.

---

## Surgical Path (default for XingAI)

1. Read repo ADRs + existing gateway/server modules.
2. State in-scope / out-of-scope (especially: no new write path around the gate).
3. Prefer extending the **existing interception point** (gateway proxy) over a second client that calls upstream writes.
4. Implement smallest diff; match naming and ledger/audit patterns.
5. Tests: unit for sanitize/mask/fail-closed; mock drill if forwarding semantics change.
6. Docs: ADR or README version notes if operational/architectural.

Stop. Do not run the full greenfield curriculum unless the user asked for a new server.

---

## Full Path (new MCP surface)

### Phase 1 — Plan (XingAI-first)

1. **Classify tools**
   - **Read-only:** list/get/search/shape-check — default allow in lab; still sanitize.
   - **Side-effect:** place/cancel/submit/pay/delete — must pass execution gates; opt-in enable flag; human approval for irreversible actions.
2. **Choose architecture**
   - Product write path → **gateway proxy** in front of upstream MCP (see robinhood ADR-001).
   - Teaching / domain POC → Auth Server + MCP Server + Client (claims OAuth POC pattern).
   - Do not put Invest-style **decision computation** inside MCP request handlers; cite worker cache.
3. **Protocol refresh (only if needed)**
   - Sitemap: `https://modelcontextprotocol.io/sitemap.xml`
   - Fetch pages with `.md` suffix. Prefer current SDK README over blog posts.
4. **Output a short plan** before coding: tools list, read vs write, auth, gate map, success checks.

Details: [xingai-boundaries.md](xingai-boundaries.md)

### Phase 2 — Implement

**Project habits**

- Python modules: `auth` / `tools` / `policies` / `ledger` (or match the repo).
- Zod/Pydantic (or equivalents) for inputs; explicit output shapes.
- Tool names: consistent prefix + verb (`rh_get_portfolio`, `claims_review_decision`).
- Annotations: `readOnlyHint`, `destructiveHint`, `idempotentHint`, `openWorldHint` — set honestly.
- Errors: actionable (“auth required”, “gate G4 missing citation”) — not raw stack traces to the model.
- Pagination / limits on list tools; truncate large payloads.

**XingAI hard rules**

- Mask account ids / numbers in tool results and logs.
- Never return OAuth tokens, refresh tokens, or session secrets in tool output.
- Write tools refuse when `*_TRADE_ENABLED` / equivalent is unset (fail closed).
- Unwired gates **deny**, they do not soft-pass.
- Readonly checkers must not import write handlers (robinhood ADR-007 pattern).

### Phase 3 — Verify

- `pytest` (or repo test command) for sanitize, scope, policy, gate fail-closed.
- Local **mock upstream / mock drill** before any live write forwarding.
- Real upstream: **read-only shape check first**; document 401/auth states as product states.
- MCP Inspector optional for greenfield; for XingAI gateways prefer scripted drills + unit tests.

### Phase 4 — Eval (lightweight)

For new tool surfaces that agents will call: add a small read-only eval set (5–10 questions) per [eval-lite.md](eval-lite.md). Skip full eval XML when the change is a single gated write path with deterministic tests.

---

## Anti-Patterns

| Don't | Do |
|-------|----|
| TypeScript-by-default on a Python gateway repo | Match the repo language |
| Second write path that bypasses the gateway | One interception point |
| “Auto-trade” tools without G1 human confirm | Draft → approve → gated forward |
| Returning full account numbers “for debugging” | Mask; use ledger ids |
| Soft-pass unwired gates | Fail closed |
| Decision/ranking/confidence computed in MCP or UI | Worker/cache owns decisions |
| Claiming enterprise-ready POC | Name gaps; keep disclaimer |

---

## Done Checklist

Copy and track:

```text
MCP change:
- [ ] Read vs write tools classified
- [ ] Existing ADR / gateway pattern followed
- [ ] Sanitize / mask verified
- [ ] Fail-closed on unwired or disabled write mode
- [ ] Tests or mock drill green
- [ ] README/ADR/version notes if operational
- [ ] No secrets in output or git
```

Full security/ops list: [checklist.md](checklist.md)

---

## Attribution

Workflow structure inspired by community MCP builder skills (protocol research → implement → test → eval). XingAI boundaries, Python-first default, gateway/gate rules, and surgical path are XingAI-specific.
