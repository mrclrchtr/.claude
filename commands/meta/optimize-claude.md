---
description: Optimize CLAUDE.md following Anthropic's memory best practices
model: claude-opus-4-1-20250805
allowed-tools: Bash(eza:*)
---

# Optimize CLAUDE.md

## Context

- Current CLAUDE.md: @CLAUDE.md
- Project structure (without polyglot-benchmark): !`eza --all --tree --git-ignore --ignore-glob="polyglot-benchmark"`

## Task

Use the comprehensively analyze and optimize CLAUDE.md based on:

1. **Memory best practices** from https://docs.anthropic.com/en/docs/claude-code/memory.md (keep .md on calling):
   - Structured information hierarchy
   - Clear command references
   - Workflow documentation
   - No state tracking in CLAUDE.md

2. **Claude prompt engineering** from https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices.md (keep .md on calling):
   - Clear task boundaries
   - Explicit success criteria
   - Tool usage patterns

3. **Optimization targets**:
   - Remove redundancy with existing docs
   - Focus on actionable instructions
   - Maintain clear section hierarchy
   - Document proven patterns only

## Output

Provide optimized CLAUDE.md with:
- Concise project context (<150 words)
- Important docs references
- Updated command references
- Removed state/progress tracking

Report improvements made and word count reduction.
Ultrathink!
