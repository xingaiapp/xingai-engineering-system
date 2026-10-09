# create-project（中文说明）

完整版以同目录 `SKILL.md` 为准。这里是给星哥的速览。

## 干什么

把一个 `*.xingai.app` **做成 Travel 同级的完整网站**，不只是壳：

- 产品主路径 + 内容图（how-it-works / FAQ / compare / guides…）
- `/zh` `/ko`（可选 `/es`）独立网址 + hreflang
- 静态页 + CDN 可缓存（禁止根 layout 用 `headers()` 读语言）
- 标题/描述/OG/JSON-LD 跟网址语言一致
- OG 用 JPEG；法律页；测试 + CI 绿；README 版本笔记

## 和别的 skill 怎么分工

| Skill | 用途 |
|---|---|
| `project-init` | 脚手架 + 视觉硬门槛（图/图标/动效/chrome） |
| `xingai-web-design` | UI 细节与设计系统 |
| `create-project` | Travel 级整站（本 skill） |

新空仓库：先 `project-init`，再按本 skill 的 Phase 做完。

## 必过硬门槛

1. 视觉门槛（project-init）  
2. 多语言路径 + 首屏 HTML/标题一致  
3. 长青页不是 `private, no-store`  
4. sitemap × 语言 + JPEG OG  
5. CI 绿  
6. 法律三页可点  

## 参考实现

`xingai-travel-ai` / https://travel.xingai.app  

细节文档：`references/travel-gold-standard.md`、`locale-static-seo.md`、`website-surface-map.md`、`ship-audit.md`。
