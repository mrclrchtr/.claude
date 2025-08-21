# Ultimate Custom Slash Command Guide for AI/LLM

Custom slash commands are Markdown files that define reusable AI prompts with dynamic context gathering, tool restrictions, and intelligent task orchestration.

## Core Architecture

**Locations:**
- `.claude/commands/` - Project-specific (version controlled)
- `~/.claude/commands/` - Personal (all projects)

**Structure:** `filename.md` → `/filename` | `dir/file.md` → `/dir:file`

## Essential Template

```markdown
---
argument-hint: [optional args]  # Shows in autocomplete
description: Brief description   # Command summary
model: opus|sonnet|haiku        # Model selection
allowed-tools: Read,Edit,Bash    # Tool restrictions
---

# Command Purpose

## Context
- State: !`git status --porcelain`      # Bash execution
- Config: @package.json                 # File inclusion
- Branch: !`git branch --show-current`  # Dynamic values

## Task
$ARGUMENTS handling and clear steps.
```

## Critical Features

| Feature | Syntax | Example | Purpose |
|---------|--------|---------|----------|
| **Arguments** | `$ARGUMENTS` | `/fix-issue 123` → `Fix issue #123` | Dynamic input |
| **Bash Exec** | `!\`command\`` | `!\`git status --porcelain\`` | Live context |
| **File Include** | `@path` | `@src/main.js` or `@src/` | Code context |
| **Namespacing** | `dir/file.md` | `/git:commit`, `/test:unit` | Organization |

⚠️ **REQUIRED**: Commands using `!` bash execution MUST include `allowed-tools` with appropriate Bash patterns (e.g., `Bash(git:*)`, `Bash(fd:*)`) or the bash commands will fail to execute.

## Frontmatter Reference

```yaml
argument-hint: [file] [options]   # Autocomplete hint
description: Command purpose      # Brief description
model: haiku|sonnet|opus          # Speed/quality trade-off
allowed-tools: Read,Edit,Bash     # Tool restrictions
  # Patterns: Bash(git:*), Edit(@src/**/*.js), Read
author: @username                 # Metadata
version: 1.0.0                    # Versioning
```

## Five Core Principles

1. **Minimal Context** - Gather only essential state
2. **Clear Scope** - Define exact task boundaries
3. **Tool Efficiency** - Use fastest model/tools for task
4. **Parallel Execution** - Batch independent operations
5. **Measurable Success** - Include validation criteria

## Power Patterns

### 1. Minimal Context Command
```markdown
---
description: Find all TODOs
model: haiku  # Fast for simple tasks
---
Search for TODO/FIXME comments: !`rg "TODO|FIXME" --type-add 'code:*.{js,ts,py}' --type code`
```

### 2. Smart Git Commit
```markdown
---
argument-hint: [message]
model: haiku
allowed-tools: Bash(git:*)
---
## Context
- Branch: !`git branch --show-current`
- Changes: !`git --no-pager diff --stat`
- Submodules: !`git submodule status --recursive`

## Task
1. Check for secrets: `git diff --cached | grep -iE "(api_key|password|secret)"`
2. Stage all: `git add -A`
3. Commit with message or generate one
```

### 3. Parallel Analysis
```markdown
---
description: Full project health check
model: opus  # Complex coordination
---
Execute simultaneously (7-parallel pattern):
1. Run tests: `npm test`
2. Check types: `npm run typecheck`
3. Lint code: `npm run lint`
4. Security scan: `npm audit`
5. Coverage: `npm run coverage`
6. Bundle size: `npm run build --size`
7. Performance: `npm run benchmark`
```

## Advanced Techniques

### Output Structuring
```markdown
Generate component for $ARGUMENTS:
<component_code>Main implementation</component_code>
<test_code>Test suite</test_code>
<usage_examples>Usage patterns</usage_examples>
```

### Deep Analysis Prompt
```markdown
Analyze codebase patterns → Consider approaches → Select idiomatic solution
```

### Context-Aware Instructions
```markdown
IMPORTANT: Trunk-based development requires backward compatibility for zero-downtime deployments.
```

## Optimization Strategies

### Balanced Optimization
**Target**: 
- Simple commands: <100 words (status checks, single actions)
- Standard commands: <300 words (most tasks)
- Process commands: ~200-400 words (analyze, refactor)
- **Meta/Teaching commands**: ~350-500 words (optimize, guide, teach)
  - Commands that teach HOW to do something need examples
  - Includes: optimize-command, create-agent, write-docs
