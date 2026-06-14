---
name: testing-baseline
description: >-
  Adds a testing baseline to XingAI Next.js and FastAPI projects. Use when
  setting up tests for the first time, adding Vitest to a Next.js app, adding
  pytest to a FastAPI backend, or writing tests for the worker/cache boundary.
---

# Testing Baseline

Use this skill to wire up a testing baseline in any XingAI product repo.

Enterprise rule: **no untested code merges to `main`.** Tests run in CI on every PR.

---

## Next.js — Vitest + React Testing Library

### Install

```bash
npm install --save-dev vitest @vitejs/plugin-react jsdom @testing-library/react @testing-library/user-event @testing-library/jest-dom @vitest/coverage-v8
```

### Config

```ts
// vitest.config.ts
import { defineConfig } from 'vitest/config';
import react from '@vitejs/plugin-react';
import path from 'path';

export default defineConfig({
  plugins: [react()],
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: ['./vitest.setup.ts'],
    coverage: {
      provider: 'v8',
      reporter: ['text', 'lcov'],
      thresholds: { lines: 70, functions: 70, branches: 60 },
      exclude: ['node_modules', '.next', 'vitest.config.ts'],
    },
  },
  resolve: {
    alias: { '@': path.resolve(__dirname, './') },
  },
});
```

```ts
// vitest.setup.ts
import '@testing-library/jest-dom';
```

```json
// package.json — add to scripts
{
  "test": "vitest run",
  "test:watch": "vitest",
  "test:coverage": "vitest run --coverage"
}
```

---

## What to Test in XingAI Products

### 1. i18n utility (pure function — easy, high value)

```ts
// lib/__tests__/i18n.test.ts
import { tr } from '@/lib/i18n';

describe('tr', () => {
  it('returns english by default', () => {
    expect(tr('en', 'Hello', '你好', '안녕하세요')).toBe('Hello');
  });
  it('returns chinese when lang is zh', () => {
    expect(tr('zh', 'Hello', '你好', '안녕하세요')).toBe('你好');
  });
  it('returns korean when lang is ko', () => {
    expect(tr('ko', 'Hello', '你好', '안녕하세요')).toBe('안녕하세요');
  });
});
```

### 2. Cache key utility (pure function)

```ts
// lib/__tests__/cache.test.ts
import { makeCacheKey } from '@/lib/cache';

describe('makeCacheKey', () => {
  it('produces consistent keys for the same input', () => {
    expect(makeCacheKey('research', 'Tesla stock')).toBe(
      makeCacheKey('research', 'Tesla stock')
    );
  });
  it('differentiates namespaces', () => {
    expect(makeCacheKey('research', 'Tesla')).not.toBe(
      makeCacheKey('analysis', 'Tesla')
    );
  });
  it('normalizes whitespace', () => {
    expect(makeCacheKey('ns', '  Tesla  ')).toBe(makeCacheKey('ns', 'Tesla'));
  });
});
```

### 3. API route (integration-style with fetch mock)

```ts
// app/api/analyze/__tests__/route.test.ts
import { POST } from '../route';

describe('POST /api/analyze', () => {
  it('returns 400 for missing input', async () => {
    const req = new Request('http://localhost/api/analyze', {
      method: 'POST',
      body: JSON.stringify({}),
      headers: { 'Content-Type': 'application/json' },
    });
    const res = await POST(req);
    expect(res.status).toBe(400);
    const body = await res.json();
    expect(body.code).toBe('BAD_INPUT');
  });

  it('returns 202 on cache miss', async () => {
    vi.mock('@/lib/cache', () => ({ readCache: vi.fn().mockResolvedValue(null) }));
    const req = new Request('http://localhost/api/analyze', {
      method: 'POST',
      body: JSON.stringify({ input: 'Analyze Tesla for me', lang: 'en' }),
      headers: { 'Content-Type': 'application/json' },
    });
    const res = await POST(req);
    expect(res.status).toBe(202);
  });
});
```

### 4. React component (render + interaction)

