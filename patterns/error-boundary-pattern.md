# Error Boundary Pattern

Use this pattern to handle runtime errors gracefully in XingAI Next.js products. Prevents white screens, surfaces helpful messages, and enables recovery.

**Status:** Target pattern — adopt per route in Next.js App Router products.

**Reference (partial):** `xingai-invest-ai` (where implemented)

## Core Rule

**Every route segment that renders user-facing data needs an `error.tsx`. Every async server component needs a `loading.tsx`. Never let an unhandled error show a blank page.**

---

## Next.js App Router: Required Files Per Route

```text
app/
  layout.tsx           ← global layout
  error.tsx            ← catches errors in root segment
  not-found.tsx        ← 404 handler
  loading.tsx          ← root Suspense boundary
  dashboard/
    page.tsx
    error.tsx          ← catches errors in /dashboard only
    loading.tsx        ← Suspense for /dashboard
```

### `error.tsx` Template

```tsx
"use client";

import { useEffect } from "react";
import { tr, type Lang } from "@/lib/i18n";

export default function ErrorPage({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    // Log to your error reporting service
    console.error(error);
  }, [error]);

  // Detect lang from cookie or default to "en"
  const lang: Lang = "en";

  return (
    <div className="flex min-h-[50vh] flex-col items-center justify-center gap-4 p-8 text-center">
      <p className="text-sm text-muted-foreground">
        {tr(
          lang,
          "Something went wrong. Please try again.",
          "出现错误，请重试。",
          "오류가 발생했습니다. 다시 시도해 주세요."
        )}
      </p>
      <button
        onClick={reset}
        className="rounded-lg bg-primary px-4 py-2 text-sm text-primary-foreground"
      >
        {tr(lang, "Try again", "重试", "다시 시도")}
      </button>
      {process.env.NODE_ENV === "development" && (
        <pre className="mt-4 max-w-xl overflow-auto rounded bg-muted p-4 text-left text-xs">
          {error.message}
        </pre>
      )}
    </div>
  );
}
```

### `not-found.tsx` Template

```tsx
import Link from "next/link";
import { tr } from "@/lib/i18n";

export default function NotFound() {
  return (
    <div className="flex min-h-[50vh] flex-col items-center justify-center gap-4 p-8 text-center">
      <p className="text-4xl font-bold">404</p>
      <p className="text-muted-foreground">
        {tr("en", "Page not found", "页面未找到", "페이지를 찾을 수 없습니다")}
      </p>
      <Link href="/" className="text-sm text-primary underline underline-offset-4">
        {tr("en", "Go home", "返回首页", "홈으로")}
      </Link>
    </div>
  );
}
```

### `loading.tsx` Template

```tsx
export default function Loading() {
  return (
    <div className="flex min-h-[50vh] items-center justify-center">
      <div className="h-6 w-6 animate-spin rounded-full border-2 border-border border-t-primary" />
    </div>
  );
}
```

---

## React Error Boundary (Client Components)

For client-side component trees that may throw:

```tsx
// components/SafeWrapper.tsx
"use client";

import { Component, type ReactNode } from "react";

interface State { hasError: boolean; error?: Error }

export class SafeWrapper extends Component<{ children: ReactNode; fallback?: ReactNode }, State> {
  state: State = { hasError: false };

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, info: { componentStack: string }) {
    console.error("SafeWrapper caught:", error, info);
  }

  render() {
    if (this.state.hasError) {
      return this.props.fallback ?? (
        <p className="p-4 text-sm text-muted-foreground">
          This section failed to load.
        </p>
      );
    }
    return this.props.children;
  }
}
```

Usage:

```tsx
<SafeWrapper fallback={<ErrorState code="INTERNAL_ERROR" lang={lang} />}>
  <DecisionPanel />
</SafeWrapper>
```

---

## FastAPI: Never Expose Stack Traces

```python
# main.py — always add both handlers
@app.exception_handler(Exception)
async def catch_all(request, exc):
    logging.error(f"Unhandled: {exc}", exc_info=True)
    return JSONResponse({"error": "Internal server error", "code": "INTERNAL_ERROR"}, status_code=500)

@app.exception_handler(RequestValidationError)
async def validation_error(request, exc):
    return JSONResponse({"error": "Invalid request", "code": "BAD_INPUT", "details": exc.errors()}, status_code=422)
```

---

## Checklist

```markdown
- [ ] Root app/error.tsx exists and is a Client Component
- [ ] Root app/not-found.tsx exists
- [ ] Root app/loading.tsx exists
- [ ] Each major route segment has its own error.tsx
- [ ] Error messages are localized (en/zh/ko)
- [ ] Dev-only: error.message shown in development
- [ ] Prod: no stack traces visible to users
- [ ] FastAPI global exception handler installed
- [ ] All caught errors logged server-side
- [ ] "Try again" / reset action available on error screens
```

## Common Mistakes

- Missing `"use client"` on `error.tsx` — Next.js requires it.
- Showing `error.message` in production — leaks internals.
- No `reset` button — user is stuck with no recovery path.
- `loading.tsx` missing on data-heavy routes — flashes of blank content.
- Error boundary catches error but logs nothing — silent failures.
