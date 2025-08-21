# Optimization Patterns for Commands & Agents

Quick reference for optimizing AI commands and agents for maximum efficiency.

**See also:** @.claude/docs/context.md for bash commands, @docs/command.md for creation patterns

## First Principle: Clarity Over Brevity

Remove bloat but NEVER sacrifice:
- Error messages with recovery guidance
- Validation that prevents failures
- Context that aids decision-making
- Purpose-driven thinking: "What must this accomplish?"
- **Instructional content**: Keep HOW-TO guidance for complex tasks
- **Examples**: Preserve at least 1-2 concrete examples when teaching a process

## Optimization Context Principle

When optimizing commands, ALWAYS start with: **"What is the core purpose of this command?"**
- Every optimization decision must serve the original purpose
- Preserve all error handling that protects the purpose
- Keep validation that ensures purpose is achieved
- Maintain recovery guidance that helps users succeed
- Think about the purpose before every optimization decision

## Universal Optimization Rules

### Token Economy
| Component | Optimal                                             | Wasteful                  |
|-----------|-----------------------------------------------------|---------------------------|
| Model     | haiku (simple) → sonnet (complex) → opus (critical) | opus for everything       |
| Tools     | 3-5 specific tools                                  | All tools or unrestricted |
| Context   | Counts & stats                                      | Full file contents        |
| Bash      | `head -20`, `wc -l`, `--no-pager`                   | Unbounded output          |
| Files     | `@specific/file.js`                                 | `@entire/directory/`      |

### Bash Command Patterns
```bash
# GOOD: Limited, machine-readable
git status --porcelain | wc -l
git --no-pager log --oneline -5
fd -e py . | wc -l
rg "TODO" --count

# BAD: Verbose, human-readable
git status
git log
find . -name "*.py"
grep -r "TODO" .
```

### Context Gathering Priority
See @docs/context.md for comprehensive command selection and modern tool usage patterns.

## Agent-Specific Patterns

### Trigger Phrases (85%+ activation)
```yaml
# STRONG
description: MUST BE USED PROACTIVELY when [specific condition]
description: Expert at [domain], handles all [task type]

# WEAK
description: Can help with various tasks
description: General purpose assistant
```

### Tool Selection Matrix
| Task          | Tools                 | Tokens |
|---------------|-----------------------|--------|
| Analysis      | Read, Grep, Glob      | ~3.2K  |
| Editing       | Read, Edit, MultiEdit | ~3.4K  |
| Testing       | Bash, Read, TodoWrite | ~4.1K  |
| Orchestration | Task, TodoWrite       | ~3.1K  |

## Command-Specific Patterns

### Frontmatter Optimization
```yaml
# MINIMAL (preferred)
---
description: Clear 5-word purpose
model: haiku  # Only if needed
allowed-tools: Read,Edit  # Only restrict if needed
argument-hint: [args]  # Keep if command uses $ARGUMENTS
---

# VERBOSE (avoid)
---
argument-hint: [detailed explanation]
description: Long description of what this does
model: opus
allowed-tools: (all available)
author: @user
version: 1.0.0
---
```

**Preservation Rules:**
- **argument-hint**: Keep when command accepts `$ARGUMENTS` - enables autocomplete
- **allowed-tools**: REQUIRED when using `!` commands, must include Bash with appropriate patterns
- **description**: Always keep - shows in command list
- **model**: Only specify if different from thread default
- Remove: author, version, tags unless organizationally required

⚠️ **CRITICAL**: Commands with `!` backtick execution MUST have `allowed-tools` with Bash permissions or they will fail

### Task Structure
```markdown
# SIMPLE COMMAND (status check, <100 words)
## Context
- Branch: !`git branch --show-current`
- Changes: !`git status --porcelain | wc -l`

## Task
$ARGUMENTS: Direct action without preamble

# PROCESS COMMAND (analysis, refactor, ~200-400 words)
## Context
- Target: @$ARGUMENTS
- Reference: @docs/patterns.md

## Task
Analyze $ARGUMENTS following these steps:
1. Examine current structure
2. Apply patterns while preserving validation
3. Output results + metrics

# META/TEACHING COMMAND (optimize, guide, ~350-750 words)
## Context
- Target: @$ARGUMENTS
- References: @docs/patterns.md @docs/context.md

## Task
Optimize $ARGUMENTS following these steps:
1. **Think about the purpose** - Keep this in mind for every decision
2. Analyze current structure (combine bash, remove duplicates)
3. Apply patterns while preserving:
   - Error handling: `If missing: "Error: File not found"`
   - Recovery guidance: `Try: npm cache clean`
   - Sub-agent names: "Use debug-solution-engineer"
4. Validate metrics (words, bash calls, tools)
5. Output: optimized version + before/after metrics

# VERBOSE (avoid)
Please kindly analyze $ARGUMENTS and carefully consider...
```

## Performance Benchmarks

### Token Usage by Configuration
- Minimal (haiku + 3 tools): ~1.8K tokens
- Balanced (sonnet + 5 tools): ~3.2K tokens  
- Heavy (opus + 10 tools): ~5K tokens
- Maximum (opus + all tools): ~25K tokens

### Execution Time
- Simple command: <1s initialization
- Complex command: <3s initialization
- Multi-agent: <5s per agent launch

## Validation Checklist

### For Agents
✓ Trigger phrase strength (>85% activation)
✓ Tool count minimized (<5 tools)
✓ Model appropriate to complexity
✓ Context window efficient (<5K tokens)

