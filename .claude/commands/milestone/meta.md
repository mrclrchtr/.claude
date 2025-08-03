---
description: Sync milestone manager with existing milestone files
model: claude-3-5-haiku-latest
---

# Sync Milestone Manager

## Context

- Milestone structure: !`.claude/scripts/create-milestones.sh`
- Current files: !`ls -1 docs/milestones/ 2>/dev/null | grep -E "^M[0-9]+_.*\.md$" || echo "No milestones found"`

## Task

1. Check @docs/MILESTONE_MANAGER.md
2. Scan @docs/milestones/ for all M*_*.md files
3. Update manager:
   - Add missing milestones as: `i. [@docs/milestones/MX_DESCRIPTION.md](MX_DESCRIPTION.md) - [ ]`
   - Remove entries marked `[DONE]` or with missing files
4. Maintain sequential numbering

If missing files: "Error: Milestone structure not found. Run create-milestones.sh first"
