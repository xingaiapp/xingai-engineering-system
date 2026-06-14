---
name: system-design-docs
description: >-
  Creates bilingual enterprise system design documentation (English + Chinese
  markdown), layered system-design UX mockup PNGs, 5W framework, examples, and
  anti-patterns aligned with XingAI enterprise patterns. Use when writing
  architecture docs, platform design articles, generating architecture poster
  diagrams, or helping non-technical stakeholders and developers share the same
  mental model — not web UI mockups.
---

# System Design Documentation

Use when the user asks to write, update, or review **enterprise system design documentation** — architecture articles, platform docs, ADR companions, or POC architecture writeups.

**Goal:** One doc set that gives **non-technical stakeholders** a clear story and **developers** enough detail to build or extend the system.

Reference examples:

- `xingai-enterprise-ai-design/articles/2026-06-13-orchestrator-vs-mcp-gateway.md` (+ `.zh.md`)
- `xingai-enterprise-ai-pocs/docs/ENTERPRISE-AGENT-PLATFORM.md`
- Assets: `orchestrator-vs-mcp-gateway-ux.png`, `multi-agent-lab-system-design-ux.png`

---

## Workflow Checklist

Copy and track progress:

```text
- [ ] Clarify topic, audience, and phase (MVP vs production)
- [ ] Draft English markdown (5W + examples + anti-patterns)
- [ ] Generate system design UX mockup PNG (NOT web UI)
- [ ] Save PNG under assets/ and embed in EN doc
- [ ] Write Chinese markdown (natural translation, same structure)
- [ ] Add flow.mmd or ASCII diagram if helpful
- [ ] Cross-link related repos / POCs / patterns
- [ ] Update README or ARCHITECTURE-DIAGRAMS.md index
- [ ] Run publish checklist (see template.md)
```

---

## Required Deliverables

Every full doc set includes:

| Deliverable | Path pattern |
|---|---|
| English article | `articles/YYYY-MM-DD-slug.md` or repo-specific `docs/` |
| Chinese article | same slug + `.zh.md` |
| System design UX PNG | `assets/<slug>-system-design-ux.png` |
| Optional deep dive | `architecture.md`, `enterprise-mapping.md` |
| Optional flow | `flow.mmd` |

Embed the PNG **above or immediately after** the executive summary in both languages.

---

## Document Structure

Use [template.md](template.md) for the full outline. Minimum sections:

1. **Frontmatter** — title, author, date, tags, description
2. **Hook** — problem question + short answer (plain language)
3. **UX mockup PNG** — layered system design poster
4. **5W Framework** — What, Who, Why, When, Where (tables preferred)
5. **How** — request flow, component responsibilities, integration points
6. **Concrete examples** — trace timeline, ALLOW/DENY, before/after, demo vs prod
7. **Enterprise patterns** — map to XingAI concepts (see below)
8. **Anti-patterns** — what NOT to build and why
9. **POC / platform mapping** — validated today vs Phase 2+
10. **Related documents** — cross-repo links

---

## Dual-Audience Writing

Write each major section at two levels in one doc — do not split into separate files unless asked.

| Audience | Lead with | Include |
|---|---|---|
| **Non-technical** (leadership, PM, security, legal) | Business problem, phased roadmap, trust/governance story | Short answer, 5W Who/Why/When, one presentable visual, demo narrative |
| **Developers** (architects, senior engineers) | Component boundaries and data flow | Layer table, APIs, trace schema, file paths, stack, extension points |

**Pattern:** Short answer → 5Ws → diagram → deep dive → examples → anti-patterns.

Avoid jargon in the opening paragraph. Define terms once in a table, then use consistently.

---

## 5W Framework

Follow the pattern in `orchestrator-vs-mcp-gateway.md`:

| W | Section focus |
|---|---|
| **What** | Components, layers, scope boundaries |
| **Who** | Reader personas (architect, EM, developer, security, leadership) |
| **Why** | Business and engineering consequences if wrong |
| **When** | Phase/stage — MVP, Phase 1 POC, Phase 2 gateway, production |
| **Where** | Position in architecture stack (ASCII or reference PNG layers) |
| **How** (optional 6th) | End-to-end flow, trace example, integration sequence |

