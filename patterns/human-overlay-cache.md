# Human Overlay Cache

Use this when a worker-first app (see `worker-cache-boundary.md`) needs
**human review or edits** on top of computed results — accept / reject /
edit / approve — without putting verification or AI work in the API.

Validated by: `xingai-evidence-engine` ADR-009 (`v1:review:`, `v1:skill:`).

## Core Rule

Keep human decisions in **separate cache keys** from worker payloads.
Never mutate the verifier / worker record in place to store a review.

```text
Worker writes   →  v1:verify:{id}     (machine verdict)
Human writes    →  v1:review:{id}     (accept / reject / edit)
GET merge       →  read both, overlay onto response
Re-run worker   →  overwrites verify; review key survives
```

## Allowed API Writes

| Allowed | Not allowed |
|---------|-------------|
| Review / correction overlays | URL fetch, LLM, scoring |
| Named skill / config approve & rollback | Auto-promoting approved skills into code |
| Auth, rate limits, transport metadata | Changing gated metrics on write |

Public demos that ship as static snapshots stay read-only (no overlay POST).

## Why It Works

- Re-verify does not wipe human work.
- Principle 1 stays intact: compute stays in the worker.
- Audit: overlay `at` / `approved_by` fields are separate from machine notes.

## Common Mistakes

- PATCH the verify cache JSON with `review=accepted` — next CLI run discards it.
- Hide Accept/Reject on a static demo that cannot write — only show when live API answered.
- Treat approve as an automatic merge into extraction rules — keep that a human PR.
- Mix overlay fields into EEE metric denominators — reviews are product state, not eval.

## Reference Keys (Evidence Engine)

| Key | Writer |
|-----|--------|
| `v1:verify:{project}` | worker |
| `v1:review:{project}` | API / CLI |
| `v1:skill:{id}` | API / CLI |
| `v1:run:{id}` | worker |
| `v1:eval:{case}` | worker |
