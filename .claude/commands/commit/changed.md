---
allowed-tools: Bash(git add:*, git commit:*, git status:*, git diff:*, git log:*)
description: Commit staged changes with generated message
---

# Commit Changed

## Context
- Staged: !`git diff --cached --stat`
- Recent commits: !`git log --oneline -3`

## Task
Generate conventional commit message from staged changes and commit.