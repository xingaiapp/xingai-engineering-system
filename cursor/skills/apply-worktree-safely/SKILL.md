---
name: apply-worktree-safely
description: >-
  Safely applies changes from a Git worktree back to the main checkout. Use when
  the user mentions apply worktree, worktree changes, source worktree, main
  worktree, or moving agent worktree changes back to main.
---

# Apply Worktree Safely

Use this skill to move changes from a source Git worktree back into the main checkout without merging a branch or pushing automatically.

This is a safer XingAI version of the common apply-worktree flow. It avoids temporary commits, avoids `--no-verify`, checks that both paths share the same repository, and refuses to overwrite untracked destination files silently.

## Rules

- Apply each repo independently.
- Never assume source and main paths. Detect or ask.
- Abort if source and main do not share the same `git-common-dir`.
- Show a diff summary before applying unless the user has already explicitly asked to apply.
- Do not auto-commit or auto-push after applying.
- Do not delete the source worktree unless the user asks.
- Do not overwrite untracked files in main without asking.

## Beginner Mental Model

A Git worktree is another working copy of the same repo. This skill copies the source worktree's current changes back into the main working copy.

It is not a code review, not a merge strategy, and not a deploy command.

## Safe macOS / Linux Flow

Substitute both paths:

```bash
set -euo pipefail

SOURCE_WORKTREE_PATH="<source-worktree>"
MAIN_WORKTREE_PATH="<main-worktree>"

SOURCE_ABS="$(cd "$SOURCE_WORKTREE_PATH" && pwd -P)"
MAIN_ABS="$(cd "$MAIN_WORKTREE_PATH" && pwd -P)"

SOURCE_COMMON="$(cd "$(git -C "$SOURCE_ABS" rev-parse --git-common-dir)" && pwd -P)"
MAIN_COMMON="$(cd "$(git -C "$MAIN_ABS" rev-parse --git-common-dir)" && pwd -P)"

if [ "$SOURCE_COMMON" != "$MAIN_COMMON" ]; then
  echo "ERROR: source and main do not share the same repository." >&2
  exit 1
fi

PATCH_FILE="$(mktemp)"
git -C "$SOURCE_ABS" diff --binary HEAD -- > "$PATCH_FILE"
UNTRACKED_FILES="$(git -C "$SOURCE_ABS" ls-files --others --exclude-standard)"

if [ ! -s "$PATCH_FILE" ] && [ -z "$UNTRACKED_FILES" ]; then
  echo "Nothing to apply."
  rm -f "$PATCH_FILE"
  exit 0
fi

echo "Tracked changes:"
git -C "$SOURCE_ABS" diff --stat HEAD -- || true

echo
echo "Untracked files:"
if [ -n "$UNTRACKED_FILES" ]; then
  echo "$UNTRACKED_FILES"
else
  echo "(none)"
fi

if [ -s "$PATCH_FILE" ]; then
  git -C "$MAIN_ABS" apply --check --3way "$PATCH_FILE"
  git -C "$MAIN_ABS" apply --3way "$PATCH_FILE"
fi

if [ -n "$UNTRACKED_FILES" ]; then
  echo "$UNTRACKED_FILES" | while IFS= read -r f; do
    [ -z "$f" ] && continue
    src="$SOURCE_ABS/$f"
    dst="$MAIN_ABS/$f"
    if [ -e "$dst" ]; then
      echo "ERROR: refusing to overwrite existing file: $f" >&2
      exit 1
    fi
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
  done
fi

rm -f "$PATCH_FILE"

git -C "$MAIN_ABS" status --short
echo "MAIN_WORKTREE=$MAIN_ABS"
echo "SOURCE_WORKTREE=$SOURCE_ABS"
```

## After Applying

1. Review `git status --short` in main.
2. Review `git diff` in main.
3. Run relevant tests/lint.
4. Commit only after review.
5. Ask whether the user wants to delete the source worktree.

## Common Mistakes

- Source and main paths are reversed.
- Source and main are different repos.
- Main already has overlapping local changes.
- Untracked files are copied over existing files.
- Changes are applied and pushed without review.
- Source worktree is deleted before confirming the main copy is correct.
