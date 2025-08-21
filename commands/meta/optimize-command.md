---
argument-hint: [command-file-path]
description: Optimize slash command for efficiency
allowed-tools: Read, Edit, Grep, Bash(find:*), Bash(wc:*), Bash(grep:*), Bash(awk:*), Bash(echo:*)
---

# Optimize Command

## Context
- Command: @$ARGUMENTS
- Optimization Patterns: @.claude/docs/optimization-patterns.md
- Context Gathering: @.claude/docs/context.md

## Optimization Targets

### Purpose of the Command
Ultrathink about the purpose of the command and keep this in mind for every decision in the optimization process.

### Structure (<300 words)
- Use glob patterns over file lists
- Remove politeness and filler text
- Preserve error handling and validation

### Performance
- Apply `optimization-patterns.md` rules
- Model: inherit unless complexity requires specific
- Tools: restrict to minimum needed (3-5 ideal)
- Context: use patterns from @.claude/docs/context.md

### Sub-agents (if applicable)
- Check .claude/agents/ for available specialists
- Reference by clear task mention, not explicit tool call

### Quality Checks
✓ Human-readable/-usable frontmatter
✓ Clear $ARGUMENTS handling
✓ Success validation present
✓ Error recovery preserved
✓ Context minimal but sufficient

## Output
Optimized command with:
1. Metrics: before/after (lines, words, tokens)
2. Changes: what was removed/consolidated
3. Preserved: critical functionality kept
