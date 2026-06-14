# System Design Doc Template

Copy this outline when drafting EN + ZH articles. Replace bracketed placeholders.

---

## English — `YYYY-MM-DD-slug.md`

```markdown
---
title: [Clear title — 50–60 chars]
author: [Name]
date: YYYY-MM-DD
tags: [architecture, enterprise, ...]
description: [150–160 char summary for SEO]
---

# [Title]

[Opening question or pain point in plain language.]

**Short answer:** [One or two sentences — readable by a VP.]

![[Title] — System Design UX](../assets/[slug]-system-design-ux.png)

---

## 5W Framework

### What (What is this about?)

| Layer / Component | Role | Orchestrates / Owns |
|---|---|---|
| [Component A] | [Role] | [Scope] |
| [Component B] | [Role] | [Scope] |

[One paragraph scope boundary — what this doc does NOT cover.]

### Who (Who should read this?)

- **[Persona 1]** — [what they take away]
- **[Persona 2]** — [what they take away]
- **[Persona 3]** — [what they take away]

### Why (Why does this matter?)

Without [correct approach]:

- [Consequence 1 — business or risk]
- [Consequence 2 — engineering]
- [Consequence 3 — governance / audit]

With [correct approach]:

- [Benefit 1]
- [Benefit 2]

### When (When do you need this?)

| Stage | What you need |
|---|---|
| MVP / demo | [Minimum] |
| Phase 1 — validation | [POC scope] |
| Phase 2 — integration | [Next layer] |
| Production | [Full platform] |

**Rule:** [One memorable decision rule.]

### Where (Where in the architecture?)

```text
[ASCII stack — 5–8 lines max]
```

---

## How It Works

### End-to-end flow

```text
[Step 1] → [Step 2] → [Step 3] → ...
```

### Component responsibilities

| Component | Input | Output | Tools / deps |
|---|---|---|---|
| [Name] | | | |

### Example: [Scenario name]

[Walk through a concrete request — timestamps, agents, tools, ALLOW/DENY if applicable.]

```text
Step 1 · [Agent/System] · [action] · [duration]
Step 2 · ...
```

---

## Enterprise Pattern Mapping

| Pattern | How this design applies |
|---|---|
| Orchestrator vs MCP Gateway | |
| Trace / governance | |
| Phased roadmap | |

---

## Anti-Patterns

| Anti-pattern | Why it fails | Do instead |
|---|---|---|
| [Bad approach 1] | | |
| [Bad approach 2] | | |

---

## POC / Platform Mapping (if applicable)

| Enterprise concept | Phase 1 (today) | Phase 2+ |
|---|---|---|
| | | |

---

## Related Documents

- [Link 1]
- [Link 2]

---

**Author:** [Name]  
**Published:** [Date]  
**Tags:** [tags]
```

---

## Chinese — `YYYY-MM-DD-slug.zh.md`

Same structure as English. Rules:

- Natural Chinese prose; not literal sentence-by-sentence translation
- Keep: MCP, Orchestrator, Event Bus, Observability, RAG (where standard)
- Same `![...](path)` for PNG — path identical to EN version
- Localize section titles: `5W 框架`, `反模式`, `POC 与平台映射`

---

## Publish Checklist

- [ ] English complete — grammar, links, frontmatter
- [ ] Chinese complete — natural flow, consistent terminology
- [ ] System design UX PNG saved under `assets/` and embedded in both files
- [ ] PNG is architecture poster (not web UI)
- [ ] 5W sections each have table or bullets
- [ ] At least one concrete example (trace, flow, or scenario)
- [ ] Anti-patterns section present
- [ ] Phase boundaries explicit (demo vs production)
- [ ] `ARCHITECTURE-DIAGRAMS.md` updated (if in design repo)
- [ ] README article index updated (if in design repo)