Each W gets its own `###` heading with bullets or a table — not one dense paragraph.

---

## XingAI Enterprise Patterns to Reference

Align docs with patterns already in the ecosystem:

| Pattern | When to cite |
|---|---|
| Orchestrator vs MCP Gateway | Agent orchestration ≠ tool orchestration; no "Orchestration MCP" |
| Agent lifecycle | Request → intent → planning → selection → tools → validation → aggregation |
| Trace / governance | request_id, agent, input, output, tool, duration, timestamp |
| Cache-first before LLM | Hash-based input cache before model calls |
| Worker / cache boundary | Worker computes; API reads cache |
| Phased roadmap | Phase 1 MVP validation → Phase 4 digital workforce |
| Observability | Metrics, logs, trace timeline — not hidden chain-of-thought |

Link to `xingai-engineering-system/patterns/` when relevant.

---

## System Design UX Mockup PNG

**This is an architecture poster — NOT a web/app UI screenshot.**

Use [ux-mockup-prompt.md](ux-mockup-prompt.md) when generating the image.

### Must include

- Title + subtitle + phase badge (e.g. "Phase 1 · MVP Validation")
- Labeled horizontal **layers** (User → API → Orchestrator → Agents → Tools → Data)
- Arrows for request flow and trace/audit side paths
- Side panel: trace timeline, ALLOW/DENY example, or scenario walkthrough
- Bottom **legend** (color = role)
- Footer: repo path, stack keywords

### Must NOT include

- Browser chrome, sidebar nav, form fields, Run buttons
- Product UI mockups (those belong in separate web design work)

### Style

- Dark enterprise theme (#0a0c10 background)
- Purple = orchestration, blue = gateway/API, green = data/governance
- Crisp readable labels; Microsoft/AWS architecture poster quality

Save to `assets/` in the target repo. Register in `assets/ARCHITECTURE-DIAGRAMS.md` when that file exists.

---

## Bilingual Rules

Follow `xingai-enterprise-ai-design/docs/BILINGUAL-POSTS.md`:

1. **English first**, then Chinese
2. **Natural Chinese** — not word-for-word translation
3. **Keep English terms** where standard: MCP, Orchestrator, Event Bus, RAG, Observability
4. **Same PNG and code** in both versions; localize diagram labels only when it helps readability
5. Update repo README article table when publishing to `xingai-enterprise-ai-design`

---

## File Placement by Repo

| Repo | Typical paths |
|---|---|
| `xingai-enterprise-ai-design` | `articles/*.md`, `assets/*.png`, `assets/ARCHITECTURE-DIAGRAMS.md` |
| `xingai-enterprise-ai-pocs` | `docs/ENTERPRISE-*.md`, `pocs/<name>/architecture.md`, `docs/assets/` |
| Product repos | `docs/architecture/`, `docs/adr/` |

---

## Industry Best Practices

Apply without copying vendor branding:

- **C4 mindset** — context → containers → components (use layers in PNG)
- **ADRs for decisions** — link to `templates/adr-template.md` when documenting choices
- **Explicit boundaries** — what is in scope vs Phase 2+
- **Failure modes** — deny paths, fallbacks, demo vs production gaps
- **Traceability** — who did what, when, on which system

Tone: professional, opinionated, practice-oriented (Microsoft Architecture Center / AWS Architecture Blog level).

---

## Common Mistakes

- Web UI screenshot labeled as "architecture diagram"
- 5W section missing or merged into one wall of text
- Chinese version is awkward literal translation
- No concrete example (trace, ALLOW/DENY, before/after)
- No anti-patterns section — readers repeat known mistakes
- Diagram and prose disagree (layers in PNG ≠ layers in text)
- Over-scoping Phase 1 doc with production-only concerns without labeling phase

---

## Related Assets

- Template: [template.md](template.md)
- UX image brief: [ux-mockup-prompt.md](ux-mockup-prompt.md)
- Bilingual guide: `xingai-enterprise-ai-design/docs/BILINGUAL-POSTS.md`
- Skill: `multi-agent-poc` — when doc accompanies a runnable POC
- Prompt: `prompts/architecture-review.md`
- Pattern: `patterns/orchestrator-trace-governance.md`
