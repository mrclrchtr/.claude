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
4. **Preserve critical references** - Keep critical documentation references

### Quick Reference
Command: @.claude/docs/command.md for complete slash command documentation and structure.
Optimization Patterns: @.claude/docs/optimization-patterns.md for best practices.
Context: @.claude/docs/context.md for comprehensive git commands.

### Optimization Process

1. **Rev the engine (self-critique)**:
   - State initial optimization plan
   - Challenge assumptions: "Am I about to remove something critical?"
   - Consider alternatives: "Is there a simpler optimization approach?"
   - Identify risks: "What could break if I remove this?"
   - Refine approach based on internal review

2. **Analyze current command**:
   - Think about the purpose of the command and keep this in mind for every decision in the optimization process
   - **STEP 1**: Use Read tool on each `@` reference in the command
   - **STEP 2**: Document what each reference provides (scope, purpose, unique content)
   - **STEP 3**: Only after reading ALL references, identify true redundancies
   - Review context gathering (combine bash commands, remove duplicates)
   - Evaluate task clarity and word count

3. **Assess if optimization is needed**:
   - Evaluate current command effectiveness based on analysis
   - Check word count against `# Balanced Optimization` in @.claude/docs/command.md
   - Review clarity and structure
   - **If command is already optimal**: Report "Command is already well-optimized" and stop
   - **Only proceed if**: Command has clear redundancy, bloat, or efficiency issues

4. **Apply optimizations**:
   - Use glob patterns: `src/components/*.js` instead of listing files
   - Remove politeness: "Analyze" not "Please analyze"
   - Preserve error handling and user guidance
   - Keep documentation references unless you can cite specific overlapping content from your analysis

5. **Model selection**:
   - do not add model to command, inherit from main thread

6. **Sub-agent references**:
   - Use sub-agent references if applicable.
   - Request specific subagents by mentioning them:
     ```
     >    Use the test-runner subagent to fix failing tests
     >    Have the code-reviewer subagent look at my recent changes
     ```
   - See available agents in @.claude/agents directory.

7. **Bash command handling**:
   - Test and optimize each bash command that the command executes
   - Use `@.claude/docs/context.md` as reference for context gathering patterns
   - Apply context.md principles:
     * Use modern tools (fd, rg, eza) for 3-10x faster execution
     * Always use --no-pager for git commands
     * Pre-assess scope before full execution (e.g., `git diff --stat` before full diff)
     * Filter before limiting depth (use excludes/ignore-globs first)
     * Prefer machine-readable formats (--porcelain) over human-readable
     * **Avoid combined/piped commands** - Use simple, atomic operations (Claude Code approval issues)

8. **Script handling**:
   - Check script contents
   - Keep initialization scripts that create templates
   - Preserve complex logic in scripts
   - Create scripts if applicable

9. **Error patterns to preserve**:
   ```markdown
   # Keep specific error messages
   If missing, show error: "Error: File not found at path" and exit
   
   # Keep recovery guidance  
   If fails: "Error: [summary]. Try: npm cache clean --force"
   ```

10. **Reference analysis requirement**:
   - **You MUST use Read tool on each @ reference before optimization**
   - Document each reference's unique contribution
   - Only remove if you can quote the redundant sections
   - Default to keeping references when unsure

### Quality Metrics
- Word count based on `# Balanced Optimization` in @.claude/docs/command.md
- Bash calls: Maximum 3-4 unless complex analysis
- Preserve all critical error handling

### Output Format

Provide optimized command with:
1. Updated frontmatter (minimal required fields)
2. Efficient context gathering
3. Clear, direct task description and sub-agent usage, if applicable
4. Preserved error handling
5. Report: improvements made, elements preserved, word count change
6. **Reference analysis**: List each @ reference examined and why it was kept/removed

Ultrathink!
