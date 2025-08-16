---
description: Sync milestone manager with existing milestone files
model: haiku
allowed-tools: Bash(.claude/scripts/create-milestone-structure.sh)
---

# Sync Milestone Manager

## Task

1. !`.claude/scripts/create-milestone-structure.sh`
2. Check @docs/MILESTONE_MANAGER.md
3. Scan @docs/milestones/ for all M*-*.md files (format: `M{major}-{Short_Title}.md` or `M{major}_{sub}-{Short_Title}.md`)
4. Update manager:
   - Add missing milestones as: `i. [@docs/milestones/M{major}-{Short_Title}.md](M{major}-{Short_Title}.md) - [ ]` or `i. [@docs/milestones/M{major}_{sub}-{Short_Title}.md](M{major}_{sub}-{Short_Title}.md) - [ ]`
5. Maintain sequential numbering

If missing files: "Error: Milestone structure not found. Run create-milestone-structure.sh first"
