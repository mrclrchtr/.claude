---
argument-hint: [milestone_name]
description: Execute next milestone from planning to completion
model: claude-sonnet-4-0
---

# Execute Next Milestone

## Context
- Manager: @docs/MILESTONE_MANAGER.md
- Status: !`git status --porcelain --branch && find . -name "M[0-9]*_*.md" -type f | head -5`

## Task
Execute milestone lifecycle:

1. **Select**: $ARGUMENTS > first [WIP] > next open (include sub-milestones)
   - Mark [WIP] if starting new
   - Error: "No milestones available" and exit if none found

2. **Analyze**: Read @$MILESTONE_NAME
   - Verify deliverables vs current implementation
   - STOP if unclear: "Need clarification on: [specific issue]"

3. **Implement**: Complete uncompleted deliverables
   - Mark [X] when done
   - Validate against criteria

4. **Complete**: 
   - Verify all [X] marked
   - Update manager: [DONE]
   - Commit: "feat(milestone): complete $MILESTONE_NAME"

If complex planning needed: Use architecture-planner subagent for milestone breakdown.