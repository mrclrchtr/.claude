---
allowed-tools: Bash(git add:*, git commit:*, git status:*, git diff:*, git log:*)
description: Stage all changes and commit with generated message
---

# Commit All

## Context
- Status: !`git status --porcelain`
- Changes: !`git diff --stat`
- Recent commits: !`git log --oneline -3`

## Task
Stage all changes, generate conventional commit message from diff, and commit.