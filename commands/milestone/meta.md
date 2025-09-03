---
description: Sync milestone manager with existing milestone files
allowed-tools: Bash(.claude/scripts/create-milestone-structure.sh), Bash(find:*), Bash(fd:*), Bash(test:*), Read, Write, Edit, TodoWrite
---

# Sync Milestone Manager

## Task

1. Ensure structure exists with initialization script `.claude/scripts/create-milestone-structure.sh`
2. Scan @docs/milestones/ for all M*-*.md files (format: `M{major}-{Short_Title}.md` or `M{major}_{sub}-{Short_Title}.md`)
3. Update manager:
   - Add missing milestones as: `i. [M{major}-{Short_Title}.md](M{major}-{Short_Title}.md) - [ ]`
   - Preserve existing status markers ([WIP], [DONE], [X])
4. Maintain sequential numbering

### Error Handling
If missing files: "Error: Milestone structure not found. Run create-milestone-structure.sh first"
