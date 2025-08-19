---
argument-hint: [command-file-path]
description: Optimize slash command for efficiency
model: sonnet
allowed-tools: Read,Edit,Bash(find:*,wc:*,grep:*),Grep
---

# Optimize Command

## Context
- Command: @$ARGUMENTS
- Size: !`wc -lw < $ARGUMENTS | awk '{print $1" lines, "$2" words"}'`
- Model: !`grep "^model:" $ARGUMENTS || echo "inherited"`
- Tools: !`grep "^allowed-tools:" $ARGUMENTS || echo "unrestricted"`
- Bash calls: !`grep -c "^\!\\\`" $ARGUMENTS || echo "0"`
- Patterns: @.claude/docs/optimization-patterns.md

## Optimization Targets

### Structure (<300 words)
- Combine redundant bash commands
- Use glob patterns over file lists
- Remove politeness and filler text
- Preserve error handling and validation

### Performance
- Apply optimization-patterns.md rules
- Model: inherit unless complexity requires specific
- Tools: restrict to minimum needed (3-5 ideal)
- Bash: use patterns from @.claude/docs/context.md

### Sub-agents (if applicable)
- Check @.claude/agents/ for available specialists
- Reference by clear task mention, not explicit tool call

### Quality Checks
✓ Clear $ARGUMENTS handling
✓ Success validation present
✓ Error recovery preserved
✓ Context minimal but sufficient

## Output
Optimized command with:
1. Metrics: before/after (lines, words, tokens)
2. Changes: what was removed/consolidated
3. Preserved: critical functionality kept
