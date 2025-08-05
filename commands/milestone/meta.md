---
description: Sync milestone manager with existing milestone files
model: claude-3-5-haiku-latest
---

# Sync Milestone Manager

## Context

- Milestone structure: !`.claude/scripts/create-milestone-structure.sh`
- Current files: !`ls -1 docs/milestones/ 2>/dev/null | grep -E "^M[0-9]+(_[0-9]+)?-.*\.md$" || echo "No milestones found"`

## Task

1. Check @docs/MILESTONE_MANAGER.md
2. Scan @docs/milestones/ for all M*-*.md files (format: `M{major}-{Short_Title}.md` or `M{major}_{sub}-{Short_Title}.md`)
3. Update manager:
   - Add missing milestones as: `i. [@docs/milestones/M{major}-{Short_Title}.md](M{major}-{Short_Title}.md) - [ ]` or `i. [@docs/milestones/M{major}_{sub}-{Short_Title}.md](M{major}_{sub}-{Short_Title}.md) - [ ]`
4. Maintain sequential numbering

If missing files: "Error: Milestone structure not found. Run create-milestone-structure.sh first"
