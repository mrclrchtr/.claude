---
description: Optimize CLAUDE.md following Anthropic's memory best practices
allowed-tools: Bash(fd:*),Bash(eza:*),Bash(git:*)
argument-hint: [path/to/CLAUDE.md to optimize]
---

# Optimize CLAUDE.md

## Context
- Path to the CLAUDE.md to optimize: $ARGUMENTS
- All CLAUDE.md files: !`fd --follow -g "CLAUDE.md" . --exclude ".idea" --exclude ".claude"`
- All documentation: !`git ls-files '*.md' --cached --others --exclude-standard`
- Project structure: !`eza . --tree --all --git-ignore --follow-symlinks --ignore-glob=".*|node_modules|dist|build"`

## Task

Comprehensively analyze and optimize @$ARGUMENTS using best practices: @docs/claude-md.md
Ultrathink!

### Optimization Criteria

- **Eliminate redundancy** with existing project documentation
- **Update outdated commands** and replace with current equivalents
- **Preserve project-specific conventions** and critical workflows
- **Focus on actionable instructions** over explanatory text
- **Maintain logical section hierarchy** with clear headings
- **Document only proven, tested patterns**

### Content Constraints

- Project context: <150 words
- Command examples: Include expected outputs where helpful
- Remove all state tracking, progress logs, and historical notes
- Ensure all referenced files/tools actually exist in project

## Analysis Approach

Before optimizing, thoroughly analyze:
1. **Current state**: What works, what doesn't, why it exists
2. **User patterns**: How is CLAUDE.md actually being used?
3. **Failure modes**: What happens when commands break or docs are outdated?
4. **Maintenance burden**: What requires constant updates vs. what's stable?
5. **Edge cases**: Unusual project states, different environments, new team members

Then critique your optimization plan:
- What assumptions am I making about usage patterns?
- Could this optimization make some workflows harder?
- Am I removing something that seems redundant but serves a hidden purpose?

## Expected Output

**Optimized CLAUDE.md** containing:

1. Concise project overview with key technologies
2. Essential documentation references (existing .md files)
3. Updated command library with working examples
4. Core workflows without implementation details
5. Tool configuration patterns specific to this project

**Improvement Report**:

- Word count: before → after
- Removed sections and rationale
- Updated/corrected commands
- Validation that all workflows remain accessible

Ensure the optimized version serves as an effective memory aid for future Claude sessions while eliminating maintenance overhead.
