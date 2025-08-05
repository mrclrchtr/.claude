---
argument-hint: [command-file-path]
description: Optimize slash command for efficiency
model: claude-opus-4-1-20250805
---

# Optimize Command

## Context

- Command path: $ARGUMENTS
- Command content: @$ARGUMENTS
- Existing commands: !`find .claude/commands ~/.claude/commands -name "*.md" -type f 2>/dev/null | head -20`

## Task

Optimize the slash command at $ARGUMENTS following these principles:

### Core Optimization Principles
1. **Clarity over brevity** - Remove bloat but keep workflow-critical details
2. **Preserve robustness** - Keep validation, error messages, and recovery
3. **Name dependencies** - Keep sub-agent references visible

### Quick Reference
See @.claude/docs/command.md for complete slash command documentation and structure.

### Optimization Process

1. **Analyze current command**:
   - Review context gathering (combine bash commands, remove duplicates)
   - Evaluate task clarity and word count

2. **Apply optimizations**:
   - Combine bash commands: `git status && git diff --stat` instead of separate calls
   - Use glob patterns: `@src/components/*.js` instead of listing files
   - Remove politeness: "Analyze" not "Please analyze"
   - Preserve error handling and user guidance

3. **Model selection**:
   - `claude-3-5-haiku-latest`: Simple operations, standard commits
   - `claude-sonnet-4-0`: Complex analysis, multi-file refactoring
   - `claude-opus-4-1-20250805`: Architecture planning, Implementation planning, Milestone planning

4. **Sub-agent references**:
   - Use sub-agent references if applicable.
   - Request specific subagents by mentioning them:
     ```
     >    Use the test-runner subagent to fix failing tests
     >    Have the code-reviewer subagent look at my recent changes
     ```
   - See available agents in @.claude/agents directory.

5. **Script handling**:
   - Check script contents
   - Keep initialization scripts that create templates
   - Inline simple commands (mkdir, touch) if clearer
   - Preserve complex logic in scripts
   - Create scripts if applicable

6. **Error patterns to preserve**:
   ```markdown
   # Keep specific error messages
   If missing, show error: "Error: File not found at path" and exit
   
   # Keep recovery guidance  
   If fails: "Error: [summary]. Try: npm cache clean --force"
   ```

### Quality Metrics
- Simple commands: <100 words total
- Complex commands: <300 words total
- Bash calls: Maximum 3-4 unless complex analysis
- Preserve all critical error handling

### Output Format

Provide optimized command with:
1. Updated frontmatter (minimal required fields)
2. Efficient context gathering
3. Clear, direct task description and sub-agent usage, if applicable
4. Preserved error handling
5. Report: improvements made, elements preserved, word count change
