---
description: Commit changes in parent repository only (excluding submodule internals)
allowed-tools: Bash(git:*)
---

# Commit Parent

> Note: This commits parent repository changes and submodule pointer updates.
Commit submodule internal changes separately using the `.claude/commands/commit/submodules.md` command.

## Context
- Current branch: !`git branch --show-current`
- Staged changes: !`git --no-pager diff --stat --cached --summary`
- Unstaged changes: !`git --no-pager diff --stat --summary`
- Recent commit history for context: !`git --no-pager log --oneline -10 --graph`
- Submodule pointer status: !`git --no-pager diff --submodule=log`
- Submodule status: !`git submodule foreach --recursive --quiet 'git status --porcelain 2>/dev/null | grep -q . && echo "UNCOMMITTED: $displaypath" || true'`

## Preflight Check
**Based on the provided context without further analysis:** determine if submodules have uncommitted changes, if so STOP and warn the user to commit submodule changes first with `/commit:submodules`

## Task
1. Analyze parent repo changes for safety issues (secrets, large files, generated content)
2. Stage parent repo changes: `git add -A`
3. If submodule pointers changed, include them in staging: `git add .submodules/`
4. Generate conventional commit message and commit (mention the milestone, if applicable)
5. Report results
