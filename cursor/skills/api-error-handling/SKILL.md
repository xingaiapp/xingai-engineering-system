---
name: api-error-handling
description: >-
  Standardizes error handling across XingAI FastAPI backends and Next.js API
  routes. Use when adding error responses, exception handlers, validation errors,
  or consistent error shapes to any XingAI API.
---

# API Error Handling

Use this skill when writing or reviewing API error handling in XingAI products.

Applies to: FastAPI backends (POCs, workers), Next.js App Router API routes, and edge functions.

## Core Rule

Every API in XingAI must return a consistent error shape and never leak internal stack traces to the client.

```json
{
  "error": "Human-readable message",
  "code": "MACHINE_READABLE_CODE",
  "details": {}
}
```

---

## FastAPI Error Handling

### Global Exception Handler

Add to every XingAI FastAPI app:

```python
# main.py
from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse
import logging

logger = logging.getLogger(__name__)
app = FastAPI()

@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    logger.error(f"Unhandled error: {exc}", exc_info=True)
    return JSONResponse(
        status_code=500,
        content={"error": "Internal server error", "code": "INTERNAL_ERROR"},
    )

@app.exception_handler(ValueError)
async def value_error_handler(request: Request, exc: ValueError):
    return JSONResponse(
        status_code=400,
        content={"error": str(exc), "code": "VALIDATION_ERROR"},
    )
```

### Standard HTTP Error Responses

```python
from fastapi import HTTPException

# 400 Bad Request
raise HTTPException(status_code=400, detail={"error": "Invalid input", "code": "BAD_INPUT"})

# 401 Unauthorized
raise HTTPException(status_code=401, detail={"error": "Authentication required", "code": "UNAUTHORIZED"})

# 404 Not Found
raise HTTPException(status_code=404, detail={"error": "Resource not found", "code": "NOT_FOUND"})

# 429 Rate Limited
raise HTTPException(status_code=429, detail={"error": "Too many requests", "code": "RATE_LIMITED"})

# 503 Dependency Unavailable
raise HTTPException(status_code=503, detail={"error": "AI service unavailable", "code": "AI_UNAVAILABLE"})
```

### LLM / OpenAI Error Wrapping

```python
from openai import OpenAIError, RateLimitError, APIConnectionError

def safe_llm_call(prompt: str) -> dict:
    try:
        # ... LLM call
    except RateLimitError:
        raise HTTPException(
            status_code=429,
            detail={"error": "AI rate limit reached, try again shortly", "code": "AI_RATE_LIMITED"},
        )
    except APIConnectionError:
        raise HTTPException(
            status_code=503,
            detail={"error": "Could not reach AI service", "code": "AI_UNAVAILABLE"},
        )
    except OpenAIError as e:
        logger.error(f"OpenAI error: {e}")
        raise HTTPException(
            status_code=502,
            detail={"error": "AI service error", "code": "AI_ERROR"},
        )
```

---

## Next.js API Route Error Handling

### Shared Error Helper

```ts
// lib/api-error.ts
export type ApiErrorCode =
  | "BAD_INPUT"
  | "UNAUTHORIZED"
  | "NOT_FOUND"
  | "RATE_LIMITED"
  | "AI_UNAVAILABLE"
  | "AI_ERROR"
  | "INTERNAL_ERROR";

export function errorResponse(
  message: string,
  code: ApiErrorCode,
  status: number,
  details?: Record<string, unknown>
) {
  return Response.json({ error: message, code, details }, { status });
}
```

### Route Usage

```ts
// app/api/analyze/route.ts
import { z } from "zod";
import { errorResponse } from "@/lib/api-error";

const Schema = z.object({
  input: z.string().min(1).max(5000),
});

export async function POST(req: Request) {
  let body: unknown;
  try {
    body = await req.json();
  } catch {
    return errorResponse("Invalid JSON body", "BAD_INPUT", 400);
  }

  const parsed = Schema.safeParse(body);
  if (!parsed.success) {
    return errorResponse("Validation failed", "BAD_INPUT", 400, {
      fields: parsed.error.flatten().fieldErrors,
    });
  }

  try {
    const result = await runAnalysis(parsed.data.input);
    return Response.json(result);
  } catch (err) {
    if (err instanceof RateLimitError) {
      return errorResponse("AI rate limit reached", "RATE_LIMITED", 429);
    }
    console.error("Analyze error:", err);
    return errorResponse("Something went wrong", "INTERNAL_ERROR", 500);
  }
}
```

---

## Frontend Error Display

```tsx
// components/ErrorState.tsx
import { tr, type Lang } from "@/lib/i18n";

const messages: Record<string, { en: string; zh: string; ko: string }> = {
  RATE_LIMITED: {
    en: "You're moving fast. Wait a moment and try again.",
    zh: "请求频率过高，请稍后再试。",
    ko: "잠시 후 다시 시도해 주세요.",
  },
  AI_UNAVAILABLE: {
    en: "AI service is temporarily unavailable.",
    zh: "AI 服务暂时不可用。",
    ko: "AI 서비스를 일시적으로 사용할 수 없습니다.",
  },
  INTERNAL_ERROR: {
    en: "Something went wrong. Please try again.",
    zh: "出现错误，请重试。",
    ko: "오류가 발생했습니다. 다시 시도해 주세요.",
  },
};

export function ErrorState({ code, lang }: { code: string; lang: Lang }) {
  const msg = messages[code] ?? messages.INTERNAL_ERROR;
  return (
    <div role="alert" className="rounded-xl border border-border bg-card p-4 text-sm text-foreground">
      {tr(lang, msg.en, msg.zh, msg.ko)}
    </div>
  );
}
```

---

## Error Logging Standard

- Log all 5xx errors server-side with full context.
- Never log user PII (email, phone, token) in plain text.
- Include `request_id` when available for traceability.
- Never return stack traces to the client.

```python
# Python
logger.error(f"[{request_id}] Pipeline failed: {type(exc).__name__}: {exc}")

# TypeScript
console.error({ requestId, error: err instanceof Error ? err.message : String(err) });
```

---

## Checklist

```markdown
- [ ] Global exception handler installed (FastAPI / Next.js)
- [ ] All errors return { error, code } shape
- [ ] Stack traces never sent to client
- [ ] LLM errors wrapped with user-friendly messages
- [ ] Rate limit errors return 429 with retry guidance
- [ ] Validation errors include field-level details
- [ ] Frontend shows localized error messages
- [ ] All 5xx errors logged server-side
- [ ] No PII logged in plain text
```

## Common Mistakes

- Returning raw Python exceptions or Next.js stack traces to the client.
- Missing global handler — unhandled errors return 500 with HTML body.
- Same error message for all errors — users cannot act on them.
- No `code` field — frontend cannot distinguish error types.
- PII (user input, email) logged at ERROR level unredacted.
