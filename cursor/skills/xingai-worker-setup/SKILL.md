---
name: xingai-worker-setup
description: >-
  Scaffolds the XingAI worker/cache boundary architecture for AI products.
  Use when setting up a new worker, adding async AI pipelines, wiring cache
  layers, or implementing the compute-then-cache pattern in any XingAI product.
---

# XingAI Worker Setup

Use this skill when scaffolding or wiring the **worker/cache boundary** in a XingAI AI product.

Reference pattern: `patterns/worker-cache-boundary.md`  
Validated in: `xingai-invest-ai`, `xingai-learn`, `xingai-founder`, `xingai-meal-coach-ai`

## Core Architecture

```text
Frontend (render cache only)
         ↓
API Route (read cache, enqueue misses, enforce auth/rate limits)
         ↓
Cache Layer (SQLite / Redis / Upstash)
         ↑
Worker (compute decisions, write cache, refresh stale)
         ↓
LLM / External APIs
```

**Rule:** API never calls LLM directly. Worker always writes cache before returning.

---

## Step 1 — Identify What the Worker Owns

Before writing code, define:

| Worker owns | API owns | Frontend owns |
|---|---|---|
| AI/LLM calls | Read cache | Render cache fields |
| Scoring/ranking | Validate request shape | Show loading/pending |
| Explanations | Enqueue cache miss | Localize labels |
| Cache writes | Enforce auth/rate limits | Never compute decisions |
| Stale refresh | Return cache miss error | Surface `from_cache` badge |

---

## Step 2 — Cache Schema

SQLite (POC/MVP):

```sql
CREATE TABLE IF NOT EXISTS cache (
  key       TEXT PRIMARY KEY,
  value     TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  ttl_seconds INTEGER NOT NULL DEFAULT 604800
);
```

- Key: `{namespace}:{sha256(normalized_input)}`
- Value: JSON string of the full decision output
- TTL: 7 days default for MVP; adjust per product need

Upstash Redis (production):

```ts
await redis.set(key, JSON.stringify(value), { ex: 604800 });
const hit = await redis.get<DecisionOutput>(key);
```

---

## Step 3 — Worker Pattern (Python FastAPI)

```python
# workers/decision_worker.py
import hashlib, json, time, sqlite3
from openai import OpenAI

DB_PATH = "cache.db"
TTL = 604800  # 7 days

def get_cache(key: str):
    con = sqlite3.connect(DB_PATH)
    row = con.execute(
        "SELECT value, created_at, ttl_seconds FROM cache WHERE key = ?", (key,)
    ).fetchone()
    con.close()
    if not row:
        return None
    value, created_at, ttl = row
    if time.time() - created_at > ttl:
        return None  # stale
    return json.loads(value)

def set_cache(key: str, value: dict):
    con = sqlite3.connect(DB_PATH)
    con.execute(
        "INSERT OR REPLACE INTO cache (key, value, created_at, ttl_seconds) VALUES (?,?,?,?)",
        (key, json.dumps(value), int(time.time()), TTL),
    )
    con.commit()
    con.close()

def make_key(namespace: str, input_data: str) -> str:
    h = hashlib.sha256(input_data.strip().lower().encode()).hexdigest()
    return f"{namespace}:{h}"

def run_decision(namespace: str, user_input: str, system_prompt: str) -> dict:
    key = make_key(namespace, user_input)
    cached = get_cache(key)
    if cached:
        return {**cached, "from_cache": True}

    client = OpenAI()
    response = client.chat.completions.create(
        model="claude-sonnet-4-6",  # or gpt-4o
        messages=[
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_input},
        ],
        response_format={"type": "json_object"},
    )
    result = json.loads(response.choices[0].message.content)
    set_cache(key, result)
    return {**result, "from_cache": False}
```

---

## Step 4 — API Route Pattern (Next.js)

```ts
// app/api/decision/route.ts
import { NextRequest, NextResponse } from "next/server";
import { z } from "zod";

const RequestSchema = z.object({
  input: z.string().min(1).max(2000),
  lang: z.enum(["en", "zh", "ko"]).default("en"),
});

export async function POST(req: NextRequest) {
  const body = await req.json().catch(() => null);
  const parsed = RequestSchema.safeParse(body);
  if (!parsed.success) {
    return NextResponse.json(
      { error: "Invalid request", details: parsed.error.flatten() },
      { status: 400 }
    );
  }

  // Read from cache — never call LLM here
  const cacheKey = makeCacheKey(parsed.data.input);
  const cached = await readCache(cacheKey);
  if (cached) {
    return NextResponse.json({ ...cached, from_cache: true });
  }

  // Cache miss — trigger worker or return pending state
  await enqueueWorker({ input: parsed.data.input, lang: parsed.data.lang });
  return NextResponse.json({ status: "pending", from_cache: false }, { status: 202 });
}
```

---

## Step 5 — Stale Refresh Strategy

```text
On cache read:
  if age < TTL/2  → fresh, return immediately
  if age < TTL    → return cached + trigger background refresh
  if age >= TTL   → return pending, trigger sync refresh
```

API should return a `stale: true` flag when serving past half-TTL so the UI can show a subtle "Refreshing..." badge.

---

## Step 6 — Frontend Pattern (React)

```tsx
// Never derive decisions from raw fields
// Never call LLM endpoints directly

export function DecisionCard({ lang }: { lang: Lang }) {
  const { data, isLoading, error } = useDecision(lang);

  if (isLoading) return <TypingStatus lang={lang} />;
  if (error) return <ErrorState error={error} />;
  if (data?.status === "pending") return <PendingState lang={lang} />;

  return (
    <div>
      {data?.from_cache && <CacheBadge />}
      {data?.stale && <StaleBadge />}
      <DecisionOutput decision={data} lang={lang} />
    </div>
  );
}
```

---

## Pre-Wiring Checklist

```markdown
- [ ] Worker file exists and owns all LLM/AI calls
- [ ] API route reads cache only — no direct LLM calls
- [ ] Cache key uses SHA-256 of normalized input with namespace prefix
- [ ] TTL is set (default 7 days)
- [ ] Cache miss returns 202 + enqueues worker
- [ ] `from_cache` and `stale` flags are returned in API response
- [ ] Frontend renders cache fields only, never derives decisions
- [ ] Stale refresh path exists (background or sync)
- [ ] `.env.example` includes all required keys
- [ ] Fallback behavior when OpenAI key is missing (demo mode)
```

## Common Mistakes

- API route calls OpenAI directly on cache miss (breaks the boundary).
- No namespace in cache key (collision between products/features).
- Worker writes only one locale but UI claims all locales are ready.
- Stale cache returns silently without a `stale` flag.
- Frontend re-computes decisions from raw score fields.
- No fallback when the LLM key is missing (demo breaks live).
