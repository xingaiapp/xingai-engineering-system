# 移动端壳层（XingAI 模式）

## 官网（`xingai-dot-app`）

- 断点：`max-width: 35.99rem`（约 576px）
- **顶栏：** 汉堡菜单 → `MobileNavDrawer`（主导航链接）
- **底部：** `MobileBottomNav`（4 个 Tab，固定底栏 + 安全区 padding）
- **桌面：** 仅顶部导航；无抽屉/底栏
- 参考：`app/components/Header.tsx`、`MobileNavDrawer.tsx`、`MobileBottomNav.tsx`

## 产品应用（meal / cook / routine）

- **顶栏：** 粘性栏约 56px；汉堡 + 品牌 + **语言 + 主题 + 个人资料** 在手机上可见（圆形按钮 36–44px，禁止 110px 巨钮）
- **侧栏：** 完整导航；顶栏拥挤时可在侧栏放语言/主题
- **底栏：** 各产品按实现添加 Tab
- 浅色顶栏/底栏：在 `html[data-theme="light"]` 使用 `var(--header-bg)`

## 规则

1. 不得在移动端隐藏语言/主题/个人资料，除非侧栏有同等入口。
2. 长标题截断（`text-overflow: ellipsis`）；窄屏可隐藏 Logo。
3. 主内容区 `padding-bottom` = 底栏高度 + 安全区。
4. 纯 CSS 应用：主题挂在 `<html data-theme>`；Tailwind v1 应用：`next-themes` + `.dark` 类。
