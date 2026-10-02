---
name: universal-diagram
description: >-
  Designs consistent, presentation-ready 16:9 diagrams — architecture, system
  design, cloud, AI/RAG, data flow, workflow, product, strategy, comparison,
  roadmap, capability map — that share one visual language. Use whenever the
  user asks to create, draw, or make a diagram, /draw-it, "draw it", "画个图",
  "画架构图", "流程图", "做张图解释一下", "architecture diagram", "system diagram",
  "data flow", "capability map", "roadmap visual", "before/after", "option A vs B",
  or wants a concept turned into a slide-ready visual, even if they do not say
  "diagram". Also use to review or redraw an existing diagram for clarity.
  Alias skill: draw-it.
---

# Universal Diagram Design

Version: 1.2

Core principle: **SAME VISUAL LANGUAGE, DIFFERENT INFORMATION ARCHITECTURE.**

The diagram is successful when the viewer understands the main idea quickly without the author explaining every box. An executive should get it within 30 seconds.

## 0. Model and tooling

Keep these separate. Do not assume the reasoning model and the image-generation model are the same model.

```
REASONING
↓
DIAGRAM SPECIFICATION
↓
VISUAL GENERATION
↓
QUALITY CHECK
```

**Reasoning.** Use the strongest available reasoning-capable model to: understand the concept, identify the primary message, extract entities and relationships, select the diagram pattern, define the information hierarchy, write the diagram specification, write the visual-generation prompt, and review the result.

This skill cannot choose the reasoning model. The user or the host session does. Do not name a specific model here; model lineups change faster than this file.

- In ChatGPT, use whichever reasoning model the session is running. If the user asks, recommend the most capable reasoning tier available to them, not a cost-optimized tier.
- In Cursor / CodeX / Claude Code, use the reasoning model configured by the user. Do not switch models yourself.

**Image generation.** Use an image-generation-capable tool when the environment has one and the user wants an actual visual diagram. Do **not** hard-code an image-generation model ID unless the project explicitly requires one. The image side stays model-agnostic.

Preferred chain:

```
Reasoning model
↓
this skill
↓
diagram specification
↓
image generation tool
↓
final diagram
↓
visual quality review
```

A request to create or draw a diagram is an explicit request for a visual. Data-heavy charts, plots, and tables are not this skill — render those from data in code.

## 1. Default behavior

When the user says "create a diagram" (or any trigger in the description) and the intent is clear, do **not** ask questions. Automatically:

1. Understand the topic.
2. Determine the diagram type.
3. Build the information hierarchy.
4. Apply the visual system.
5. Generate the diagram.
6. Validate the visual result.

Ask only when the subject itself is ambiguous (for example "draw our system" with no system named and nothing in the repo to infer). Match the user's language for on-diagram text unless they ask otherwise. If the topic is a codebase, read the code and docs first. Do not invent components.

## 2. Generation pipeline

### Step 1 — Understand

Identify: subject, audience, purpose, main message, important entities, relationships, constraints, desired level of detail.

### Step 2 — Abstract

Convert the request into a conceptual model: actors, systems, components, capabilities, inputs, outputs, dependencies, decisions, layers, boundaries.

When the topic is architecture, identify **global / shared** capabilities versus **local / specialized** capabilities. Only use that split when it is real:

```
GLOBAL CORE → SHARED SERVICES → REGIONAL CAPABILITIES → COUNTRY CONFIGURATION
```

### Step 3 — Select diagram type

Choose the pattern that matches the shape of the idea. Do not force every problem into the same layout. Patterns live in [references/patterns.md](references/patterns.md).

### Step 4 — Information hierarchy

| Level | Content |
|-------|---------|
| L1 | Main concept (title) |
| L2 | Major groups (target 3–7) |
| L3 | Capabilities / components |
| L4 | Examples / supporting details (2–5 bullets) |
| L5 | Notes / constraints (small, gray, or omitted) |

### Step 5 — Apply the visual system

Same design system every time: typography, semantic colors, cards, icons, spacing, arrows, title treatment. Tokens: [references/visual-system.md](references/visual-system.md).

### Step 6 — Diagram specification

Write this internally before generating. Show it to the user only if they asked, or if a non-obvious design choice needs a decision.

```
CANVAS:     16:9 landscape, 1920×1080
TITLE:      Multi-Currency & LatAm Architecture
SUBTITLE:   One global platform with configurable regional capabilities
MESSAGE:    One currency-aware core; countries are added by configuration
PATTERN:    E — Global → Regional → Country
GROUPS:     Global Core (blue) | Regional Localization (green) | Country Config (purple)
COMPONENTS: per group, title + optional icon + 2–5 bullets
RELATIONS:  Core ↓ Localization ↓ Config; dashed = optional / indirect
COLORS:     semantic only — see visual system
ICONS:      semantic only, never decoration
TAKEAWAY:   Add new countries through configuration and capability composition, not platform forks.
```

### Step 7 — Visual prompt

Convert the specification into a precise generation prompt. It must state: composition, layout, hierarchy, **exact text in quotes**, colors, connections, icons, spacing, style, output dimensions (16:9, presentation-ready, high resolution, flat, clean, legible).

