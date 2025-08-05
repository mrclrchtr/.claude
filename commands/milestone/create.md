---
description: Create a specific milestone from IMPLEMENTATION_PLAN.md
argument-hint: [milestone identifier (e.g. M1, M2, phase1)]
model: claude-opus-4-0
---

# Create Milestone from Implementation Plan

## Context

- Implementation plan: @docs/IMPLEMENTATION_PLAN.md
- Implementation log: @docs/IMPLEMENTATION_LOG.md
- Template: @.claude/templates/milestone-template.md
- Manager: @docs/MILESTONE_MANAGER.md
- Existing: @docs/milestones/

## Task

Create milestone **$ARGUMENTS** using the milestone-planner subagent.

### Process

1. **Validate inputs**
   - If no $ARGUMENTS: "Error: Milestone identifier required (e.g. M1, M2, phase1)" and exit
   - If plan < 50 chars: "Error: Implementation plan too short" and exit

2. **Use @agent-milestone-planner to extract milestone**
   - Find $ARGUMENTS in implementation plan
   - If not found: "Error: Milestone '$ARGUMENTS' not found. Available: [list]" and exit
   - Extract complete milestone content with dependencies

3. **Create milestone document**
   - Filename: `M{major}-{Short_Title}.md` (main milestones), `M{major}_{sub}-{Short_Title}.md` (sub-milestones)
   - If exists: "Warning: {filename} already exists" and exit
   - Apply template structure with extracted content

4. **Update MILESTONE_MANAGER.md**
   - Insert in sequence: `i. [M{major}-{Short_Title}.md](M{major}-{Short_Title}.md) - [ ]` or `i. [M{major}_{sub}-{Short_Title}.md](M{major}_{sub}-{Short_Title}.md) - [ ]`
   - Update counts and dependencies

5. **Complete**
   - "Created: @docs/milestones/{filename}"
   - "Next: Use /milestone/next to start work"

### Error handling
- Keep backups during manager updates
- Restore on failure with clear error message