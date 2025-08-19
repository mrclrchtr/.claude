---
argument-hint: [command-file-path]
description: Optimize slash command for efficiency
allowed-tools: Bash(find:*)
---

# Optimize Command

## Context

- Command path: $ARGUMENTS
- Command content: @$ARGUMENTS
- Existing commands: !`find .claude/commands -name "*.md" -type f 2>/dev/null | head -20`

## Task

Optimize the slash command at $ARGUMENTS following these principles:

### Core Optimization Principles
1. **Clarity over brevity** - Remove bloat but keep workflow-critical details
2. **Preserve robustness** - Keep validation, error messages, and recovery
3. **Name dependencies** - Keep sub-agent references visible

### Quick Reference
Command: @.claude/docs/command.md for complete slash command documentation and structure.
Context: @.claude/docs/context.md for comprehensive git commands.

### Optimization Process

1. **Analyze current command**:
   - Review context gathering (combine bash commands, remove duplicates)
   - Evaluate task clarity and word count

2. **Apply optimizations**:
   - Use glob patterns: `src/components/*.js` instead of listing files
   - Remove politeness: "Analyze" not "Please analyze"
   - Preserve error handling and user guidance

3. **Model selection**:
   - do not add model to command, inherit from main thread

4. **Sub-agent references**:
   - Use sub-agent references if applicable.
   - Request specific subagents by mentioning them:
     ```
     >    Use the test-runner subagent to fix failing tests
     >    Have the code-reviewer subagent look at my recent changes
     ```
   - See available agents in @.claude/agents directory.

5. **Bash command handling**:
   - test and optimize each bash command, that the command executes
   - Use `docs/context.md` as reference for context gathering (if applicable)

6. **Script handling**:
   - Check script contents
   - Keep initialization scripts that create templates
   - Preserve complex logic in scripts
   - Create scripts if applicable

7. **Error patterns to preserve**:
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

Ultrathink!
