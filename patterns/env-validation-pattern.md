# Environment Variable Validation Pattern

Use this pattern in every XingAI Next.js app to catch missing or malformed environment variables **at build time**, not at runtime.

Validated in: `xingai-dot-app`, `xingai-invest-ai`, `xingai-learn`, `xingai-meal-coach-ai`

## Core Rule

**Validate all required env vars at startup with Zod. Never read `process.env` directly in component or API code.**

If a required variable is missing, the app should fail fast with a clear error message — not silently return `undefined`.

---

## Implementation (Next.js + Zod)

```ts
// env.ts  — root of the project, import from here everywhere
import { z } from "zod";

const serverSchema = z.object({
  NODE_ENV: z.enum(["development", "test", "production"]),
  AUTH_SECRET: z.string().min(32),
  GOOGLE_CLIENT_ID: z.string().min(1),
  GOOGLE_CLIENT_SECRET: z.string().min(1),
  OPENAI_API_KEY: z.string().startsWith("sk-").optional(), // optional = demo mode allowed
  DATABASE_URL: z.string().url().optional(),
});

const clientSchema = z.object({
  NEXT_PUBLIC_SITE_URL: z.string().url(),
  NEXT_PUBLIC_APP_NAME: z.string().min(1),
});

// Validate on module load — fails at startup, not mid-request
const _serverEnv = serverSchema.safeParse(process.env);
if (!_serverEnv.success) {
  console.error("❌ Missing or invalid server env vars:");
  console.error(_serverEnv.error.flatten().fieldErrors);
  throw new Error("Invalid server environment configuration");
}

const _clientEnv = clientSchema.safeParse({
  NEXT_PUBLIC_SITE_URL: process.env.NEXT_PUBLIC_SITE_URL,
  NEXT_PUBLIC_APP_NAME: process.env.NEXT_PUBLIC_APP_NAME,
});
if (!_clientEnv.success) {
  console.error("❌ Missing or invalid client env vars:");
  console.error(_clientEnv.error.flatten().fieldErrors);
  throw new Error("Invalid client environment configuration");
}

export const env = {
  ..._serverEnv.data,
  ..._clientEnv.data,
};
```

Usage everywhere in the app:

```ts
import { env } from "@/env";

// ✅ Type-safe, validated
const key = env.OPENAI_API_KEY;

// ❌ Never do this
const key = process.env.OPENAI_API_KEY;
```

---

## `.env.example` Standard

Every XingAI repo must include `.env.example` with safe placeholder values. Never commit real secrets.

```env
# App
NEXT_PUBLIC_SITE_URL=https://your-product.xingai.app
NEXT_PUBLIC_APP_NAME=Your Product Name
NODE_ENV=development

# Auth
AUTH_SECRET=generate-with-openssl-rand-base64-32
AUTH_URL=http://localhost:3000

# Google OAuth — create a new client per product
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=

# AI
OPENAI_API_KEY=sk-...   # optional — app runs in demo mode without it

# Database (optional for MVP)
DATABASE_URL=
```

---

## Demo Mode Pattern

XingAI products should degrade gracefully when `OPENAI_API_KEY` is missing:

```ts
export function isDemoMode(): boolean {
  return !env.OPENAI_API_KEY;
}

// In worker:
if (isDemoMode()) {
  return DEMO_FIXTURE_RESPONSE;
}
// else call real LLM
```

This ensures demos never fail live because of a missing key.

---

## FastAPI Equivalent (Python)

```python
# config.py
from pydantic_settings import BaseSettings
from pydantic import AnyHttpUrl, field_validator

class Settings(BaseSettings):
    openai_api_key: str | None = None
    site_url: AnyHttpUrl = "http://localhost:8000"
    db_path: str = "cache.db"
    demo_mode: bool = False

    @field_validator("demo_mode", mode="before")
    @classmethod
    def set_demo_mode(cls, v, info):
        return not info.data.get("openai_api_key")

    class Config:
        env_file = ".env"

settings = Settings()
```

---

## Checklist

```markdown
- [ ] env.ts (or config.py) exists at repo root
- [ ] All env vars validated with Zod / pydantic at startup
- [ ] No raw process.env reads in component or API code
- [ ] .env.example includes all required keys with safe placeholders
- [ ] Optional keys have demo fallbacks
- [ ] Real secrets excluded from git (.gitignore)
- [ ] Production env names match .env.example keys
```

## Common Mistakes

- Reading `process.env.X` directly in API routes — no type safety, no early failure.
- Missing `.env.example` — new devs spend hours debugging startup errors.
- `OPENAI_API_KEY` required at startup — demo breaks without it.
- Production env names differ from `.env.example` — silent undefined values.
- Committing `.env` instead of `.env.example` to git.
