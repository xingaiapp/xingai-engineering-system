# 把技能安装到 Claude Code

[English](INSTALL-CLAUDE-CODE.md) · 中文

本指南介绍如何把 `cursor/skills/` 里的技能安装到另一台 Mac（或任意机器）上的 Claude Code，以 `universal-diagram` 为例。

做法是**建软链接，不复制**。这样 Claude Code 直接从本仓库读取技能，每台机器 `git pull` 一下就能更新。

## Claude Code 从哪里找技能

Claude Code 从下面这个位置加载个人技能：

```text
~/.claude/skills/<技能名>/SKILL.md
```

每个技能是一个文件夹，根目录下有一个 `SKILL.md`，`references/`、`templates/`、`scripts/` 等辅助文件和它放在一起。只给某个项目用的技能也可以放在 `<项目>/.claude/skills/` 里。

## 前提条件

- Claude Code（命令行、桌面应用或 IDE 插件都可以）
- `git`
- 如果要用 `universal-diagram` 导出 PNG：需要 Google Chrome、Chromium 或 Microsoft Edge 之一。`scripts/render.sh` 用无界面的 Chrome 把 SVG 转成 PNG。三者都没有的话，SVG 输出照样能用。

## 1. clone 本仓库

选一个固定的位置。软链接都会指向这里，之后不要再挪动。

```bash
git clone https://github.com/xingaiapp/xingai-engineering-system.git ~/code/xingai-engineering-system
```

下面的例子都假设仓库在 `~/code/xingai-engineering-system`。如果你 clone 到了别处，把路径换成你自己的。

## 2. 建好技能文件夹

```bash
mkdir -p ~/.claude/skills ~/.cursor/skills
```

## 3. 链接单个技能（以 `universal-diagram` 为例）

先把仓库里的文件夹链到 `~/.cursor/skills/`。有些技能写死了这个路径，比如 `universal-diagram` 会运行 `~/.cursor/skills/universal-diagram/scripts/render.sh`，`draw-it` 别名也指向 `~/.cursor/skills/universal-diagram/SKILL.md`：

```bash
ln -s ~/code/xingai-engineering-system/cursor/skills/universal-diagram ~/.cursor/skills/universal-diagram
```

