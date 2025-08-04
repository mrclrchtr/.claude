---
description: Transform VISION.md into detailed IMPLEMENTATION_PLAN.md using architecture-planner agent
model: claude-opus-4-0
---

# Create Implementation Plan from Vision

## Context

- Vision document: !`test -f docs/VISION.md && echo "✓ Found" || echo "✗ Not found"`

## Task

Use the architecture-planner agent to analyze @docs/VISION.md and create IMPLEMENTATION_PLAN.md.

Architecture-planner should:
1. Extract objectives and requirements
2. Ask clarifying questions for ambiguities
3. Design system architecture with tech stack
4. Create milestone-based strategy with dependencies
5. Define measurable deliverables per milestone
6. Include risk assessment and mitigation
7. Save as @docs/IMPLEMENTATION_PLAN.md

IMPORTANT: Must ask for clarification on unclear requirements before proceeding.