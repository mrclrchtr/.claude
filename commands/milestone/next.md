---
argument-hint: [milestone_name]
description: Execute next milestone from planning to completion
allowed-tools: Bash(git:*), Bash(find:*), Task
---

# Execute Next Milestone

## Context
- Manager: @docs/MILESTONE_MANAGER.md
- Status: !`git status --porcelain --branch && find docs/milestones -name "M*.md" -type f 2>/dev/null | head -5`

## Task

Execute milestone lifecycle. Ultrathink!

### Process

1. **Select**: $ARGUMENTS > first [WIP] > next open (include sub-milestones with format `M{major}_{sub}-{Short_Title}.md`)
   - Mark [WIP] if starting new
   - Error: "No milestones available" and exit if none found

2. **Analyze**: Read @$MILESTONE_NAME
   - Use subagents to verify deliverables vs current implementation (analyze the project/code)
   - Consolidate subagent outputs
   - If unclear: "Need clarification on: [specific issue]" and exit

3. **Implement**: Complete uncompleted deliverables
   - Mark [X] when done
   - Validate against acceptance criteria

4. **Complete**: 
   - Update all relevant docs
      - **CLAUDE.md**: Add/Update/Remove essential information about the project (no status updates)
      - **docs/MILESTONE_MANAGER.md**: Track the status
      - **docs/IMPLEMENTATION_PLAN.md**: Only add/update information if really required
      - **docs/IMPLEMENTATION_LOG.md**: Fill the log with all relevant information from the implementation
         - Add entry to Implementation Timeline with date and brief description
         - Document technical details under the milestone section
         - Record any technical debt discovered
         - Capture lessons learned from challenges
         - Note action items for follow-up
   - Verify all [X] marked
   - Update manager: [DONE]
   - Commit: "feat(milestone): complete $MILESTONE_NAME"

### Error Handling
- If complex planning needed: Use architecture-planner subagent
- Validate all changes before commit
