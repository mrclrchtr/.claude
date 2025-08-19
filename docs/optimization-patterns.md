# Optimization Patterns for Commands & Agents

Quick reference for optimizing AI commands and agents for maximum efficiency.

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
1. **Essential only**: Branch, change count, file types
2. **Progressive loading**: Check size → Load if needed
3. **Parallel execution**: Max 7 simultaneous operations
4. **Use modern tools**: fd/rg/eza (3-10x faster than find/grep/ls)

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

### Task Structure
```markdown
# CONCISE
## Context
- Branch: !`git branch --show-current`
- Changes: !`git status --porcelain | wc -l`

## Task
$ARGUMENTS: Direct action without preamble

# VERBOSE (avoid)
## Context
- Current git branch: !`git branch`
- All changed files: !`git status`
- Full diff: !`git diff`

## Task
Please kindly analyze $ARGUMENTS and then...
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
✓ Word count (<300 words)
✓ Bash calls limited (3-4 max)
✓ Output bounded (head/tail/wc)
✓ Arguments handled clearly
✓ Validation present

## Anti-Patterns to Avoid

```markdown
❌ Loading entire directories: @src/
✓ Specific files: @src/main.js @src/utils.js

❌ Unbounded git output: git log
✓ Limited output: git log --oneline -5

❌ All tools: allowed-tools: (unrestricted)
✓ Minimal tools: allowed-tools: Read,Edit

❌ Verbose instructions: "Please carefully analyze..."
✓ Direct: "Analyze..."

❌ Model overkill: opus for simple grep
✓ Right-sized: haiku for simple tasks
```

## Quick Optimization Process

1. **Measure current state**
   - Count: words, lines, bash calls, tools
   - Identify: redundancies, verbose sections

2. **Apply patterns**
   - Compress context gathering
   - Remove filler text
   - Restrict tools to minimum
   - Select appropriate model

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
