# ADR-004：Team Visual Character System — 共享品牌角色设定

**日期：** 2026-10-04  
**状态：** Accepted  
**作者：** Xing @ XingAI  
**取代：** —  
**被取代：** —  
**Also available:** [English](004-team-visual-character-system.md)

## 背景

XingAI 对外营销与对内材料需要稳定角色班底（星哥 + 各部门负责人）。若无平台约定，每张海报、About 页、幻灯片都会重造脸、服装与层级——品牌会漂。

可复用 skill 在本仓库（`skills/xingai-team-visual/`）。公开 Team 页在 `xingai.app`（`xingai-dot-app`）。组织架构图素材已备好供后续使用；当前上线的营销 Team 页以 Character Bible + 斗嘴房间为主，不默认展示架构图。

## 决策

**同一套 Character Bible 锁定脸、服装、配色与层级。产品与 skill 只消费，不另起第二套班底。**

### 班底（必守）

| 职责 | 角色 | 对外铭牌（EN） |
|------|------|----------------|
| 愿景 / 创始 | 星哥 | Xing Ge · Vision |
| 研究 | 牛夫人 | Mrs. Cow · Research |
| 挑战 | 至尊宝 | Supreme Treasure · Challenge |
| 验证 / QA 总闸 | 小甜甜 | Sweetie · Verify |
| UX / 发布 | 二当家 | Second Boss · UX |
| 技术 / 工具 | 华安（唐伯虎） | Hua An · Tech |

画面层级：**星哥 → 各位负责人**。除非 brief 明确要求架构图模式，不要做成把星哥压成六人平级的「董事会」构图。

### 归属

1. **Character Bible + 生成 skill** → `xingai-engineering-system` / `skills/xingai-team-visual/`（个人 Cursor skill 镜像另装）。
2. **公开 Team 页** → `xingai-dot-app`（`/team`，Character Bible 文案 en/zh/ko，斗嘴房间，`public/brand/team/` 素材）。
3. **组织架构图**（中 / 英 / 韩）留在 skill 素材库供后用；是否挂到营销 Team 页可选，当前延期。

### 新视觉规则

- 优先用 bible / 核心五人（及华安）素材做 **reference-continuation**，少从空白「新角色」起稿。
- 保持 **至尊宝深蓝** 与 **华安天蓝** 可区分。
- 角色铭牌不写内部路线图标签（V1/V2）。
- 跨仓链接用 GitHub URL，不用跨仓本地相对路径。

## 后果

- 团队海报、About 图、营销 Team UI 视觉一致。
- 新增第七位对外负责人时，须同一次改动更新本 ADR + skill bible。
- `xingai-dot-app` 可写产品侧 Team UX，但不得另造第二套角色。

## 已知限制

- 架构图素材就绪，但不是公开 Team 页的默认构图。
- 斗嘴文案与房间动效属 `xingai-dot-app` 产品 UI，不在本 ADR 定义。

## 相关

- Skill：[`skills/xingai-team-visual/SKILL.md`](../../skills/xingai-team-visual/SKILL.md)
- 营销 Team：[xingai-dot-app](https://github.com/xingaiapp/xingai-dot-app)
- ADR-002 Agent Execution Safety（执行门禁；本 ADR 是品牌班底，不是工具执行规则）
