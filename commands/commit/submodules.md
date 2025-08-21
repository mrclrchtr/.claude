---
description: Commit changes within submodules only (excluding parent repository)
allowed-tools: Bash(git:*)
---

# Commit Submodules

> Note: This only commits changes within submodules.
> Use the ".claude/commands/commit/main.md" command afterward to commit submodule pointer updates.
> **Recommended**: Run this command first, then use ".claude/commands/commit/main.md" for pointer updates.

## Context

- Submodule status: !`git submodule foreach --quiet 'echo "=== $displaypath ===" && git status --porcelain'`
- Submodule changes: !`git submodule foreach --quiet 'echo "=== $displaypath ===" && git --no-pager diff --stat'`
- Submodule history: !`git submodule foreach --quiet 'echo "=== $displaypath ===" && git --no-pager log --oneline -3'`

## Task

1. Based on the provided context, for each submodule **with changes detected** span a sub agent in the submodule that:
    - in separate commands (DO NOT COMBINE):
        - `cd` into the submodule
        - `pwd` again to get context
    - Analyze changes for safety issues (secrets, large files, generated content)
    - Stage changes: `git add -A`
    - Generate appropriate conventional commit message
    - Commit within the submodule
2. Do not make further analysis - STOP and report the results for each submodule processed
