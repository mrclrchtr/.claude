---
argument-hint: [command-file-path]
description: Improve commands with significant issues or inefficiencies
allowed-tools: Bash(fd:*),Bash(find:*),Read
---

# Optimize Command

## Context

- Command path: $ARGUMENTS
- Command content: @$ARGUMENTS
- Existing commands: !`fd . .claude/commands -e md --type f 2>/dev/null || find .claude/commands -name "*.md" -type f 2>/dev/null`

## Task

Analyze the command at $ARGUMENTS to determine if optimization would provide meaningful value.

### What Optimization Actually Means

Optimization = Making commands MORE EFFECTIVE through:
1. **Functionality** (Priority 1) - Fix broken or failing parts
2. **Efficiency** (Priority 2) - Reduce wasted resources (unnecessary API calls, redundant operations)
3. **Clarity** (Priority 3) - Fix genuinely confusing instructions
4. **Conciseness** (Priority 4) - Remove TRUE redundancy (not just wordiness)

### 🎯 Core Principle: Preserve Command Purpose

**CRITICAL: Understand OUTPUT TYPE before optimizing:**
- **Paths** → For processing (NEVER → count)
- **Content** → For analysis (NEVER → summary)  
- **Count** → For metrics (OK to optimize)
- **Diff** → For review (NEVER → stats only)

**DON'T BREAK PURPOSE:**
- `git ls-files '*.md'` → `| wc -l` ❌ (needs paths, not count)
- `git diff` → `--stat` ❌ (needs full diff for review)
- `rg "TODO"` → `--count` ❌ (needs locations, not total)

### Optimization Decision Tree

Ask these questions IN ORDER:
1. Is something broken or failing? → YES: Fix it (HIGH VALUE)
   - *Example: Broken bash command, missing error handling*
2. Is something >2x inefficient? → YES: Improve it (HIGH VALUE)
   - *Example: 4 separate API calls that could be 1, using `find` instead of `fd`*
3. Are instructions genuinely unclear? → YES: Clarify (MEDIUM VALUE)
   - *Example: "Do the thing" vs "Run npm test to validate changes"*
4. Is there TRUE redundancy (same info repeated)? → YES: Remove it (LOW VALUE)
   - *Example: Same bash command appears 3 times, identical instructions in 2 sections*
5. Would changes improve effectiveness by >20%? → YES: Proceed (MEDIUM VALUE)
6. **None of the above? → STOP: Output "Command analysis complete. No significant improvements needed."**

**Examples of what NOT to optimize:**
- Removing helpful examples = Reduces effectiveness (DON'T DO)
- Rewording for style preferences = 0% improvement (DON'T DO)

### When NOT to Optimize
- Command works correctly
- Word count is within 20% of typical range
- Changes would be mostly stylistic
- This is the 2nd or 3rd optimization pass
- Removing content would reduce helpfulness

### ⚠️ Over-Optimization Warning Signs
If you find yourself:
- Doing mostly rewording without functional changes
- Unable to identify specific broken functionality
- Focusing on word count rather than problems
- Optimizing the same command repeatedly
- Struggling to justify the changes

**STOP** - The command doesn't need optimization.

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

3. **Assess if optimization provides MEANINGFUL value**:
   
   **Calculate improvement value:**
   - Fixing broken functionality = 100% improvement
   - Reducing API calls by half = 50% improvement  
   - Improving unclear instructions = 20-30% improvement
   - Removing redundancy = 10-15% improvement
   - Style/wording changes = <5% improvement (DON'T DO)
   
   **Decision points:**
   - >20% total improvement → Proceed with optimization
   - 10-20% improvement → Report minor issues but recommend keeping as-is
   - <10% improvement → Output: "Command is effective. No optimization warranted."
   
   **Include in your response:**
   - Current word count and typical range for command type
   - Specific issues found (if any) with line numbers
   - Estimated improvement percentage

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
   - **FIRST: Know what each command RETURNS and HOW IT'S USED**
   - Apply context.md principles:
     * Modern tools: find→fd, grep→rg, ls→eza (3-10x faster)
     * Git: Always --no-pager, pre-assess with --stat
     * Filter before limit, prefer --porcelain format
     * **Pipes match purpose:** `| wc -l` for counts only, `| grep` for filtering
     * Remove artificial limits unless sampling needed

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

### Optimization Value Metrics

**Always Optimize (100% improvement):**
- Broken bash commands or API calls
- Missing critical error handling
- Duplicate operations (same data gathered twice)
- Inefficient tools providing >2x speedup (find→fd, grep→rg)

**Consider Optimizing (if >20% improvement):**
- Genuinely unclear instructions
- TRUE redundancy (not just verbose explanations)
- Significantly exceeds typical word count (>50% over)

**Never Optimize:**
- Working commands with <10% potential improvement
- Style preferences with no functional impact
- Commands already optimized once (unless newly broken)
- Removing examples that aid understanding

**Word Count Ranges (FLEXIBLE GUIDELINES with intentional overlap):**
- Simple commands: 100-300 words (status checks, single actions)
- Standard commands: 200-600 words (most development tasks)
- Process commands: 500-1000 words (analyze, refactor, multi-step)
- Meta/Teaching commands: 700-1200 words (optimize, guide, teach)

*Note: Ranges overlap because command complexity varies. A 400-word command could be standard (if complex) or process (if simple). Focus on effectiveness, not exact categorization.*

### Output Format

Update the command specification with:
1. Updated frontmatter (minimal required fields)
2. Efficient context gathering
3. Clear, direct task description and sub-agent usage, if applicable
4. Preserved error handling
5. Report: improvements made, elements preserved, word count change
6. **Reference analysis**: List each @ reference examined and why it was kept/removed

Ultrathink!
