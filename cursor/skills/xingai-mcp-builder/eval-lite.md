# XingAI MCP Eval (Lite)

Use after adding a **new read-oriented tool surface** that agents will explore. Skip for tiny gate fixes covered by pytest.

## Goal

Check whether an LLM can use the tools to answer realistic questions **without** side effects.

## Rules for questions

- Independent of other questions
- Read-only tools only
- Prefer stable answers (ids, counts, masked fields, documented error states)
- Verifiable (short string or enum)
- Based on fixtures or mock upstream when live data is unstable

## Suggested set (5–10)

Examples for a brokerage/claims-style MCP:

1. What error state is returned when upstream auth is missing? (`auth_required` / 401 shape)
2. Which tools are allowed in readonly mode?
3. After sanitize, does `account_id` appear fully or masked?
4. What happens when write-enable env is true during a readonly check? (refuse)
5. Which gate blocks when citation/cache is missing? (product-specific)

## Format (optional XML)

```xml
<evaluation>
  <qa_pair>
    <question>…</question>
    <answer>…</answer>
  </qa_pair>
</evaluation>
```

Store under the product repo `evals/` or `tests/eval/` — do not require a separate runner unless the repo already has one.

## Not for eval

- Questions that require live place/cancel
- Questions whose answers change with market data every minute
- “Does the model feel helpful?” — use gate tests instead
