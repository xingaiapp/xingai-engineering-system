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