再让 Claude Code 指向这条链接（为什么要经过 `~/.cursor`，见[软链布局](#symlink-layout)）：

```bash
ln -s ~/.cursor/skills/universal-diagram ~/.claude/skills/universal-diagram
```

可选：用同样的方式加上 `/draw-it` 别名。

```bash
ln -s ~/code/xingai-engineering-system/cursor/skills/draw-it ~/.cursor/skills/draw-it
```

```bash
ln -s ~/.cursor/skills/draw-it ~/.claude/skills/draw-it
```

## 4. 或者一次链接所有技能

下面的命令会把 `cursor/skills/` 里所有带 `SKILL.md` 的文件夹都链好，用的也是上面的两步布局。同名技能已经存在时会跳过，所以不会覆盖你已有的任何技能，包括本地私有副本（见[软链布局](#symlink-layout)）。

```bash
REPO=~/code/xingai-engineering-system; for d in "$REPO"/cursor/skills/*/; do n=$(basename "$d"); [ -f "$d/SKILL.md" ] || continue; if [ -e ~/.cursor/skills/$n ]; then echo "skip ~/.cursor/skills/$n (exists)"; else ln -s "${d%/}" ~/.cursor/skills/$n; fi; if [ -e ~/.claude/skills/$n ]; then echo "skip ~/.claude/skills/$n (exists)"; else ln -s ~/.cursor/skills/$n ~/.claude/skills/$n; fi; done
```

`cursor/skills/xingai-brand-story.skill.md` 这类单文件条目不是文件夹形式的技能，上面的循环会跳过它们。

<a id="symlink-layout"></a>

## 软链布局

推荐的布局是两跳链接：

```text
~/.claude/skills/<名字>  ->  ~/.cursor/skills/<名字>  ->  <仓库>/cursor/skills/<名字>
     (Claude Code)              (Cursor)                    (唯一来源，在 git 里)
```

为什么这样设计：

- **只有一个切换点。** `~/.cursor/skills/<名字>` 决定两个应用用哪一份。改这一处的指向或者替换它，Claude Code 自动跟着变。
- **`~/.cursor` 路径照常可用。** 写死了 `~/.cursor/skills/...` 的技能（脚本、别名）在两个应用里都能找到文件。
- **`git pull` 一次全部更新。** 不用维护多份副本。

### 链到仓库 vs. 本地私有副本

一台机器的 `~/.cursor/skills/` 里可以同时有两种条目：

| 类型 | 是什么 | 什么时候用 |
|------|--------|------------|
| 链到仓库 | 指向本仓库的软链接 | 默认。公开版本就够用。 |
| 本地私有副本 | 真实文件夹，不在 git 里 | 你的版本需要放一些公开仓库不能有的内容：账号或登录步骤、真实的本机路径、个人数据、私有源文件。 |

本地私有副本的规则：

- **不要**把它们换成软链接，否则会丢掉里面的私有内容。
- **不要**把里面的私有内容复制回本仓库。只能发布脱敏后的版本（见 [`PRIVACY-SAFETY-CHECKLIST.md`](PRIVACY-SAFETY-CHECKLIST.md)）。
- 只在你本机、本仓库里没有的技能，也算本地私有副本，保持原样即可。
- 私有副本会和仓库版本逐渐分叉。隔一段时间用 `diff -r ~/.cursor/skills/<名字> <仓库>/cursor/skills/<名字>` 比对一次，把可以公开的改进手动同步过去。

把任何真实文件夹换成软链接之前，先和仓库版本比对。只有仓库版本包含本地版本的全部内容时，才换成软链接。

### 检查你的布局

下面的命令会列出两个文件夹里的每个技能，显示它是软链接（以及指向哪里）还是真实文件夹：

```bash
for t in ~/.cursor/skills ~/.claude/skills; do echo "== $t"; for p in "$t"/*; do n=$(basename "$p"); if [ -L "$p" ]; then echo "  link   $n -> $(readlink "$p")"; else echo "  local  $n"; fi; done; done
```

如果链接失效了（目标被挪走或删除），它仍会显示为 `link`，但 `ls ~/.claude/skills/<名字>/` 会报错。用正确的路径重新建一次链接即可。

## 5. 验证

```bash
ls -la ~/.claude/skills/
```

每一项都应该是指向仓库的软链接（带 `->`）。然后**新开**一个 Claude Code 会话（技能在会话开始时加载），任选一种方式试一下：

- 输入 `/universal-diagram`（或 `/draw-it`）
- 直接用自然语言说，比如"画一张……的架构图"或"画个图"

检查 PNG 导出：

```bash
~/.claude/skills/universal-diagram/scripts/render.sh ~/code/xingai-engineering-system/cursor/skills/universal-diagram/templates/base.svg /tmp/base.png
```

成功时命令会打印出 PNG 的路径。

## 更新

```bash
git -C ~/code/xingai-engineering-system pull
```

软链接会自动用上新内容。新开一个 Claude Code 会话就能加载。

## 修改技能

改本仓库里的那份，提交并推送。其他机器 `git pull` 就能拿到。

不要直接改 `~/.claude/skills/` 或 `~/.cursor/skills/` 里复制过去的普通文件夹。复制的副本不受 git 管理，会和仓库逐渐分叉。如果某台机器上已经有复制的文件夹，按下面的步骤换成软链接：

```bash
diff -r ~/.cursor/skills/universal-diagram ~/code/xingai-engineering-system/cursor/skills/universal-diagram
```

如果本地副本里没有仓库缺少的内容，就把它移出技能文件夹（留在 `~/.cursor/skills/` 里的 `.bak` 文件夹可能被当成重复的技能加载），然后建链接：

```bash
mv ~/.cursor/skills/universal-diagram ~/universal-diagram.bak
```

```bash
ln -s ~/code/xingai-engineering-system/cursor/skills/universal-diagram ~/.cursor/skills/universal-diagram
```

确认链接后的技能能正常用，再删掉备份。如果本地副本里有私有内容，就把它保留为本地私有副本（见[软链布局](#symlink-layout)）。

## 卸载

只删软链接，不会动到仓库。

```bash
rm ~/.claude/skills/universal-diagram ~/.cursor/skills/universal-diagram
```

## 常见问题

| 现象 | 解决办法 |
|------|----------|
| 技能没有出现 | 新开一个会话。确认 `~/.claude/skills/<名字>/SKILL.md` 存在（`ls` 会顺着软链接找）。 |
| `ln: File exists` | 已经装了同名技能。替换之前先看看里面是什么（见"修改技能"）。 |
| 挪动仓库后软链接失效 | 删掉旧链接，用新路径重新建。 |
| `No Chrome/Chromium/Edge found` | 装其中一个，或者直接用 SVG 输出。 |
| 运行 `render.sh` 报 `Permission denied` | 对仓库里的这个脚本执行 `chmod +x`。 |

## 安全

这些技能是公开的。不要往里面加密钥、私有路径或私有产品细节。推送修改前，先按 [`PRIVACY-SAFETY-CHECKLIST.md`](PRIVACY-SAFETY-CHECKLIST.md) 检查一遍。
