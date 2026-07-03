# ADR-001：Personal Memory Engine —— 跨产品用户上下文

**日期：** 2026-07-01
**状态：** 已接受
**作者：** Xing @ XingAI
**取代：** —
**被取代：** —
**英文版：** [English](001-personal-memory-engine.md)

## 背景

XingAI 的各产品（Invest AI、Meal AI、SAT AI、Decision Engine、Opportunity Radar）各自维护独立的用户画像。用户在 Meal AI 中填写了"我有脂肪肝"，在 Invest AI 中填写了"我 55 岁，保守型风险承受能力"，但这些上下文无法跨产品共享。每个产品都从零开始。

这造成了三个问题：

1. **重复输入** —— 用户必须在每个产品里重新输入相同的个人背景。
2. **跨领域洞察缺失** —— "保守型投资者 + 脂肪肝 + 55 岁"是一个连贯的健康-财务画像，理应同时改善投资风险建议和膳食计划；但两个产品都看不到全貌。
3. **Decision OS 没有基础** —— XingAI 产品愿景（个人决策操作系统）需要一个跨所有推荐领域持久保存上下文的记忆层。

## 决策

### Personal Memory Engine 存储的内容

```
UserMemory
├── user_id                string   — Supabase auth 用户 id
├── age                    int?
├── goals                  string[] — 例如 ["60岁退休", "减重20斤", "女儿考医学院"]
├── constraints            string[] — 例如 ["不喝酒", "低钠饮食", "保守型投资者"]
├── health_conditions      string[] — 例如 ["fatty_liver", "high_blood_pressure"]
├── financial_profile      object   — { risk_tolerance, investment_horizon, monthly_savings, net_worth_range }
├── family_members         object[] — [{ role, age, health_conditions[], goals[] }]
├── preferences            object   — 按产品键控 { meal: {...}, invest: {...}, sat: {...} }
├── decision_style         enum?    — "analytical" | "intuitive" | "collaborative"
├── language               enum     — "en" | "zh" | "ko"
├── updated_at             datetime
└── version                int      — 乐观并发
```

### 存放位置

`UserMemory` 存储在 **Supabase**（PostgreSQL）中，新建 `user_memory` 表，每个用户一行。这是唯一使用共享数据库的跨产品 XingAI 资源——理由如下：

- Auth 已经在 Supabase；这是对 auth 用户的扩展，不是新服务。
- Memory 是用户范围的；热路径中没有跨用户查询（无跨用户 JOIN）。
- 替代方案（每个产品轮询其他所有产品的 memory 接口）会随产品增长形成 O(N²) 依赖图。

### 读取路径

每个产品的 FastAPI 层在请求时通过用户的 `user_id` 读取 `user_memory`。这是一次快速主键查找（< 5ms）。结果由 worker 注入 LLM system prompt——不单独缓存，因为记忆变化频率低，但过期 prompt 的代价高。

### 写入路径

Memory 由以下方式写入：
1. **用户显式输入** —— 任何产品的设置/个人资料页面。
2. **Worker 推断** —— 当 worker 从用户的决策历史中检测到新的约束条件（例如，用户连续 3 次忽略高钠膳食计划 → worker 在 `constraints` 中加入 `"low_sodium"`）。Worker 推断的更新进入 `pending_memory_update` 队列；在写入前向用户展示确认界面。

任何产品都不直接写入另一个产品的表。Memory 写入通过部署在 Fly.io 上的轻量 `memory-service` FastAPI 发送到共享的 `user_memory` 表。

### 留在产品本地的内容

- 领域专属推荐历史（Invest AI 每日简报、Meal AI 膳食计划）
- Decision Ledger 行（[decision-ledger-schema.md](../patterns/decision-ledger-schema.md)）—— 保留在各产品本地
- 详细财务持仓、膳食日志 —— 产品特定内部数据

规则：**对其他产品有用的内容属于 `user_memory`；只在一个产品内有意义的内容留在本地。**

## 后果

正面：
- 用户的上下文跨 XingAI 产品随身携带，无需重复输入。
- 随着用户画像的丰富，每个产品的 LLM system prompt 自动变得更好。
- 支持跨领域推荐（例如："鉴于您保守的财务画像和脂肪肝情况，建议避免交易高波动性股票——以下是 Invest AI 和 Meal AI 共同支持这一建议的原因"）。

代价：
- 共享数据库是逐产品边界规则的例外；通过 auth 同库和主键访问模式来合理化，但绝不能扩展到跨用户查询。
- Worker 推断的记忆更新需要确认步骤——增加 UX 复杂度，但对防止静默画像变更是必要的。
- 隐私面扩大：`user_memory` 包含敏感的健康和财务数据；Supabase 行级安全策略是强制要求。

## 隐私和安全要求

- Supabase 行级安全（RLS）策略：所有操作都要求 `user_id = auth.uid()`。
- `health_conditions` 和 `financial_profile` 在应用日志中绝不以明文记录。
- 用户可以在任何 XingAI 产品的"我的资料"页面查看、编辑和删除所有 `user_memory` 内容。
- GDPR/CCPA：`DELETE /api/memory` 硬删除该行，并触发各产品 decision ledger 的级联删除。

## 曾考虑的替代方案

- **每个产品存储自己的记忆切片** —— 拒绝；创建 O(N²) 轮询图，要求用户更新上下文 N 次。
- **独立记忆服务配单独数据库** —— 推迟到 v2；Supabase 同库在当前规模下已足够，且避免了新的部署。
- **纯 LLM 推断记忆（无显式画像）** —— 拒绝；隐式推断对用户不透明，难以纠正。

## 相关

- [patterns/decision-ledger-schema.md](../patterns/decision-ledger-schema.md)
- [patterns/worker-cache-boundary.md](../patterns/worker-cache-boundary.md)
- [Invest AI ADR-005：法律免责声明](https://github.com/xingaiapp/xingai-invest-ai/blob/main/docs/adr/005-legal-disclaimers-v1.md)
