---
argument-hint: [sub-agent-file-path]
description: Optimize sub-agent for efficiency
model: claude-opus-4-1-20250805
---

# Optimize Sub-Agent

## Context

- Command path: $ARGUMENTS
- Command content: @$ARGUMENTS
- Sub-agent documentation: @.claude/docs/sub-agent.md

## Task

Optimize the sub-agent at $ARGUMENTS by:
- add missing information
- compress existing information without loosing important details
- remove information, that the agent knows by default
