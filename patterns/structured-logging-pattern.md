# Structured Logging Pattern

Use this pattern to add production-grade observability to XingAI Next.js and FastAPI apps. POC-level `console.log` is not enough for production.

Validated in: `xingai-invest-ai` (worker logging), `xingai-enterprise-ai-pocs` (trace pipeline).

## Core Rule

**Every server-side log must be a JSON object with a consistent schema.** Free-form strings cannot be filtered, alerted on, or aggregated.

```json
{
  "level": "info",
  "timestamp": "2026-06-14T10:23:45.123Z",
  "service": "xingai-invest-ai",
  "request_id": "req_abc123",
  "event": "worker.cache_miss",
  "duration_ms": 1240,
  "user_id": null,
  "details": {}
}
```

---

## Standard Log Schema

| Field | Type | Required | Notes |
|---|---|---|---|
| `level` | `debug\|info\|warn\|error` | ✅ | Never use `fatal` directly — use `error` + alert |
| `timestamp` | ISO 8601 string | ✅ | Server-side UTC |
| `service` | string | ✅ | Repo/product name |
| `request_id` | string | ✅ when in request context | UUID or nanoid |
| `event` | string | ✅ | `domain.action` format |
| `duration_ms` | number | when timing | Round to integer |
| `user_id` | string \| null | when authed | Anonymized ID, never email |
| `details` | object | when needed | Extra context — never PII |

---

## Next.js — Structured Logging

Install `pino` (fastest Node.js logger, used by Fastify, Vercel internally):

```bash
npm install pino pino-pretty
```

```ts
// lib/logger.ts
import pino from 'pino';

export const logger = pino({
  level: process.env.LOG_LEVEL ?? 'info',
  base: { service: process.env.NEXT_PUBLIC_APP_NAME ?? 'xingai-app' },
  ...(process.env.NODE_ENV === 'development' && {
    transport: { target: 'pino-pretty', options: { colorize: true } },
  }),
});

export function withRequestId(requestId: string) {
  return logger.child({ request_id: requestId });
}
```

```ts
// Usage in API route
import { logger, withRequestId } from '@/lib/logger';
import { nanoid } from 'nanoid';

export async function POST(req: Request) {
  const requestId = nanoid();
  const log = withRequestId(requestId);

  log.info({ event: 'api.analyze.start' });

  const start = Date.now();
  try {
    const result = await runAnalysis(input);
    log.info({ event: 'api.analyze.complete', duration_ms: Date.now() - start, from_cache: result.from_cache });
    return Response.json({ ...result, request_id: requestId });
  } catch (err) {
    log.error({ event: 'api.analyze.error', duration_ms: Date.now() - start, error: err instanceof Error ? err.message : String(err) });
    return errorResponse('Something went wrong', 'INTERNAL_ERROR', 500);
  }
}
```

---

## FastAPI — Structured Logging

```python
# logger.py
import logging, json, time
from datetime import datetime, timezone

SERVICE = "xingai-invest-ai"  # set per product

class JsonFormatter(logging.Formatter):
    def format(self, record: logging.LogRecord) -> str:
        log = {
            "level": record.levelname.lower(),
            "timestamp": datetime.now(timezone.utc).isoformat(),
            "service": SERVICE,
            "event": record.getMessage(),
        }
        for key in ("request_id", "duration_ms", "user_id", "details"):
            if hasattr(record, key):
                log[key] = getattr(record, key)
        return json.dumps(log)

handler = logging.StreamHandler()
handler.setFormatter(JsonFormatter())
logger = logging.getLogger(SERVICE)
logger.addHandler(handler)
logger.setLevel(logging.INFO)
```

```python
# Usage in endpoint
import time, uuid
from logger import logger

@app.post("/demo/run")
async def run_pipeline(request: RunRequest):
    request_id = str(uuid.uuid4())
    start = time.monotonic()
    logger.info("pipeline.start", extra={"request_id": request_id})

    try:
        result = await orchestrator.run(request.goal, request_id)
        duration = int((time.monotonic() - start) * 1000)
        logger.info("pipeline.complete", extra={"request_id": request_id, "duration_ms": duration})
        return {**result, "request_id": request_id}
    except Exception as exc:
        duration = int((time.monotonic() - start) * 1000)
        logger.error("pipeline.error", extra={"request_id": request_id, "duration_ms": duration,
                                               "details": {"error": str(exc)}})
        raise
```

---

## Event Naming Convention

Use `domain.action` format:

```
worker.cache_hit
worker.cache_miss
worker.llm_call_start
worker.llm_call_complete
worker.llm_call_error
api.request_start
api.request_complete
api.validation_error
api.auth_error
agent.step_start
agent.step_complete
agent.tool_call
```

---

## What NOT to Log

| Never log | Reason |
|---|---|
| Passwords, tokens, API keys | Security — leaked in log aggregators |
| Full user input verbatim | Privacy (PII), GDPR/CCPA risk |
| LLM prompt content at INFO level | Expensive storage + privacy |
| Stack traces at INFO level | Use ERROR level for exceptions |
| Timestamps without timezone | Ambiguous across regions |

```ts
// ❌ Never do this
logger.info({ event: 'user.query', query: userInput, email: user.email });

// ✅ Do this
logger.info({ event: 'user.query', user_id: user.id, input_length: userInput.length });
```

---

## Log Levels

| Level | When |
|---|---|
| `debug` | Dev-only verbose info — disabled in production |
| `info` | Normal operations: requests, cache hits/misses, pipeline steps |
| `warn` | Degraded state: stale cache served, fallback used, rate limit approaching |
| `error` | Failures requiring attention: unhandled exception, external service down |

---

## Checklist

```markdown
- [ ] pino (TS) or structured JSON logger (Python) installed
- [ ] Logger includes service, timestamp, level, event fields
- [ ] request_id generated per request and passed to all logs in that request
- [ ] duration_ms logged on all AI/LLM calls
- [ ] No PII (email, full input text) in logs
- [ ] ERROR level triggers alerting in production (Vercel logs, Sentry, etc.)
- [ ] LOG_LEVEL env var controls verbosity
- [ ] debug level disabled in production
```

## Common Mistakes

- `console.log("cache miss")` — cannot be filtered or alerted on.
- Logging `req.body` at INFO — captures user PII.
- No `request_id` — impossible to trace a single request across worker + API logs.
- Same log level for everything — alerts fire on INFO, misses real errors.
- `duration_ms` as float (`1240.0032...`) — round to integer before logging.
