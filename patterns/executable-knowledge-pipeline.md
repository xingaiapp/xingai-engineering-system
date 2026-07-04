# Executable Knowledge Pipeline

Use this pattern when a team's quality standards, conventions, or architectural rules exist only as tribal knowledge or wiki pages and need to become enforceable through AI tooling.

Validated in: XingAI Engineering System (Cursor Rules, Skills, MCP patterns across all products), `xingai-enterprise-ai-design` (Executable Knowledge article).

## Core Rule

**Don't rely on human memory to guarantee quality. Encode team experience as rules, skills, and automated checks that execute on every task.**

```text
Knowledge
      ↓
Executable Knowledge  (CLAUDE.md, Rules, Skills, MCP, Prompts, Hooks)
      ↓
Automation            (runs on every task, every time)
      ↓
Consistency           (same standards at 2 PM and 2 AM)
      ↓
Quality               (higher first-pass success rate)
      ↓
Velocity              (less rework, faster delivery)
```

Velocity is an *output* of the pipeline. Teams that chase it directly by cutting the layers above destroy the thing that produces it.

## The Encoding Ladder

Knowledge moves from least to most executable in predictable steps:

| Level | Where it lives | Enforcement | Failure mode |
|-------|---------------|-------------|--------------|
| 0 — Oral | Senior engineer's brain | None | Engineer leaves, knowledge leaves |
| 1 — Wiki | Confluence, Notion, README | Human must read and remember | Stale docs nobody reads |
| 2 — Rule | `CLAUDE.md`, Cursor Rules | AI reads on every task | Rules need maintenance |
| 3 — Skill | `SKILL.md`, reusable procedures | AI follows multi-step workflow | Skill scope must stay focused |
| 4 — Check | MCP server, CI gate, Hook | Blocks bad output programmatically | False positives slow delivery |
| 5 — Loop | Agent loop with eval + reflect | Self-correcting on every iteration | Needs guardrails (see loop-engineering-three-layer) |

Most teams are stuck at Level 1. The goal is to push critical standards to Level 3–4 where enforcement is automatic.

## What to Encode

Encode standards that are **high frequency** (applied to many tasks) and **high cost if missed** (bugs, security gaps, rework):

| Good candidates | Why |
|----------------|-----|
| API checklist (auth, logging, tests, docs) | Every new endpoint needs these |
| Error handling shape | Inconsistency causes frontend bugs |
| Bilingual doc convention | Easy to forget the .zh.md copy |
| Decision boundary (worker computes, API reads) | Violations cause architecture drift |
| Security baselines (no secrets in code, RLS policies) | One miss = incident |

| Bad candidates | Why |
|----------------|-----|
| Variable naming preferences | Low cost if inconsistent |
| Comment style beyond "no narration" | Subjective, low impact |
| One-off migration steps | Not recurring |

## Encoding Examples

### Level 2 — CLAUDE.md Rule

```md
Every REST API must include:
- JWT authentication
- OpenTelemetry tracing
- Structured logging (JSON, request_id, duration_ms)
- Unit tests (>80% coverage)
- Swagger / OpenAPI documentation
- Health check endpoint
```

AI generates compliant code on every task without being reminded.

### Level 3 — Cursor Skill

A Skill file (`SKILL.md`) that walks the agent through a multi-step process — e.g., "create a new ADR" includes: copy template, assign number, write EN and ZH versions, update README index, update content-backlog.

### Level 4 — MCP Check

`CLAUDE.md` triggers a review MCP after code generation:

```
Generate code → Call architecture-review MCP → Fix findings → Regenerate → Done
```

The MCP checks: security, naming, performance, SQL injection, logging, retry, monitoring. Quality assurance becomes a property of how code gets produced, not a phase after.

## Anti-Patterns

| Anti-pattern | Fix |
|-------------|-----|
| "Everyone knows we do X" | Write it in CLAUDE.md — AI doesn't know until you write it |
| 200-line CLAUDE.md covering everything | Split into focused Cursor Rules per concern |
| Encoding subjective preferences as hard rules | Only encode standards with clear right/wrong |
| Encoding but never maintaining | Review rules quarterly; delete stale ones |
| Skipping Level 2 and jumping to Level 4 | Start with rules, add automation when the rule proves stable |

## Relationship to Other Patterns

This pattern is the **quality-side complement** to [Loop Engineering Three-Layer](./loop-engineering-three-layer.md):

- Loop Engineering answers: *how does the system run autonomously?*
- Executable Knowledge answers: *how does the system maintain quality autonomously?*

Together they form the full AI-native engineering system:

```text
Loop Engineering          Executable Knowledge
(autonomy)                (quality)
       ↘                ↙
        AI-Native Platform
        (velocity as output)
```

## Related Patterns

- [Loop Engineering Three-Layer](./loop-engineering-three-layer.md) — autonomy-side complement
- [Worker-Cache Boundary](./worker-cache-boundary.md) — a Level 2 rule that became a reusable pattern
- [Orchestrator + Trace Governance](./orchestrator-trace-governance.md) — governance rules encoded as trace requirements