Style constraints to include every time: modern enterprise architecture, flat design, minimal decoration, strong hierarchy, generous whitespace, professional typography, simple semantic icons. No people, stock photography, cartoon characters, decorative illustrations, heavy 3D, excessive gradients, or visual noise.

### Step 8 — Generate

**Cursor.** Call `GenerateImage` (cursor namespace). Set `aspect_ratio` to `16:9`. Set `filename` to a short slug such as `diagram-latam-architecture.png`. Put the step-7 prompt in `description`. Do not name an image model.

**Other environments with an image tool.** Use the image-generation capability the host or project provides. Tool names differ by environment (for example, ChatGPT exposes one as `image_gen`). Same rule: no hard-coded model ID.

**No image tool (for example Claude Code).** Skip image generation. Go straight to the SVG path in step 9: author a 1920×1080 SVG from the template and render it to PNG.

The image should be 16:9, presentation-ready, high resolution, clean, legible, and professional. Suitable for PowerPoint, Google Slides, Keynote, LinkedIn, architecture reviews, and technical presentations.

### Step 9 — Quality check

Read the generated image. Judge the pixels, not the prompt.

- [ ] Is the title correct?
- [ ] Is the main message obvious?
- [ ] Are relationships correct?
- [ ] Are arrows clear?
- [ ] Are labels readable and spelled correctly?
- [ ] Are colors semantically correct?
- [ ] Is anything duplicated?
- [ ] Is anything missing?
- [ ] Is the diagram too crowded?
- [ ] Does the visual hierarchy work (L1 → L2 → L3)?
- [ ] Could an executive understand it within 30 seconds?

If it fails, simplify (fewer groups, shorter labels) and regenerate **once**.

If labels are still wrong, clipped, or unreadable, stop using image generation for this diagram. Author a 1920×1080 SVG from [templates/base.svg](templates/base.svg) using the tokens in [references/visual-system.md](references/visual-system.md), then render:

```bash
~/.cursor/skills/universal-diagram/scripts/render.sh path/to/diagram.svg
```

In Claude Code the same script lives under `~/.claude/skills/universal-diagram/scripts/`.

Read the PNG and run the checklist again. Text in the SVG path is exact; prefer it whenever labels must be perfect.

Save the file next to the work it belongs to (a repo's `docs/diagrams/` when that exists). If there is no obvious home, leave the generated file where the tool wrote it and tell the user the path.

Reply briefly: what the diagram shows, the pattern chosen, the takeaway, and the file path.

## 3. Visual language (must hold)

Modern enterprise architecture style. Clean presentation design. Flat. Minimal decoration. Strong hierarchy. Generous whitespace. Professional typography. Simple semantic icons.

Do not use: people, stock photography, cartoon characters, decorative illustrations, heavy 3D, excessive gradients, visual noise, unnecessary decoration.

**Colors are semantic. Do not use them randomly.**

| Color | Meaning |
|-------|---------|
| Blue | Global / core / platform / primary |
| Green | Regional / localization / extension / success |
| Purple | Configuration / supporting capability / optional |
| Yellow | Key decision / goal / insight |
| Red | Risk / problem / anti-pattern |
| Gray | Secondary information |

**Title.** Short, clear, bold, executive-friendly. Optional one-line subtitle that states the message.

**Cards.** Title, optional icon, 2–5 concise bullets. No paragraphs.

Good: `Currency Management` — currency codes, precision, rounding, FX.

Bad: "This component is responsible for managing all currency-related operations across the platform..."

**Labels.** `Global Core`, not "The global core platform shared by all countries." `FX Management`, not "Management of foreign exchange rates across multiple currencies." Detailed explanations belong outside the diagram.

**Icons.** Simple and semantic: globe = global, location = regional, flag = country, database = data, gear = service, shield = security, document = invoice, card = payment, exchange arrows = FX, cube = platform, AI mark = intelligence, user = actor. Icons must improve comprehension. They must not become decoration.

**Connections.** `↓` dependency / flow. `→` interaction. `↔` bidirectional. Dashed = optional / indirect. Avoid crossing arrows, excessive arrows, and ambiguous connections.

**Density.** 3–7 major visual groups. If there are too many concepts: group related ones, remove low-value details, split into multiple diagrams, use another slide, simplify labels. Never make text tiny to fit everything. Minimum 18px at 1920px wide.

**Takeaway.** One primary takeaway per diagram, written for this topic. Optional bottom banner labeled `KEY PRINCIPLE` or `KEY TAKEAWAY`.

**Consistency.** Keep typography, color semantics, card style, icon style, spacing, borders, title treatment, background, and visual hierarchy the same. Adapt layout, flow direction, number of layers, number of components, diagram pattern, and information density to the actual problem. Consistency does not mean identical layouts.

## 4. References

- [references/patterns.md](references/patterns.md) — which pattern to pick
- [references/visual-system.md](references/visual-system.md) — canvas, type, color tokens, cards, arrows
- [templates/base.svg](templates/base.svg) — exact-text fallback
- [scripts/render.sh](scripts/render.sh) — SVG → PNG
