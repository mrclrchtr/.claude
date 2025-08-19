---
argument-hint: [sub-agent-file-path]
description: Optimize sub-agent for efficiency
model: sonnet
allowed-tools: Read,Edit,Bash(git:*),Grep
---

# Optimize Sub-Agent

## Context
- Agent: @$ARGUMENTS
- Token usage: !`wc -c < $ARGUMENTS | awk '{print int($1/4)" tokens (est)"}'`
- Tools defined: !`grep -c "^tools:" $ARGUMENTS || echo "inherited"`
- Patterns: @.claude/docs/optimization-patterns.md

## Analysis Checklist
1. **Trigger effectiveness** (description field):
   - Contains "MUST BE USED PROACTIVELY" or similar?
   - Specific conditions clearly stated?
   
2. **Token efficiency**:
   - Minimal tool set for task? (target: 3-5 tools, <5K tokens)
   - Appropriate model? (haiku for simple, sonnet for complex)
   - Context gathering optimized?

3. **Bash commands** (if present):
   - Using `--no-pager` for git?
   - Output limited with `head/tail/wc`?
   - Parallel execution where possible?

## Optimization Tasks

Apply these improvements to $ARGUMENTS:

### Structure
- Compress instructions to essential directives
- Remove AI default knowledge (politeness, basic coding)
- Preserve critical domain expertise and constraints

### Performance
- Apply patterns from optimization-patterns.md
- Test bash commands: !`grep "^\!" $ARGUMENTS | wc -l` found
- Verify context patterns against @.claude/docs/context.md

### Validation
- Activation phrase strength (85%+ target)
- Tool-to-task alignment
- Success criteria present

## Output
Provide optimized agent with:
1. Token reduction achieved
2. Key improvements made
3. Elements preserved for reliability
