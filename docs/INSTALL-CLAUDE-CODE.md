# Install Skills Into Claude Code

This guide installs the skills in `cursor/skills/` into Claude Code on another Mac (or any machine). It uses `universal-diagram` as the worked example.

The method is to **symlink, not copy**. Claude Code then reads the skill straight from this repo, so a `git pull` updates every machine.

## How Claude Code Finds Skills

Claude Code loads personal skills from:

```text
~/.claude/skills/<skill-name>/SKILL.md
```

Each skill is a folder that has a `SKILL.md` at its root. Supporting files such as `references/`, `templates/`, and `scripts/` sit beside it. Project-only skills can go in `<project>/.claude/skills/` instead.

## Requirements

- Claude Code (CLI, desktop app, or IDE extension)
- `git`
- For `universal-diagram` PNG export: Google Chrome, Chromium, or Microsoft Edge. `scripts/render.sh` uses headless Chrome to turn SVG into PNG. Without one of them, SVG output still works.

## 1. Clone This Repository

Pick a permanent location. The symlinks point here, so do not move it afterwards.

```bash
git clone https://github.com/xingaiapp/xingai-engineering-system.git ~/code/xingai-engineering-system
```

The examples below assume `~/code/xingai-engineering-system`. Change the path if you cloned it somewhere else.

## 2. Create The Skill Folders

```bash
mkdir -p ~/.claude/skills ~/.cursor/skills
```

## 3. Link One Skill (Example: `universal-diagram`)

```bash
ln -s ~/code/xingai-engineering-system/cursor/skills/universal-diagram ~/.claude/skills/universal-diagram
```

Also link the same folder under `~/.cursor/skills/`. Some skills reference that path. For example, `universal-diagram` runs `~/.cursor/skills/universal-diagram/scripts/render.sh`, and the `draw-it` alias points at `~/.cursor/skills/universal-diagram/SKILL.md`:

```bash
ln -s ~/code/xingai-engineering-system/cursor/skills/universal-diagram ~/.cursor/skills/universal-diagram
```

Optional: add the `/draw-it` alias.

```bash
ln -s ~/code/xingai-engineering-system/cursor/skills/draw-it ~/.claude/skills/draw-it
```

## 4. Or Link Every Skill At Once

This links every folder in `cursor/skills/` that contains a `SKILL.md`. It skips names that already exist in the target folder, so it never overwrites a skill you already have.

```bash
REPO=~/code/xingai-engineering-system; for d in "$REPO"/cursor/skills/*/; do n=$(basename "$d"); [ -f "$d/SKILL.md" ] || continue; for t in ~/.claude/skills ~/.cursor/skills; do [ -e "$t/$n" ] && echo "skip $t/$n (exists)" || ln -s "${d%/}" "$t/$n"; done; done
```

Single-file entries such as `cursor/skills/xingai-brand-story.skill.md` are not folder skills. The loop skips them.

## 5. Verify

```bash
ls -la ~/.claude/skills/
```

Each entry should be a symlink (`->`) into the repo. Then start a **new** Claude Code session, because skills are loaded at session start, and either:

- type `/universal-diagram` (or `/draw-it`), or
- ask in plain words, for example "draw an architecture diagram of …" or "画个图".

To check PNG export:

```bash
~/.claude/skills/universal-diagram/scripts/render.sh ~/code/xingai-engineering-system/cursor/skills/universal-diagram/templates/base.svg /tmp/base.png
```

The command prints the PNG path when it succeeds.

## Update

```bash
git -C ~/code/xingai-engineering-system pull
```

The symlinks pick up the change. Start a new Claude Code session to load it.

## Editing A Skill

Edit the copy in this repo, commit, and push. Other machines get the change with `git pull`.

Do not edit a plain copied folder in `~/.claude/skills/` or `~/.cursor/skills/`. A copy is not tracked by git and drifts from the repo. If a machine already has a copied folder, replace it with a symlink:

```bash
mv ~/.cursor/skills/universal-diagram ~/.cursor/skills/universal-diagram.bak
```

```bash
ln -s ~/code/xingai-engineering-system/cursor/skills/universal-diagram ~/.cursor/skills/universal-diagram
```

Check that nothing in the `.bak` folder is missing from the repo, then delete the backup.

## Uninstall

Remove the symlink only. This does not touch the repo.

```bash
rm ~/.claude/skills/universal-diagram
```

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| Skill does not appear | Start a new session. Check that `~/.claude/skills/<name>/SKILL.md` exists (`ls` follows the symlink). |
| `ln: File exists` | A skill with that name is already installed. Inspect it before replacing it (see "Editing A Skill"). |
| Broken symlink after moving the repo | Remove the link and create it again with the new path. |
| `No Chrome/Chromium/Edge found` | Install one of them, or use the SVG output directly. |
| `Permission denied` on `render.sh` | `chmod +x` the script in the repo. |

## Safety

These skills are public. Do not add secrets, private paths, or private product details to them. Follow [`PRIVACY-SAFETY-CHECKLIST.md`](PRIVACY-SAFETY-CHECKLIST.md) before pushing an edit.
