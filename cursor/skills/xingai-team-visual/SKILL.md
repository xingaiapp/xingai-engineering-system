---
name: xingai-team-visual
description: >-
  Generates consistent XingAI team illustrations, team diagrams, character
  posters, About Us graphics, and relationship visuals using a fixed five-character
  system (星哥, 至尊宝, 小甜甜, 牛夫人, 二当家). Use when the user asks for XingAI
  team picture, team poster, About/Team visual, character bible illustration,
  /xingai-team-visual, or wants images that keep the same faces, costumes, colors,
  and hierarchy.
---

# XingAI Team Visual Skill

## Purpose

Generate consistent XingAI team illustrations, team diagrams,
character posters, About Us graphics, product illustrations,
and organizational relationship visuals.

The visual identity must remain consistent across all future images.

**Quick invoke:** `/xingai-team-visual` · “画 XingAI 团队图” · “team picture”.

## First actions when invoked

```text
/xingai-team-visual:
- [ ] 1. Read this skill + attach reference image(s) from assets/
- [ ] 2. Confirm output: poster / about / org / social + aspect ratio
- [ ] 3. Prefer reference-continuation prompt if assets are available
- [ ] 4. Generate → quality checklist → regenerate once if checklist fails
```

## Reference images (Character Bible)

Always prefer these as the primary visual reference when generating:

| File | Use |
|------|-----|
| [assets/xingai-team-core-five.jpg](assets/xingai-team-core-five.jpg) | Core five — primary identity bible |
| [assets/xingai-team-org-chart.jpg](assets/xingai-team-org-chart.jpg) | Extended org / multi-tier layout reference only |

**Core IP = five characters only** for default posters. Do not invent new main characters. The org-chart reference may include extra supporting figures; do **not** promote them into the core five unless the user explicitly asks.

Full generation prompts: [references/master-prompt.md](references/master-prompt.md) · [references/reference-continuation.md](references/reference-continuation.md)

---

## Core Team

The XingAI team contains exactly five recurring characters:

### 1. 星哥

Role:
Founder / CEO / Vision / Strategy

Personality:
Calm, confident, clever, slightly mysterious.

Visual:
Mature Chinese male.
Dark hair with subtle gray.
Friendly confident smile.
Dark XingAI hoodie.
Golden crown.
Coffee mug.

Color:
Gold / warm yellow.

Position:
Usually top center or visual center.

---

### 2. 至尊宝

Role:
Technology / AI / Engineering

Personality:
Confident, humorous, technically powerful.

Visual:
Chinese Monkey King / wuxia-inspired character.
Dark hair.
Headband.
Red scarf.
Staff.
Confident expression.

Color:
Blue.

Position:
Usually left.

---

### 3. 小甜甜

Role:
Design / UX / Product Experience

Personality:
Warm, creative, empathetic, charming.

Visual:
Young Chinese woman.
Long dark hair.
Pink clothing.
Traditional Chinese hair accessories.
Soft smile / playful expression.

Color:
Pink.

Position:
Usually center.

---

### 4. 牛夫人

Role:
Operations / Growth / Quality / Accountability

Personality:
Strong, decisive, demanding.

Visual:
Chinese historical/wuxia-inspired woman.
Elegant dark hair.
Gold ornaments.
Traditional clothing.
Strong serious expression.

Color:
Purple.

Position:
Usually right.

---

### 5. 二当家

Role:
Intelligence / Marketing / Community

Personality:
Humorous, observant, resourceful.

Visual:
Wuxia-style Chinese man.
Gray traditional clothing.
Small hat.
Mustache.
Wine gourd.
Cheerful expression.

Color:
Green.

Position:
Usually bottom center.

---

## Visual Language

Use:

- Chinese-inspired modern cartoon
- Wuxia / Chinese fantasy influence
- Hand-painted digital illustration
- Watercolor brush textures
- Clean ink outlines
- Expressive faces
- Soft paper texture
- Premium startup branding
- Humor
- White space
- Strong visual hierarchy

Avoid:

- Photorealism
- Generic corporate stock photography
- 3D corporate avatars
- Random anime characters
- Excessive visual complexity
- Generic Western superhero aesthetics
- Additional team members

