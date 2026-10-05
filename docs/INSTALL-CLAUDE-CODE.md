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

Link the repo folder into `~/.cursor/skills/` first. Some skills reference that path. For example, `universal-diagram` runs `~/.cursor/skills/universal-diagram/scripts/render.sh`, and the `draw-it` alias points at `~/.cursor/skills/universal-diagram/SKILL.md`:

```bash
ln -s ~/code/xingai-engineering-system/cursor/skills/universal-diagram ~/.cursor/skills/universal-diagram
```

Then point Claude Code at that link (see [Symlink Layout](#symlink-layout) for why it goes through `~/.cursor`):

```bash
ln -s ~/.cursor/skills/universal-diagram ~/.claude/skills/universal-diagram
```

Optional: add the `/draw-it` alias the same way.

```bash
ln -s ~/code/xingai-engineering-system/cursor/skills/draw-it ~/.cursor/skills/draw-it
```

```bash
ln -s ~/.cursor/skills/draw-it ~/.claude/skills/draw-it
```

## 4. Or Link Every Skill At Once

This links every folder in `cursor/skills/` that contains a `SKILL.md`, using the same two-step layout. It skips names that already exist, so it never overwrites a skill you already have, including a private local copy (see [Symlink Layout](#symlink-layout)).

```bash
REPO=~/code/xingai-engineering-system; for d in "$REPO"/cursor/skills/*/; do n=$(basename "$d"); [ -f "$d/SKILL.md" ] || continue; if [ -e ~/.cursor/skills/$n ]; then echo "skip ~/.cursor/skills/$n (exists)"; else ln -s "${d%/}" ~/.cursor/skills/$n; fi; if [ -e ~/.claude/skills/$n ]; then echo "skip ~/.claude/skills/$n (exists)"; else ln -s ~/.cursor/skills/$n ~/.claude/skills/$n; fi; done
```

Single-file entries such as `cursor/skills/xingai-brand-story.skill.md` are not folder skills. The loop skips them.

## Symlink Layout

The recommended layout is a two-hop chain:

```text
~/.claude/skills/<name>  ->  ~/.cursor/skills/<name>  ->  <repo>/cursor/skills/<name>
     (Claude Code)              (Cursor)                    (source of truth, in git)
```

Why this shape:

- **One switch point.** `~/.cursor/skills/<name>` decides which copy both apps use. Repoint or replace that one entry and Claude Code follows.
- **`~/.cursor` paths keep working.** Skills that hard-code `~/.cursor/skills/...` (scripts, aliases) resolve the same way in both apps.
- **`git pull` updates everything.** No copies to keep in sync.

### Repo-linked vs. private local copies

A machine can mix two kinds of entries in `~/.cursor/skills/`:

| Kind | What it is | When to use it |
|------|------------|----------------|
| Repo-linked | Symlink into this repo | Default. The public version is all you need. |
| Private local copy | A real folder, not tracked by git | Your version needs details this public repo must not hold: account or login steps, real machine paths, personal data, private source files. |

Rules for private local copies:

- Do **not** replace them with symlinks. You would lose the private details.
- Do **not** copy their private details back into this repo. Publish only a scrubbed version (see [`PRIVACY-SAFETY-CHECKLIST.md`](PRIVACY-SAFETY-CHECKLIST.md)).
- Skills that exist only on your machine and not in this repo are private local copies too. Leave them as they are.
- A private copy drifts from the repo over time. Compare it now and then with `diff -r ~/.cursor/skills/<name> <repo>/cursor/skills/<name>` and port public-safe improvements by hand.

Before you replace any real folder with a symlink, compare it with the repo copy. Link it only when the repo copy has everything the local one has.

### Check Your Layout

This lists every skill in both folders and shows whether it is a symlink (and where it points) or a real folder:

```bash
for t in ~/.cursor/skills ~/.claude/skills; do echo "== $t"; for p in "$t"/*; do n=$(basename "$p"); if [ -L "$p" ]; then echo "  link   $n -> $(readlink "$p")"; else echo "  local  $n"; fi; done; done
```

A broken link (target moved or deleted) shows up as `link` but `ls ~/.claude/skills/<name>/` fails. Recreate it with the right path.

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
diff -r ~/.cursor/skills/universal-diagram ~/code/xingai-engineering-system/cursor/skills/universal-diagram
```

If the local copy has nothing the repo lacks, move it out of the skills folder (a `.bak` folder left inside `~/.cursor/skills/` can load as a duplicate skill) and link:

```bash
mv ~/.cursor/skills/universal-diagram ~/universal-diagram.bak
```

```bash
ln -s ~/code/xingai-engineering-system/cursor/skills/universal-diagram ~/.cursor/skills/universal-diagram
```

Delete the backup once the linked skill works. If the local copy holds private details, keep it as a private local copy instead (see [Symlink Layout](#symlink-layout)).

## Uninstall

Remove the symlinks only. This does not touch the repo.

```bash
rm ~/.claude/skills/universal-diagram ~/.cursor/skills/universal-diagram
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
