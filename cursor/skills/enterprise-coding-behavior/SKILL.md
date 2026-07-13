---
name: enterprise-coding-behavior
description: >-
  Applies XingAI enterprise coding behavior: Think Before Coding, Simplicity
  First, Surgical Changes, Goal-Driven Execution, Architecture Consistency, and
  Production Mindset. Use when implementing features, fixing bugs, refactoring,
  reviewing agent diffs, writing CLAUDE.md/AGENTS.md fragments, or when the user
  mentions Karpathy skills, over-engineering, drive-by edits, or unverified
  changes.
---

# Enterprise Coding Behavior

Behavioral operating system for XingAI coding agents (Cursor, Claude Code, Codex, and multi-agent POCs).

Adapted from [andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) — not a copy-paste. XingAI adds **Architecture Consistency** and **Production Mindset**, and ties verification to existing XingAI prompts, ADRs, and boundaries.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial one-line copy fixes, use judgment.

Pair with:

- `prompts/code-change.md` — scope / out-of-scope / acceptance
- `prompts/code-review.md` — after the diff
- [agent-roles.md](agent-roles.md) — Planner / Research / Coding / Reviewer / Architect overlays
- [checklists.md](checklists.md) — security, performance, production, MCP
- [ARCHITECT.md](ARCHITECT.md) — drop-in fragment for product `AGENTS.md` / `CLAUDE.md`

---

## Six Principles

### 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:

- State assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them — do not pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- Never invent an API, schema field, env var, or MCP tool that you have not read in-repo or in official docs.
- Read the existing implementation and ADRs first.

Stop and name what is unclear rather than guessing.

### 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No extra configurability that was not requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask: would a senior XingAI engineer call this overcomplicated? If yes, simplify.

### 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

- Do not "improve" adjacent code, comments, or formatting.
- Do not refactor things that are not broken.
- Match existing style even if you would do it differently.
- If you notice unrelated dead code, mention it — do not delete it unless asked.
- Remove imports/variables your change made unused; leave pre-existing dead code alone.

Test: every changed line should trace directly to the user's request.

### 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform vague tasks:

| Vague | Goal-driven |
|-------|-------------|
| Fix the bug | Write/adjust a failing test that reproduces it, then make it pass |
| Add validation | Tests for invalid inputs, then make them pass |
| Refactor X | Tests green before and after |

For multi-step work, state a short plan:

```text
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Weak criteria ("make it work") force constant clarification. Strong criteria let you loop independently.

### 5. Architecture Consistency (Enterprise)

**One project, one way.**

Before changing code:

- Read existing architecture docs / ADRs / patterns in the repo.
- Follow the established pattern; do not introduce a second implementation style.
- Do not invent a new naming convention, folder layout, or parallel stack.
- Prefer extending an existing module over creating a sibling "v2" path.
- For Invest AI: worker owns decisions; FastAPI reads cache — never move decision logic into the request path.
- For MCP / agent tools: go through the gated gateway; fail closed when gates are unwired.

### 6. Production Mindset (Enterprise)

**Runnable is not enough. Think like the on-call.**

For every non-trivial change, check what applies:

| Concern | Ask |
|---------|-----|
| Errors | Explicit failures? User-safe messages? No swallowed exceptions? |
| Logging | Structured logs with request/correlation id where the repo already does? |
| Timeouts / retries | Bounded? Idempotent where retries exist? |
| Config | Env validated? No hard-coded secrets or host paths? |
| Security | Authz, input validation, least privilege, no PII in logs? |
| Observability | Metrics / traces if the surface already has them? |
| Docs | README / ADR / version notes if user-visible, operational, or architectural? |

POCs may omit production hardening — say so explicitly; do not claim "enterprise-ready."

---

## Default Workflow

Copy and track:

```text
Behavior checklist:
- [ ] Assumptions stated (or questions asked)
- [ ] Existing code / ADR / pattern read
- [ ] Smallest plan with verify steps
- [ ] Diff limited to in-scope lines
- [ ] Verification ran (test, typecheck, lint, or smoke)
- [ ] Architecture consistency preserved
- [ ] Production concerns checked or explicitly deferred
```

1. Clarify goal and out-of-scope (use `prompts/code-change.md` when non-trivial).
2. Read neighboring code and ADRs.
3. Implement the smallest diff.
4. Verify with the repo's usual command.
5. Summarize: what changed, how to verify, README/version status.

---

## Anti-Patterns

| Anti-pattern | Do instead |
|--------------|------------|
| "I guess you want…" then code | Ask or present options |
| Factory-of-factories / premature generics | Straight-line code until reuse is proven |
| Drive-by refactor + format sweep | Surgical diff only |
| Ship without running checks | Goal-driven verify loop |
| Second logging/auth/cache style in same repo | Match the first style |
| "It runs locally" as done | Production mindset checklist |

---

## When These Guidelines Are Working

- Diffs are smaller and easier to review
- Fewer rewrites from overcomplication
- Clarifying questions arrive before implementation mistakes
- Architecture stays consistent across agents and PRs

## Attribution

Core four principles inspired by Andrej Karpathy's observations on LLM coding pitfalls, as packaged in [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills). Enterprise principles and XingAI boundary rules are XingAI-specific.
