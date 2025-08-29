---
description: Transform input files into detailed IMPLEMENTATION_PLAN.md using architecture-planner agent
argument-hint: [file1.md file2.md ...]
allowed-tools: Task, Read
---

# Create Implementation Plan from Input Files

## Input Files

Space-separated list of files to analyze:
```
$ARGUMENTS
```

This is an IMPORTANT context provided by the user that should get passed to the agent.
You may analyze and enrich this context before sending it to the agent but do NOT remove any part of it.

## Task

Use the architecture-planner agent that analyzes the specified input files and creates an implementation plan.

**IMPORTANT**:
The agent MUST start by asking clarifying questions about the vision before creating the plan.
It should NOT create the implementation plan until questions are answered by the **user**.
This ensures the plan addresses real constraints and unknowns.

**IMPORTANT**:
Give the **complete** and **unmodified** questions asked by the agent to the user.
