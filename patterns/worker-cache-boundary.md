# Worker Cache Boundary

Use this pattern when an AI product needs expensive or slow decision generation.

## Core Rule

Worker/core logic computes decisions. API routes read cached decisions and handle transport.

## Worker Owns

- source collection
- AI calls
- scoring
- ranking
- explanations
- cache writes
- stale refresh
- decision fields that change user interpretation

## API Owns

- read cached results
- validate request shape
- enqueue cache misses
- enforce auth/rate limits
- attach transport metadata
- return explicit cache miss/stale errors

## Frontend Owns

- render cached fields
- localize labels
- show loading/pending state
- never reverse-engineer decisions from raw fields

## Why It Works

The request path stays fast and predictable. Expensive AI work happens asynchronously. Users get cached, auditable outputs, and the system can refresh stale decisions without hiding computation in the API layer.

## Common Mistakes

- API route calls OpenAI directly on cache miss.
- Frontend computes recommendation from raw scores.
- Worker writes one locale but UI claims all locales are ready.
- Stale cache returns silently without a refresh path.
- **Any external HTTP call inside a request handler — not just LLM calls.** `xingai-invest-ai` shipped a secondary-quote-check endpoint whose first draft called a third-party market data vendor (Tradier) live and synchronously from inside the FastAPI route, discovered and fixed same-day before it reached production. Correct shape: worker calls the vendor once per refresh cycle and caches the result (`compute_and_cache_*`); the API route only reads that cache (`read_*`), same split as this pattern's `worker_heartbeat.py` precedent. The rule isn't "don't call OpenAI from a route" — it's "don't call *anything* external from a route." See `xingai-invest-ai` ADR-012 and the `secondary_quote_check.py` fix for the concrete before/after.