- Complex workflows: <500 words (multi-step orchestration)

But ALWAYS preserve:
1. **Purpose-awareness**: "Think about the purpose of the command"
2. **Step-by-step instructions**: Keep numbered steps for process commands
3. **Error recovery patterns**: Specific messages with recovery guidance
4. **Script handling logic**: Complex initialization, templates
5. **Sub-agent references**: Name agents explicitly
6. **Model guidance**: "inherit from main thread"
7. **Concrete examples**: At least 1-2 for teaching processes
8. **Tool recommendations**: "Use fd over find, rg over grep"

### Token Economy
- **Model**: `haiku` for simple, `sonnet` for complex, `opus` for critical
- **Context**: Limit bash output with `head -20`, use counts over full output
- **Files**: Specific paths over directories: `@src/main.js` not `@src/`
- **Tools**: Minimal set: `allowed-tools: Read,Edit`

### Parallel Execution (7-Pattern)
```markdown
Simultaneously execute (max 7 for efficiency):
- All independent operations
- Batch similar tasks
- Consolidate results after
```

## CLAUDE.md Integration

**Context Hierarchy:** Command > CLAUDE.md > User prefs > Defaults

**See also:** @.claude/docs/optimization-patterns.md for efficiency rules, @docs/context.md for bash commands

```markdown
---
description: Project quality checks
---
Run quality checks from CLAUDE.md:
1. Lint command from CLAUDE.md
2. Test suite from CLAUDE.md
3. Coverage thresholds
4. Security scan
```

## Agent Orchestration

```markdown
---
description: Multi-agent analysis
allowed-tools: Task, TodoWrite
---
## Context
- Changes: !`git diff --name-only | wc -l`

## Task
Route by complexity:
- Simple (<5 files): Direct execution
- Medium (5-20): Launch haiku agent
- Complex (>20): Launch opus specialist

Parallel agents for:
- Security scan
- Performance analysis
- Architecture review
```

## Validation & Error Handling

### Self-Testing Pattern
```markdown
## Validation
- File exists: !`test -f $ARGUMENTS && echo "✓" || echo "✗"`
- Syntax valid: !`head -1 $ARGUMENTS | grep -q "^---$"`

If validation fails, report and exit.
```

### Error Recovery
```markdown
1. Try primary approach
2. On error: Collect diagnostics → Try alternative → Report failure
3. Always leave clean state
```

## Security Patterns

### Tool Restriction Examples
```yaml
# Read-only operations:
allowed-tools: Read,Grep,LS

# npm commands only:
allowed-tools: Bash(npm:*),Read

# Edit specific files:
allowed-tools: Edit(@src/**/*.js)

# Sandboxed execution:
allowed-tools: Bash(docker:*)
```

### Security Validation
```markdown
!`git diff --cached | grep -iE "(api_key|password|secret)" && echo "⚠️ SECRETS" || echo "✓"`
```

## Command Organization

```
.claude/commands/
├── team/         # Shared (version controlled)
├── project/      # Project-specific
└── dev/          # Personal shortcuts

~/.claude/commands/  # Global personal commands
```

### Metadata
```yaml
author: @username
version: 2.0.0
team: frontend
tags: [react, testing]
```

## Command Composition

### Chain & Conditional
```markdown
# Pipeline: /test:all → /build:prod → /deploy:staging → /test:e2e → /deploy:prod

# Conditional:
If !`npm run build 2>&1` succeeds:
  Continue deployment
Else:
  Run /debug:build
```

## Success Metrics

```markdown
## Performance
- Start: !`date +%s`
- Memory: !`ps -o rss= -p $$`

[Task execution]

## Validation
✓ Tests pass: !`npm test 2>&1 | grep -q "failed: 0"`
✓ No lint errors: !`npm run lint 2>&1 | grep -q "0 errors"`
✓ Bundle < 500KB: !`du -sh dist/bundle.js | awk '{print $1}'`
```

## Multi-Agent Patterns

### Smart Routing
```markdown
---
allowed-tools: Task, TodoWrite
---
Complexity: !`git diff --name-only | wc -l`

Route:
- <5 files: Direct execution
- 5-20: Haiku agent
- >20: Opus specialist

Parallel specialists:
- Security scan
- Performance analysis
- Architecture review
```

## 7-Parallel Pattern

### Maximum Efficiency
```markdown
# Batch 1 (parallel, max 7):
1. Test suites
2. Code coverage
3. Security scan
4. Dependencies
5. Documentation
6. Lint checks
7. Type safety

# Batch 2: Consolidate results

# Dependency-aware:
Independent (parallel): Clean, env check, config
Dependent (sequential): Install → Build → Validate
```

