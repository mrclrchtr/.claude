---
description: Stage all changes and commit with generated message
model: claude-3-5-haiku-latest
---

# Commit All

## Context
- Changes: !`git status --porcelain && git diff --stat && git log --oneline -3`

## Task
1. Stage all changes: `git add -A`
2. Analyze staged changes and generate conventional commit message
3. Create commit with generated message