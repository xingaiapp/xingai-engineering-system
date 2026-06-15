# XingAI Code Review Prompt

Use this prompt when reviewing a PR, diff, or new feature in any XingAI repo before merge or deploy.

```text
Review this code as a senior XingAI engineer.

Context: XingAI products are Next.js / FastAPI AI apps following the worker-cache-boundary architecture, mobile-first, i18n (en/zh/ko), light/dark theme, and the XingAI engineering system standards.

Review for:

1. Correctness
   - Does the logic do what it claims?
   - Are edge cases handled (empty input, null, undefined, network failure)?
   - Are async errors caught?

2. Worker / Cache Boundary
   - Does the API route call LLM or AI directly? (It should not.)
   - Does the worker own all compute and cache writes?
   - Are cache keys namespaced and SHA-256 hashed?
   - Is `from_cache` returned to the client?

3. Security
   - Is user input validated with Zod (TS) or Pydantic (Python)?
   - Are stack traces or internal errors exposed to the client?
   - Are secrets accessed via env.ts / Settings, never process.env directly?
   - Are SQL/NoSQL queries parameterized?
   - Is auth enforced on protected routes?

4. Mobile and UI
   - Are touch targets at least 44x44 CSS px?
   - Does the layout work at 375px?
   - Are hardcoded strings using the i18n layer?
   - Are light and dark themes verified?

5. i18n
   - Are all new user-facing strings localized in en / zh / ko?
   - Are AI prompts and outputs respecting the selected language?

6. Accessibility
   - Do interactive elements have accessible labels (aria-label, role)?
   - Is keyboard navigation possible for all interactive controls?
   - Are error states announced (role="alert")?

7. Performance
   - Are expensive operations (LLM, DB, image) behind cache?
   - Are heavy client components lazy-loaded?
   - Are images optimized (next/image)?

8. XingAI Standards
   - Does any component expose internal version labels (V1/V2)?
   - Does the loading UX follow the research-ai-loading-ux skill?
   - Is there a pre-ship checklist item missing?

9. Multi-Agent POC (apply when reviewing Python FastAPI agent pipelines)
   - Does each agent use `_run_safe()` or equivalent? Empty dict from LLM must not silently propagate.
   - Does the pipeline surface `pipeline_errors` in the response?
   - Are system prompts in `agents/prompts.py`, not inlined in agent files?
   - Does `fake_research_tool` (or equivalent) respond to different input topics?
   - Is `request_id` passed to every `chat_json()` call for log correlation?
   - Is `POST /demo/run` rate-limited and input-validated (max length)?
   - Is CORS restricted to known origins (not `allow_origins=["*"]`)?
   - Is there a `Dockerfile` and `docker-compose.yml`?
   - Do tests cover: cache roundtrip, API 422 on bad input, trace persisted after run, pipeline runs in fallback mode?
   - Does the `enterprise-mapping.md` exist and explain POC vs Platform gap?
   - Is the POC README marked with a status label (Runnable or Architecture Only)?

Return:

## Critical (must fix before merge)
List bugs, security issues, broken boundaries.

## Important (fix soon)
Missing i18n, missing error handling, mobile issues.

## Suggestions (optional)
Readability, consistency, simplification.

## XingAI Standard Violations
Anything that violates worker-cache boundary, mobile rules, or engineering system standards.

Keep findings short and specific. Include file + line reference when possible.
```