---

## Character Consistency Rule

When a reference image is available:

ALWAYS use the reference image as the primary visual reference.

Preserve:

1. Face characteristics
2. Hair
3. Costume
4. Color
5. Personality
6. Props
7. Character proportions
8. Brush / illustration style

Never redesign the five characters unless explicitly requested.

**以后不要重新“描述人物”。** Use the Character Bible + reference image. Only describe *composition / theme / format*.

---

## Team Relationship Model

The default relationship graph is:

```text
                    星哥
                      |
          ┌───────────┼───────────┐
          ↓           ↓           ↓
       至尊宝       小甜甜       牛夫人
          │           ↑           │
          └──────→ 二当家 ←───────┘
```

Relationships:

星哥 → 至尊宝
Leadership / Technology

星哥 → 小甜甜
Leadership / Product

星哥 → 牛夫人
Leadership / Operations

至尊宝 ↔ 小甜甜
Technology + Design
Positive / playful

小甜甜 ↔ 牛夫人
Design + Operations
Creative tension

至尊宝 → 二当家
Technology + Intelligence

牛夫人 → 二当家
Operations + Intelligence

二当家 → 小甜甜
Intelligence + Product support

Long-term brand mapping:

**星哥 = Vision → 至尊宝 = Build → 小甜甜 = Experience → 牛夫人 = Execute → 二当家 = Intelligence**

---

## Default Composition

For a team poster:

```text
                 星哥
          Founder / Boss

       至尊宝    小甜甜    牛夫人

                 二当家
```

Use:

- hand-drawn arrows
- colored brush strokes
- simple relationship icons
- generous white space
- colored watercolor circles

---

## Brand Rules

Brand:

XingAI

Positioning:

AI for a Smarter, Happier Life

The XingAI logo should be subtle.

Do not allow branding to overpower the characters.

---

## Standard Color Mapping

星哥       → Gold
至尊宝     → Blue
小甜甜     → Pink
牛夫人     → Purple
二当家     → Green

Do not randomly change these colors.

---

## Standard Nameplates

星哥
神秘大Boss

至尊宝
嘴最硬

小甜甜
最会哄人

牛夫人
最会追责

二当家
背锅侠 + 情报员

Keep Chinese typography large and readable.

---

## Output Formats

Default:

16:9 landscape

Suitable for:

- XingAI About page
- Team page
- Landing page
- LinkedIn
- Product presentation
- Pitch deck
- Social media
- Internal team documentation

Alternative:

1:1 square for social media.

4:3 for presentations.

In Cursor: call `GenerateImage` with `aspect_ratio` `16:9` unless the user asks otherwise. Attach / describe the reference image from `assets/`.

---

## Generation Prompt Template

When asked:

"Create XingAI team picture"

use:

"Create a premium XingAI team illustration using the established five-character
visual system.

Use the reference image as the primary character reference.

Preserve the identities of:
星哥, 至尊宝, 小甜甜, 牛夫人, 二当家.

Use the established roles, personalities, colors, costumes and relationship
hierarchy.

Create a polished Chinese-inspired modern cartoon illustration with
hand-painted watercolor textures, clean ink outlines, expressive faces,
premium startup branding and humorous personality.

Do not introduce additional characters.

Do not redesign the characters.

Make the image immediately recognizable as the XingAI team."

For greenfield (no attachable reference), load the full text from [references/master-prompt.md](references/master-prompt.md).

When continuing from an uploaded / skill reference image, use [references/reference-continuation.md](references/reference-continuation.md).

---

## Quality Checklist

Before finalizing:

- [ ] Exactly five main characters
- [ ] All five names correct
- [ ] Character personalities preserved
- [ ] Character colors preserved
- [ ] XingAI branding present but subtle
- [ ] Hierarchy is visually obvious
- [ ] Relationships are understandable
- [ ] Chinese typography is readable
- [ ] No random people
- [ ] No photorealism
- [ ] No generic corporate style
- [ ] Premium visual quality
- [ ] 16:9 unless otherwise requested

If the checklist fails, regenerate **once** with a tighter constraint list. Do not keep inventing new faces.
