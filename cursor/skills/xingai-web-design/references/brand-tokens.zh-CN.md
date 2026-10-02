# XingAI 品牌 Token（健康 / 生活方式类）

新 UI 的权威来源：`xingai-meal-coach-ai/meal_v1/app/globals.css`。

## 浅色（`:root`）

```css
--background: oklch(0.985 0.004 145);
--foreground: oklch(0.22 0.02 150);
--primary: oklch(0.52 0.19 145);
--primary-foreground: oklch(0.99 0 0);
--card: oklch(1 0 0);
--secondary: oklch(0.96 0.015 145);
--muted-foreground: oklch(0.45 0.03 145);
--border: oklch(0.9 0.02 145);
--input: oklch(0.925 0.015 145);
--ring: oklch(0.52 0.19 145);
--radius: 1rem;
```

## 深色（`.dark`）

```css
--background: oklch(0.14 0.01 145);
--foreground: oklch(0.98 0 0);
--primary: oklch(0.62 0.18 145);
--card: oklch(0.19 0.02 145);
--border: oklch(0.3 0.03 145);
--muted-foreground: oklch(0.72 0.02 150);
```

## 纯 CSS 应用（meal_v4 风格）

语义别名映射：`--card`、`--muted`、`--label`（= muted-foreground）、`--input-bg`（= input）、`--header-bg`、`--chrome-bg`、`--panel-shadow`。

使用 `data-theme` 切换时，在文档根节点设置 `html[data-theme="light"]` / `html[data-theme="dark"]`。

## xingai.app 官网

使用 `xingai-dot-app/app/globals.css` 中的 `--page-bg`、`--ink-strong`、`--blue` 等变量。改官网前先读该文件，勿直接把 Meal 应用的 token 硬套过来。

## SAT（`sat.xingai.app`）

- 仓库：`xingai-sat-ai/app/globals.css` — **青绿品牌色** **oklch hue ~165**（试用；与 Meal ~145 区分）。成功态 `--good` 为 hue ~142。
- 与 meal_v4 相同的 chrome：`html[data-theme]`、Plus Jakarta Sans、柔和 `--hero-glow`（避免整页浓品牌色渐变）。
- 顶栏：移动端保留语言 / 主题 / 个人资料；侧栏重复语言与主题。
