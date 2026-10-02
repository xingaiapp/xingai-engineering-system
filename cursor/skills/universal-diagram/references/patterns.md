# Diagram Patterns

Pick the pattern that matches the shape of the idea. Do not force every problem into the same layout.

Layout, flow direction, number of layers, and density adapt. The visual language does not.

| ID | Pattern | Use for | Shape |
|----|---------|---------|-------|
| A | Layered Architecture | software, cloud, security, application architecture | stacked bands, top → bottom |
| B | Flow | processes, workflows, user journeys | steps with a decision split |
| C | Input → Process → Output | AI, RAG, data pipelines, ETL, decision systems | columns left → right |
| D | Hub and Spoke | platforms, shared services, integration ecosystems | central hub, satellites |
| E | Global → Regional → Country | internationalization, localization, global platforms | stacked bands, blue → green → purple |
| F | Before → After | modernization, migration, refactoring, transformation | current/problems → target/benefits |
| G | Comparison | architecture alternatives, build vs buy, option A vs B | equal columns |
| H | Decision Tree | rules, routing, eligibility, AI decisions | question → yes/no → action |
| I | Domain / Capability Map | enterprise architecture, product architecture, business domains | platform band + domain cards |
| J | Timeline | roadmaps, migration, product evolution | now → phases → future |
| K | Sequence | request/response between actors | lifelines + horizontal messages |
| L | Lifecycle | recurring loops | nodes on a ring, clockwise |
| M | Data Flow / Dependency Map | where data moves, what depends on what | sources left, sinks right |
| N | Ecosystem | partners, products, channels around a core | concentric rings |
| O | System Architecture | components and their boundaries | grouped systems + a few directed links |
| P | Pipeline | staged processing with a clear handoff | ordered stages, one direction |

System architecture (O) is the component view. Layered architecture (A) is the stack view. Use A when the story is layers. Use O when the story is who talks to whom.

## Sketches

```
A  USER → APPLICATION → SERVICES → DATA → INFRASTRUCTURE

B  START → STEP 1 → STEP 2 → DECISION
                              ↙        ↘
                            YES         NO

C  INPUT → PROCESS → OUTPUT
   AI / decision variant:  INPUT → PROCESS → INTELLIGENCE → DECISION → OUTPUT
   (ETL and plain data pipelines keep the three-stage form.)

D               SYSTEM A
                   ↑
   SYSTEM B ←  PLATFORM  → SYSTEM C
                   ↓
                SYSTEM D
   (every spoke starts at the hub; arrowheads point to the satellite)

E  GLOBAL → REGIONAL → COUNTRY → CONFIGURATION

F  CURRENT STATE → PROBLEMS → TARGET STATE → BENEFITS

G  OPTION A | OPTION B

H  QUESTION → YES / NO → ACTION

I  PLATFORM
   DOMAIN A | DOMAIN B | DOMAIN C

J  NOW → PHASE 1 → PHASE 2 → FUTURE
```

## Architecture-specific rule

When the subject is architecture, separate global / shared capabilities from local / specialized capabilities:

```
GLOBAL CORE → SHARED SERVICES → REGIONAL CAPABILITIES → COUNTRY CONFIGURATION
```

Only use this structure when that split exists.

## Too many concepts

1. Group related concepts.
2. Remove low-value details.
3. Split into multiple diagrams.
4. Use another slide.
5. Simplify labels.

Never shrink text to make it fit.
