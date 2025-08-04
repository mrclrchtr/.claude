---
description: Transform VISION.md into detailed IMPLEMENTATION_PLAN.md using architecture-planner agent
argument-hint: [additional context or focus areas]
model: claude-opus-4-0
---

# Create Implementation Plan from Vision

## Context

- Vision document: !`test -f docs/VISION.md && echo "✓ Found" || echo "✗ Not found"`

## Additional context

```
$ARGUMENTS
```

This is an IMPORTANT context provided by the user that should get passed to the agent.
You may analyze and enrich this context before sending it to the agent.

## Task

Use the architecture-planner agent to analyze @docs/VISION.md and create a comprehensive @docs/IMPLEMENTATION_PLAN.md inside @docs.

**IMPORTANT**: 
The agent MUST start by asking clarifying questions about the vision before creating the plan.
It should NOT create the implementation plan until questions are answered by the **user**.
This ensures the plan addresses real constraints and unknowns.

**IMPORTANT**:
Give the **complete** and **unmodified** questions asked by the agent to the user.
