---
description: Commit session changes with generated message
model: claude-3-5-haiku-latest
---

# Commit Changed

## Context
- Session changes: !`git status --porcelain && git diff --stat`
- Recent commits: !`git log --oneline -3`

## Task
Stage and commit modified/created files from the current session (chat history).
Generate conventional commit message from changes.