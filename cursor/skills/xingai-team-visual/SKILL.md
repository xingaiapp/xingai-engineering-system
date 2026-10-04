---
name: xingai-team-visual
description: >-
  Generates consistent XingAI team illustrations, team diagrams, character
  posters, About Us graphics, and org visuals using a fixed six-character
  system: 星哥 (founder) plus five leaders 至尊宝, 牛夫人, 小甜甜, 二当家,
  华安（唐伯虎）. Use when the user asks for XingAI team picture, team poster,
  About/Team visual, 华府组织架构, character bible illustration,
  /xingai-team-visual, or wants images that keep the same faces, costumes,
  colors, roles, and hierarchy.
---

# XingAI Team Visual Skill

## Purpose

Generate consistent XingAI team illustrations, team diagrams,
character posters, About Us graphics, product illustrations,
and organizational visuals.

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

If the agent has no image-generation tool (for example Claude Code), see [No image tool](#no-image-tool-claude-code).

## Reference images (Character Bible)

The reference images are the source of truth. If this file and an image disagree, the image wins — then update this file.

| File | Use |
|------|-----|
| [assets/xingai-team-core-five.jpg](assets/xingai-team-core-five.jpg) | 星哥 + five leaders — primary identity bible (16:9) |
| [assets/team-character-bible.webp](assets/team-character-bible.webp) | Character bible card — same six characters, compact layout |
| [assets/xingai-team-org-chart.jpg](assets/xingai-team-org-chart.jpg) | 华府组织架构 — full 55-person org (星哥 · 5 leaders · 20 managers · 30 executors) |
| [assets/xingai-team-org-chart-en.jpg](assets/xingai-team-org-chart-en.jpg) | English edition, 星哥 + five leaders — English names and copy (Xing, Supreme Treasure, Madam Niu, Sweetie, Second Boss, Hua An) |
| [assets/xingai-team-org-chart-ko.jpg](assets/xingai-team-org-chart-ko.jpg) | Korean edition, 星哥 + five leaders — Korean names and copy (별형, 지존보, 우부인, 소첨첨, 이당가, 화안) |
| [assets/xingai-team-org-chart-full-ko.jpg](assets/xingai-team-org-chart-full-ko.jpg) | Korean edition of the full 55-person org chart |

**Core IP = six characters**: 星哥 plus the five first-tier leaders. Default posters show only these six. The org chart's second- and third-tier figures are supporting cast; include them only when the user asks for the full org chart.

Full generation prompts: [references/master-prompt.md](references/master-prompt.md) · [references/reference-continuation.md](references/reference-continuation.md)

---

## Core Team

### 星哥 — Founder / Boss

Role: 愿景 · 战略 · 最终决策 (Vision · Strategy · Final Decision). Sets direction, makes decisions, empowers the team, creates value.

Personality: calm, confident, clever, slightly mysterious.

Visual: mature Chinese male, dark hair with subtle gray, friendly confident smile, dark XingAI hoodie, golden crown, XingAI coffee mug, often seated on a carved wooden chair.

Color: gold / warm yellow.

Position: top center, largest.

### The five leaders (第一层 · 5人负责人)

Default left-to-right order, as in the reference images:

| # | Character | Nameplate role | System | Color |
|---|-----------|----------------|--------|-------|
| 1 | 至尊宝 | 群主 · QA总闸 · 星哥缺席时拍板 | 质量保证体系 (QA) — Quality Gatekeeper | Deep blue |
| 2 | 牛夫人 | 内容策略 · 审改 · 独立复核 | 内容策略体系 — Content Strategy | Purple |
| 3 | 小甜甜 | 发布 · 养号 · 送审 | 发布与增长体系 — Publish & Growth | Pink |
| 4 | 二当家 | 复核 · 重剪 · 核验 | 复核与优化体系 — Recheck & Edit | Green |
| 5 | 华安（唐伯虎） | 代码 · 技术 · 工具 | 技术与工具体系 — Tech & Tools | Sky blue |

#### 1. 至尊宝

Responsibilities: 内容质量把关, 最终审核决策, 风险识别与控制, 确保对外发布质量. Group owner; makes the call when 星哥 is away.

Personality: confident, humorous, decisive.

Visual: Monkey King / wuxia-inspired young man, messy dark hair tied up, golden circlet headband, red scarf, staff on his back, thumbs-up and confident grin.

#### 2. 牛夫人

Responsibilities: 制定内容策略, 内容审核与修改, 独立复核把关, 保证内容质量与合规.

Personality: strong, decisive, demanding.

Visual: elegant woman in dark traditional dress, dark hair in an updo with gold ornaments and tassels, stern expression, pointing at the viewer.

#### 3. 小甜甜

Responsibilities: 多平台内容发布, 账号运营与维护, 提交送审流程, 提升曝光与粉丝增长.

Personality: warm, playful, charming.

Visual: young woman, long dark hair with pink flower ornaments, pink traditional outfit, chin resting on hands, winking, small hearts around her.

#### 4. 二当家

Responsibilities: 视频/内容复核, 重剪与优化, 数据核验与校对, 确保发布符合标准.

Personality: humorous, observant, resourceful.

Visual: wuxia-style man, dark cap with white headband, stubble and mustache, gray traditional robe, gourd at his side, laughing, pointing up.

#### 5. 华安（唐伯虎）

Responsibilities: 开发与技术实现, AI 工具搭建与维护, 技术支持与优化, 提升效率与自动化.

Personality: clever, cheerful, scholarly.

Visual: young scholar, black scholar's hat with white headband, white-and-gray robe with dark trim, holding scrolls / bamboo slips, bamboo behind him, friendly smile.

---

## Visual Language

Use:

- Chinese-inspired modern cartoon
- Wuxia / Chinese fantasy influence
- Hand-painted digital illustration
- Watercolor brush textures
- Clean ink outlines
- Expressive faces
- Soft paper texture, faint ink-wash mountains and pavilions
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
- Additional team members beyond the requested tier

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

Never redesign the characters unless explicitly requested.

**以后不要重新“描述人物”。** Use the Character Bible + reference image. Only describe *composition / theme / format*.

---

## Team Structure

```text
                         星哥
                  Founder / Boss
                          |
   ┌──────────┬──────────┼──────────┬──────────┐
   ↓          ↓          ↓          ↓          ↓
 至尊宝     牛夫人     小甜甜     二当家      华安
  QA       内容策略     发布       复核     技术工具
```

星哥 connects to each of the five leaders with a downward arrow. Each leader owns one system (see the table above). In the full org chart, each leader then has four managers (第二层 20人主管) and six executors (第三层 30人执行).

Do not invent extra relationship lines between the leaders. The only exceptions are the two small symbols in the personality set (see [Standard Nameplates](#standard-nameplates)): ♡ between 至尊宝 and 牛夫人, 💔 between 小甜甜 and 二当家.

---

## Default Composition

For a team poster (personality set, like `assets/xingai-team-core-five.jpg`):

```text
                         星哥
                      神秘大Boss

  至尊宝  ♡  牛夫人     小甜甜  💔  二当家      华安
  嘴最硬     最会追责    最会哄人    背锅侠+情报员  最会写码

          五位负责人 · 一个团队 · 一个使命
```

For an org chart (org-role set, like `assets/xingai-team-org-chart.jpg`):

```text
                         星哥
          Founder / Boss · 愿景 · 战略 · 最终决策

  至尊宝     牛夫人     小甜甜     二当家      华安
  QA总闸     内容策略    发布       复核      代码技术工具
  [system card per leader]  →  optional 第二层 / 第三层
```

Use:

- hand-drawn arrows from 星哥 to each leader
- a colored watercolor circle behind each character
- a colored brush-stroke nameplate per leader, with one line from the chosen nameplate set
- org charts only: one system card or icon row per leader (QA shield, content edit, send/publish, film/recheck, code/tools)
- generous white space

---

## Brand Rules

Brand: XingAI

Positioning: AI for a Smarter, Happier Life

Secondary line: Better Decisions, Brighter Days · 更好的决策 · 更亮的每一天

Team tagline: 五位负责人 · 一个团队 · 一个使命 (Five Leaders · One Team · One Mission)

The XingAI logo should be subtle. Do not allow branding to overpower the characters.

---

## Standard Color Mapping

星哥       → Gold
至尊宝     → Deep blue
牛夫人     → Purple
小甜甜     → Pink
二当家     → Green
华安       → Sky blue

至尊宝 and 华安 are both blue. Keep them distinct: deep navy for 至尊宝, lighter sky blue for 华安. Do not randomly change these colors.

---

## Standard Nameplates

There are two nameplate sets. Both are official. Pick one per image and **never mix them in the same image**.

### Personality set — posters, About / Team page, social, character cards

Source: `assets/xingai-team-core-five.jpg`, `assets/team-character-bible.webp`.

| Character | Nameplate | English tag |
|-----------|-----------|-------------|
| 星哥 | 神秘大Boss | — |
| 至尊宝 | 嘴最硬 | Challenge & QA |
| 牛夫人 | 最会追责 | Operations |
| 小甜甜 | 最会哄人 | Design & UX |
| 二当家 | 背锅侠 + 情报员 | Intelligence |
| 华安（唐伯虎） | 最会写码 | Tech & Tools |

Optional small symbols in this set: ♡ between 至尊宝 and 牛夫人, 💔 between 小甜甜 and 二当家. English tagline: "Five personalities. One mission."

### Org-role set — org charts, 华府组织架构, responsibility / process diagrams

Source: `assets/xingai-team-org-chart.jpg` and its en / ko editions.

星哥 — Founder / Boss · 愿景 · 战略 · 最终决策
至尊宝 — 群主 | QA总闸 | 星哥缺席时拍板
牛夫人 — 内容策略 | 审改 | 独立复核
小甜甜 — 发布 | 养号 | 送审
二当家 — 复核 | 重剪 | 核验
华安（唐伯虎） — 代码 | 技术 | 工具

Use the system names and duty lists from the [five leaders table](#the-five-leaders-第一层--5人负责人) with this set.

### Which set?

- "团队海报", "team poster", About / Team page, social post, character card → **personality set** (default).
- "组织架构", "org chart", who-owns-what, workflow / responsibility diagram → **org-role set**.
- Unclear → ask, or default to the personality set for a single image.

Keep Chinese typography large and readable. Image models often garble small Chinese text; keep nameplate text short, and prefer overlaying text afterward if it comes out wrong.

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

### No image tool (Claude Code)

Claude Code has no built-in image generator. Do not pretend to generate an image. Instead:

1. **Prompt** — read the reference image(s) in `assets/`, then output a ready-to-paste prompt (reference-continuation if the user can attach the reference image to their image tool, master prompt otherwise). State the aspect ratio and tell the user to attach `assets/xingai-team-core-five.jpg`.
2. **Review** — when the user sends back a generated image, read it and go through the [Quality Checklist](#quality-checklist) item by item. If any item fails, give one tighter prompt that names the failures.
3. **Diagrams** — for relationship, org, or layout visuals that do not need new character art, build an SVG / HTML layout that embeds the existing reference image(s) or crops of them instead of new drawings.

---

## Generation Prompt Template

When asked:

"Create XingAI team picture"

use:

"Create a premium XingAI team illustration using the established six-character
visual system.

Use the reference image as the primary character reference.

Preserve the identities of:
星哥, 至尊宝, 牛夫人, 小甜甜, 二当家, 华安（唐伯虎）.

Use the established roles, personalities, colors, costumes and hierarchy:
星哥 on top, the five leaders in one row below.

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

- [ ] Exactly six main characters (星哥 + five leaders), unless a full org chart was requested
- [ ] All six names correct, including 华安（唐伯虎）
- [ ] Nameplates come from one set only (personality or org-role), matching the image's purpose
- [ ] Character personalities and props preserved
- [ ] Character colors preserved; 至尊宝 and 华安 blues distinguishable
- [ ] 星哥 clearly on top; arrows from 星哥 to each leader
- [ ] XingAI branding present but subtle
- [ ] Chinese typography is readable
- [ ] No random people
- [ ] No photorealism
- [ ] No generic corporate style
- [ ] Premium visual quality
- [ ] 16:9 unless otherwise requested

If the checklist fails, regenerate **once** with a tighter constraint list. Do not keep inventing new faces.