### For Commands
✓ Word count:
  - Simple: <100 (status, single action)
  - Standard: <300 (most tasks)
  - Process: ~200-400 (analyze, refactor)
  - Meta/Teaching: ~350-500 (optimize, guide - needs examples)
  - Complex: <500 (multi-step orchestration)
✓ Bash calls limited (3-4 typical, more if workflow requires)
✓ Output bounded (head/tail/wc)
✓ Arguments handled clearly
✓ Validation present
✓ For meta commands: Keep "Think about..." prompts and examples

## Must Preserve Patterns

These patterns must survive optimization:

### Minimum Viable Instructions
```markdown
# For process commands (like analyze, refactor):
- Keep numbered steps or bullet points
- Preserve "Think about..." prompts
- Maintain "Following these principles:" sections
- Include at least one concrete example
- Keep tool/technique recommendations (fd over find, rg over grep)

# For meta/teaching commands (like optimize-command, create-agent):
- MUST keep detailed step-by-step instructions
- MUST preserve multiple examples showing before/after
- MUST retain "Think about the purpose" reflection prompts
- MUST include error pattern examples with recovery
- Allow ~350-750 words for instructional completeness
```

### Error Recovery Examples
```markdown
# Keep specific error messages
If missing, show error: "Error: File not found at $path" and exit
Try: "Check path exists with 'ls -la'"

# Keep recovery guidance  
If fails: "Error: Build failed. Try: npm cache clean --force"
```

### Script Handling
```markdown
# Preserve script logic that:
- Creates templates or boilerplate
- Performs complex initialization
- Has multi-step conditional flows
```

### Model Guidance
```markdown
# Keep important directives:
- "inherit from main thread" (don't add model to command)
- Sub-agent references by name: "Use debug-solution-engineer"
```

## Anti-Patterns to Avoid

```markdown
❌ Loading entire directories: @src/
✓ Specific files: @src/main.js @src/utils.js

❌ Unbounded git output: git log
✓ Limited output: git log --oneline -5

❌ All tools: allowed-tools: (unrestricted)
✓ Minimal tools: allowed-tools: Read,Edit

❌ Verbose politeness: "Please carefully analyze..."
✓ Direct language: "Analyze..."

❌ Model overkill: opus for simple grep
✓ Right-sized: haiku for simple tasks

❌ Removing references without analysis: Assume doc1.md and doc2.md are redundant
✓ Evidence-based decisions: Read each doc reference to understand unique value

⚠️ IMPORTANT: "Direct" means removing politeness, NOT removing instructions!
⚠️ Keep: "Analyze X following steps 1,2,3"
⚠️ Remove: "Please kindly analyze X if you would"
```

## Rev The Engine Pattern

### Core Concept
"Rev the engine" - Critically review and challenge your own plan before execution. Generate internal critique to identify flaws, assumptions, and better approaches.

### When to Apply
- Before committing to any approach
- When multiple solutions exist
- Before complex multi-step operations
- When uncertainty exists about best path

### Implementation
```markdown
# PATTERN: Self-critique before execution
## Rev the engine (internal review)
1. State planned approach
2. Challenge assumptions: "What could go wrong?"
3. Consider alternatives: "Is there a simpler way?"
4. Identify risks: "What am I not seeing?"
5. Refine approach based on critique

## Execute refined approach
- Apply insights from self-review
- Course-correct early if needed
- Maintain skepticism during execution
```

### Examples
```markdown
# REV: Challenge the plan
Initial plan: "Read all JS files to find the bug"
Rev critique: "That's 500+ files. What if I search for error patterns first?"
Better approach: Use grep for error signatures, then read specific files

# REV: Question assumptions
Initial plan: "Edit all test files to add new assertion"
Rev critique: "Do ALL tests need this? Check test structure first"
Better approach: Identify which test suites actually need updates

# REV: Simplify complexity
Initial plan: "Create elaborate multi-agent workflow"
Rev critique: "Is this complexity necessary? What's the simplest solution?"
Better approach: Single focused command with right tools
```

### Benefits
- Prevents costly mistakes before they happen
- Forces consideration of alternatives
- Catches hidden assumptions
- Improves solution quality through self-reflection
- Reduces backtracking and rework

### Anti-Pattern
```markdown
❌ Immediate execution without reflection
❌ Sticking to first idea without critique
❌ Ignoring doubts or concerns
❌ Over-planning without pragmatic review
✓ Plan → Critique → Refine → Execute
```

## Quick Optimization Process

1. **Measure current state**
   - Count: words, lines, bash calls, tools
   - **REQUIRED**: Read each `@` reference to understand unique value
   - Identify: redundancies, verbose sections

2. **Apply patterns**
   - **Rev the engine**: Self-critique and challenge approach before execution
   - Compress context gathering
   - Remove filler text
   - Restrict tools to minimum
   - Select appropriate model
   - Preserve references unless content analysis proves true redundancy

3. **Validate**
   - Test functionality preserved
   - Verify error handling intact
   - Check success criteria present

4. **Report metrics**
   - Before/after token count
   - Performance improvement
   - Features preserved

## Formula for Efficiency

```
Efficiency = (Minimal Context + Right Model + Restricted Tools) 
            × Parallel Execution 
            ÷ Token Usage
```

Target: Maximum output with <5K tokens in <3 seconds.
