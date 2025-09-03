---
description: Create a specific milestone from IMPLEMENTATION_PLAN.md
argument-hint: [milestone identifier (e.g. M1, M2, phase1) and/or context files]
allowed-tools: Bash(find:*), Task, Read, Edit, TodoWrite
---

# Create Milestone from Implementation Plan

## Context

- Implementation plan: @docs/IMPLEMENTATION_PLAN.md
- Template: @.claude/templates/milestone-template.md
- Manager: @docs/MILESTONE_MANAGER.md
- Existing: @docs/milestones/

## Task

Create milestone using the @milestone-planner subagent for:

```
$ARGUMENTS
```

### Process

1. **Validate inputs**
    - If no arguments: "Error: At least milestone identifier required (e.g. M1, M2, phase1)" and exit
    - If plan < 50 chars: "Error: Implementation plan too short" and exit

2. **Gather context files**
    - If additional files provided: Verify they exist, else "Error: File '$ARGUMENTS' not found" and exit
    - If none provided: Use @docs/IMPLEMENTATION_PLAN.md
    - Gather additional relevant files (e.g. related docs, code snippets)

3. **Create a Plan and tell it the user**
    - Print all relevant information and files you will pass to the sub-agent

4. **Create the milestone(s)**
    - Find the Milestone in implementation plan
    - If not found: "Error: Milestone '$ARGUMENTS' not found. Available: [list]" and exit
    - Use a separate @agent-milestone-planner sub-agents for each milestone!
    - Pass all relevant data to the sub-agent including relevant files

5. **Update MILESTONE_MANAGER.md**
    - Insert in sequence: `i. [M{major}-{Short_Title}.md](M{major}-{Short_Title}.md) - [ ]`
    - Update counts and dependencies

6. **Complete**
    - "Created: @docs/milestones/{filename}"
    - "Next: Use /milestone/next to start work"

### Error Handling
- Keep backups during manager updates
- Restore on failure with clear error message

> **IMPORTANT**:
> Use sub-agent(s) to create the milestone files.

> **IMPORTANT**:
> The agent MUST start by asking clarifying questions about the vision before creating the plan.
> It should NOT create the implementation plan until questions are answered by the **user**.
> This ensures the plan addresses real constraints and unknowns.

> **IMPORTANT**:
> Give the **complete** and **unmodified** questions asked by the agent to the user.

Ultrathink!
