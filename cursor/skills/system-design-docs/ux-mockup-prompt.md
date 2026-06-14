# System Design UX Mockup — Image Generation Brief

Use this template when calling an image generation tool. Fill bracketed fields from the doc being written.

**Critical:** Architecture poster only — NOT a web application UI.

---

## Prompt template

```text
Professional enterprise system design UX mockup diagram, NOT a web application screenshot.

TITLE: "[Topic] — [Phase] System Design"
SUBTITLE: "XingAI Enterprise [Platform/Product] · [Layer or scope]"
BADGE top-right: "[Phase N] · [MVP Validation | Not Production | Draft]"

STYLE:
- Dark theme background (#0a0c10)
- Layered horizontal architecture bands with glowing accent boxes
- Purple = workflow orchestration / agents
- Blue = API / gateway / tool routing
- Green = data / governance / audit store
- Gray dashed = Phase 2+ planned (ghost boxes)
- Clean sans-serif labels, subtle gradients, arrows, icons
- 16:9 wide format, documentation quality, crisp readable text
- Same visual quality as enterprise architecture posters (Microsoft/AWS style)

LEFT ~65% — LAYERED ARCHITECTURE STACK:

LAYER 1 — [User / Client layer name]
[Box]: [components]. Subtext: "[key actions or endpoints]"

LAYER 2 — [API / Edge layer]
[Box]: [FastAPI / APIM / etc.]. List: "[endpoint or route examples]"

LAYER 3 — [Orchestration layer]
Large purple box with brain icon: "[Orchestrator name — Enterprise Brain]"
Subtext: "[Intent · Planning · Handoffs · Synthesis]"
Badge: "[Phase · file or service path]"

LAYER 4 — [Specialist / domain layer]
[N] boxes in a row: "[Agent/Service A]" | "[B]" | "[C]" | "[D]"
Short label under each: [one-line responsibility]

LAYER 5 — [Tools / integration layer]
Boxes: [tool 1] | [tool 2] | [external API]
Subtext: "[MCP simulated | real MCP | Phase 2 gateway]"
Optional faded ghost: "MCP Gateway Phase 2"

LAYER 6 — [Data / governance layer]
Wide green box: "[Store name]"
Columns: [table 1] | [table 2] | [table 3]
Subtext: "Governance · Audit · Observability source"

FLOW ARROWS:
- Main request path downward through layers
- Dotted arrows from agents/tools to audit/trace store
- Return path: "[Final output description]" back to client

RIGHT ~35% — TRACE / SCENARIO PANEL:
Header: "Trace Timeline · request_id" OR "[Scenario name]"
[4–6 vertical steps with timestamps, durations, Completed status]
Example step format: "Step N · [Agent] · [tool/action] · [Nms] · [short description]"

BOTTOM LEGEND:
[Purple brain] = [meaning]
[Blue shield/box] = [meaning]
[Green database] = [meaning]
[Dashed box] = [Phase 1 simulated / planned]

FOOTER: "[Repo path] · [Stack keywords e.g. FastAPI · SQLite · OpenAI]"

EXCLUDE: browser chrome, sidebar navigation, form fields, Run buttons, product UI mockups.
```

---

## Example (Multi-Agent Lab — condensed)

```text
TITLE: "Multi-Agent Lab — Phase 1 System Design"
Layers: Demo Client → FastAPI → Orchestrator Agent → Research|Product|Tech|Critic → fake_research_tool|cache_tool|OpenAI → SQLite (demo_runs|trace_logs|cache_entries)
Trace panel: 6 steps Orchestrator planning → specialists → synthesis
Ghost: MCP Gateway Phase 2
FOOTER: Multi-Agent Lab POC · pocs/multi-agent-lab · FastAPI · SQLite · OpenAI
```

---

## After generation

1. Save as `assets/[slug]-system-design-ux.png`
2. Copy to `docs/assets/` if platform doc lives in POC repo
3. Embed in EN + ZH markdown with identical relative path
4. Add entry to `assets/ARCHITECTURE-DIAGRAMS.md`

---

## Quality check

- [ ] Readable at slide-deck size (presentable to leadership)
- [ ] Layer names match prose in the markdown doc
- [ ] Phase 2 items visually distinct (dashed / faded)
- [ ] No web UI elements
- [ ] Legend explains color coding
