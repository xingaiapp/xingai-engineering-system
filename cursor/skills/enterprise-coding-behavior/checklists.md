# Enterprise Checklists

Use with [SKILL.md](SKILL.md). Apply only the rows that match the change. Skip with an explicit "N/A — reason" rather than silent omission.

---

## Production Mindset

- [ ] Error paths return explicit, safe failures (no bare `except` / swallowed errors)
- [ ] Timeouts are bounded on external calls
- [ ] Retries are idempotent or capped
- [ ] Config via env; validated at startup when the repo has that pattern
- [ ] No secrets, tokens, or private paths in code or commits
- [ ] Logging is structured where the repo already uses it; no PII / tokens in logs
- [ ] Metrics or traces touched only if this surface already exposes them — do not invent a parallel stack
- [ ] README / ADR / version notes updated when user-visible, operational, or architectural

---

## Security

- [ ] Authn/authz required for sensitive routes/tools
- [ ] Input validated (Zod / Pydantic / equivalent)
- [ ] Least privilege for tokens and MCP scopes
- [ ] No new CORS `*` on credentialed APIs
- [ ] Rate limits considered for expensive or agent-triggered endpoints
- [ ] Dependency changes scanned when adding packages
- [ ] Human-in-the-loop preserved for irreversible agent actions (trade, pay, delete, submit)

---

## Performance

- [ ] No obvious N+1 or unbounded list processing on hot paths
- [ ] Cache/read path used when the product already has a worker-cache boundary
- [ ] LLM calls not added to request handlers that should only read cache
- [ ] Large payloads paginated or truncated for UI
- [ ] Background/worker work stays off the interactive request path

---

## Architecture Consistency

- [ ] Existing ADR / pattern read
- [ ] No second implementation style for the same concern
- [ ] Naming and folders match neighbors
- [ ] Product upgrade rule respected (inherit prior UX/flow; no fake V-labels in UI)
- [ ] Invest AI: decisions stay in worker/core; FastAPI is read/transport only
- [ ] Agents: execution goes through gates / gateway; fail closed if unwired

---

## MCP Compatibility

- [ ] Tools called only through the approved gateway or documented client
- [ ] Scopes match least privilege (read vs write separated)
- [ ] Write/side-effect tools require explicit enablement + human approval where product policy says so
- [ ] Account identifiers and tokens masked in UI/logs
- [ ] Audit / ledger / trace updated if the product has one
- [ ] Mock drill or read-only check preferred before live forwarding

---

## Documentation

- [ ] User-facing copy through i18n (en / zh / ko) when UI changes
- [ ] POC: Related Design Docs EN + 中文 (or TODO for missing ZH)
- [ ] Public repo: disclaimer present; no false "production-ready"
- [ ] `llms.txt` / SEO only if shipping a public product route change

---

## Reviewer Quick Pass

Severity: Critical / Should fix / Nice

1. Does every hunk map to the request?
2. Any boundary violation (cache, MCP, auth)?
3. Any over-engineering or drive-by edit?
4. Was verification actually run?
5. Are production/security deferrals explicit for POCs?