## Performance Tracking

```markdown
## Metrics
Start: !`date +%s` Memory: !`ps -o rss= -p $$`
[Task]
End: !`date +%s` Changed: !`git diff --stat | tail -1`

## Validation
✓ <5 sec: !`[ $((end-start)) -lt 5 ] && echo "✓"`
✓ Tests: !`npm test 2>&1 | grep -q "failed: 0"`
✓ Security: !`npm audit --audit-level=high | grep -q "0 vuln"`
```


## Advanced Patterns

### Visual Testing
```markdown
Compare @tests/screenshots/baseline.png with current
Report differences and update if intentional
```

### Progress Tracking
```markdown
[▶] Initialize → [▶] Validate → [▶] Execute → [▶] Cleanup → [✓] Complete
```

### Lifecycle Management
```yaml
deprecated: true
replacement: /new:command
deprecation-message: Removed in v3.0.0
```

## Ultimate Quick Reference

### Command Creation Checklist
1. **Location**: `.claude/commands/name.md` → `/name`
2. **Model**: haiku (fast) → sonnet (balanced) → opus (complex)
3. **Context**: Minimal bash commands with `--no-pager`, counts over content
4. **Tools**: Restrict to minimum needed
5. **Validation**: Include success criteria

### Essential Patterns
```markdown
---
argument-hint: [file] [options]
description: Purpose in 5 words
model: haiku  # Start cheap
allowed-tools: Read,Edit,Bash(git:*)
---

## Context (minimal, fast)
- Branch: !`git branch --show-current`
- Changes: !`git status --porcelain | wc -l`
- Files: !`fd -e py . | wc -l`  # Use fd/rg when available

## Task
Handle $ARGUMENTS efficiently.

## Validation
✓ Tests: !`npm test 2>&1 | grep -q "failed: 0"`
```

See @.claude/docs/context.md for comprehensive bash command reference and context gathering patterns.

### Optimization Priority
1. **Token Economy**: haiku + limited tools + counts (see @.claude/docs/optimization-patterns.md)
2. **Parallel Execution**: Max 7 simultaneous operations
3. **Progressive Loading**: Check → Load if needed (see @.claude/docs/context.md)
4. **Agent Routing**: <5 files direct, 5-20 haiku, >20 opus
5. **Security First**: Check secrets, restrict tools

### Command Patterns by Use Case

| Use Case | Pattern | Example |
|----------|---------|---------|
| Status Check | `haiku + Bash` | `/status` |
| Code Search | `sonnet + Read,Grep` | `/find:pattern` |
| Quick Fix | `sonnet + Read,Edit` | `/fix:typo` |
| Refactor | `opus + MultiEdit` | `/refactor:class` |
| Analysis | `opus + Task` | `/analyze:security` |
| Pipeline | Chain commands | `/test → /build → /deploy` |

### Power User Tips
- **Namespace**: `/git:commit`, `/test:unit`, `/deploy:prod`
- **Arguments**: `$ARGUMENTS` for dynamic input
- **File Refs**: `@specific/file.js` not `@entire/directory/`
- **Bash**: Always `--no-pager`, use `| head -20`
- **Validation**: Exit codes `&& echo "✓" || echo "✗"`
- **Parallel**: Batch up to 7 independent operations
- **Context**: Inherit from CLAUDE.md automatically

### Common Gotchas
- ❌ Loading entire directories with `@src/`
- ❌ Unbounded output without `head/tail`
- ❌ Using all tools when subset would work
- ❌ Sequential when parallel possible
- ❌ Missing `--no-pager` on git commands


## Command Engineering Formula

```
Efficiency = (Minimal Context + Right Model + Restricted Tools) 
            × Parallel Execution 
            ÷ Token Usage
```

**Remember**: Every token counts. Start minimal, expand only if needed.

## Quick Command Templates

### Instant Status (500 tokens)
```markdown
---
model: haiku
allowed-tools: Bash
---
!`git status --short && echo "---" && git branch --show-current`
```

### Smart Commit (1.8K tokens)
```markdown
---
model: haiku
allowed-tools: Bash(git:*)
---
Changes: !`git diff --stat | tail -1`
Stage all → Generate message → Commit
```

### Full Analysis (3.2K tokens)
```markdown
---
model: opus
allowed-tools: Task
---
Launch 7 parallel specialists → Consolidate results
```