```tsx
// components/__tests__/ErrorState.test.tsx
import { render, screen } from '@testing-library/react';
import { ErrorState } from '@/components/ErrorState';

describe('ErrorState', () => {
  it('shows English message for RATE_LIMITED', () => {
    render(<ErrorState code="RATE_LIMITED" lang="en" />);
    expect(screen.getByRole('alert')).toHaveTextContent('Wait a moment');
  });

  it('shows Chinese message for RATE_LIMITED when lang is zh', () => {
    render(<ErrorState code="RATE_LIMITED" lang="zh" />);
    expect(screen.getByRole('alert')).toHaveTextContent('请求频率过高');
  });
});
```

---

## FastAPI — pytest

### Install

```bash
pip install pytest pytest-asyncio httpx pytest-cov
```

```ini
# pytest.ini
[pytest]
asyncio_mode = auto
testpaths = tests
addopts = --cov=. --cov-report=term-missing --cov-fail-under=70
```

### Structure

```
backend/
  tests/
    __init__.py
    test_cache.py
    test_worker.py
    test_api.py
  conftest.py
```

### conftest.py

```python
# tests/conftest.py
import pytest
from fastapi.testclient import TestClient
from main import app

@pytest.fixture
def client():
    return TestClient(app)

@pytest.fixture
def tmp_db(tmp_path):
    """Isolated SQLite DB per test."""
    return str(tmp_path / "test_cache.db")
```

### Cache tests

```python
# tests/test_cache.py
from workers.decision_worker import make_key, get_cache, set_cache

def test_cache_key_is_deterministic(tmp_db):
    assert make_key("research", "Tesla") == make_key("research", "Tesla")

def test_cache_key_differentiates_namespaces(tmp_db):
    assert make_key("research", "Tesla") != make_key("analysis", "Tesla")

def test_cache_miss_returns_none(tmp_db):
    assert get_cache("missing:key", db_path=tmp_db) is None

def test_cache_roundtrip(tmp_db):
    set_cache("ns:abc", {"verdict": "buy"}, db_path=tmp_db)
    result = get_cache("ns:abc", db_path=tmp_db)
    assert result["verdict"] == "buy"
```

### API tests

```python
# tests/test_api.py
def test_run_missing_input(client):
    res = client.post("/demo/run", json={})
    assert res.status_code == 422

def test_run_returns_trace_id(client, monkeypatch):
    monkeypatch.setenv("DEMO_MODE", "1")
    res = client.post("/demo/run", json={"goal": "Analyze Tesla"})
    assert res.status_code == 200
    assert "request_id" in res.json()

def test_metrics_endpoint(client):
    res = client.get("/demo/metrics")
    assert res.status_code == 200
    assert "total_requests" in res.json()
```

---

## Coverage Thresholds

| Environment | Minimum coverage | Enforced by |
|---|---|---|
| Next.js | 70% lines, 70% functions | `vitest --coverage` in CI |
| FastAPI | 70% lines | `pytest --cov-fail-under=70` in CI |

Start at 70%, raise to 80% once baseline is established.

## What NOT to Test

- Third-party library internals (OpenAI SDK, Next.js router).
- Snapshot tests for rapidly-changing UI components — they break constantly with no value.
- Private implementation details — test behavior, not internals.
- Generated code and migrations.

## Pre-Ship Testing Checklist

```markdown
- [ ] vitest.config.ts / pytest.ini configured
- [ ] Tests exist for i18n helpers, cache key logic, API routes
- [ ] Coverage ≥ 70% enforced in CI
- [ ] Tests run in GitHub Actions on every PR
- [ ] Tests pass locally before opening PR
- [ ] No skipped tests without a dated comment explaining why
```

## Common Mistakes

- Testing implementation details (private functions) instead of behavior.
- Mocking the cache layer in worker tests — use a real tmp SQLite file instead.
- Not testing error paths (missing input, cache miss, AI unavailable).
- Skipping tests on "deadline" branches — tech debt that never gets paid.
- Coverage threshold too low (< 50%) — meaningless gate.
