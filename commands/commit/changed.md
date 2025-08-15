---
description: Commit session changes with generated message
model: claude-3-5-haiku-latest
---

# Commit Changed

## Context
- Session changes: !`git status --porcelain && git --no-pager diff --stat`
- Recent commits: !`git --no-pager log --oneline -3`

## Task
Stage and commit modified/created files from the current session (chat history).
Generate conventional commit message from changes.
