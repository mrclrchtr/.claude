# Slash Command Template and Documentation

## Custom slash commands

Custom slash commands allow you to define frequently-used prompts as Markdown files that Claude Code can execute.
Commands are organized by scope (project-specific or personal) and support namespacing through directory structures.

This template provides comprehensive guidance for creating custom slash commands in Claude Code.

## Command Locations

Commands can be stored in two locations:
- **Project-level**: `.claude/commands/` (shared with team, version controlled)
- **Personal-level**: `~/.claude/commands/` (personal commands across all projects)

## Basic Structure

```markdown
---
argument-hint: [optional arguments]
description: Brief description of the command
model: sonnet
---

# Command Title

## Context

- Current system state: !`relevant bash command`
- Additional context: !`another bash command`

## Task

Clear description of what the command should accomplish.

1. Step one
2. Step two
3. Step three
```

## Features

### Namespacing

Organize commands in subdirectories to create namespaced commands:

- File: `.claude/commands/frontend/component.md` → Command: `/frontend:component`
- File: `.claude/commands/git/commit.md` → Command: `/git:commit`

### Arguments

Use `$ARGUMENTS` placeholder for dynamic values:

```markdown
Fix issue #$ARGUMENTS following our coding standards

# Usage: /fix-issue 123
```

### Bash Command Execution

Execute bash commands before the command runs using `!` prefix:

```markdown
## Context

- Current git status: !`git status --porcelain`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -5`
```

### File References

Include file contents using `@` prefix:

```markdown
# Single file
Review the implementation in @src/utils/helpers.js

# Multiple files  
Compare @src/old-version.js with @src/new-version.js

# Directory
Review all files in @src/components/
```

## Frontmatter Options

| Field           | Purpose                          | Example                                        | Default                    |
|-----------------|----------------------------------|------------------------------------------------|----------------------------|
| `argument-hint` | Arguments shown in auto-complete | `[message]` or `add [tagId] \| remove [tagId]` | None                       |
| `description`   | Brief command description        | `Create a git commit`                          | First line of prompt       |
| `model`         | Model to use for command         | `opus`, `sonnet`, `haiku`                      | Inherits from conversation |
| `allowed-tools` | Restrict available tools         | `Bash(git:*)` for git-only operations          | All tools available        |

## Design Principles

1. **Clarity**: Every word must serve a purpose
2. **Context**: Always include relevant system state using `!` commands
3. **Scope**: Define exact scope and output format
4. **Modularity**: Design for reusability across projects
5. **Arguments**: Handle `$ARGUMENTS` only when specified
6. **Efficiency**: Eliminate unnecessary steps and verbose language

## Example Commands

### Simple Command
```markdown
---
description: List all TODO comments in code
---

# Find TODOs

## Context

- Current directory: !`pwd`
- File count: !`find . -name "*.js" -o -name "*.ts" -o -name "*.py" | wc -l`

## Task

Search for TODO comments in the codebase and list them with file locations.
```

### Complex Command with Tools
```markdown
---
argument-hint: [optional commit message]
description: Stage all changes and create intelligent commit
model: haiku
allowed-tools: Bash(git:*)
---

# Commit All Changes

## Context

- Current branch: !`git branch --show-current`
- Staged changes: !`git --no-pager diff --stat --cached --summary`
- Unstaged changes: !`git --no-pager diff --stat --summary`
- Recent commit history for context: !`git --no-pager log --oneline -10 --graph`
- Submodule pointer status: !`git --no-pager diff --submodule=log`
- Submodule status: !`git submodule foreach --recursive --quiet 'git status --porcelain 2>/dev/null | grep -q . && echo "UNCOMMITTED: $displaypath" || true'`

## Preflight Check
**Based on the provided context without further analysis:** determine if submodules have uncommitted changes, if so STOP and warn the user to commit submodule changes first

## Task

1. Analyze parent repo changes for safety issues (secrets, large files, generated content)
2. Stage parent repo changes: `git add -A`
3. If submodule pointers changed, include them in staging
4. Generate conventional commit message and commit
5. Report results
```

## Best Practices

- **Start with Context**: Always gather current system state
- **Be Specific**: Define exact steps and expected outcomes
- **Handle Errors**: Include error handling for common failure scenarios
- **Use Namespaces**: Organize related commands in subdirectories
- **Test Arguments**: Verify `$ARGUMENTS` handling works correctly

## Git Context Gathering

### Critical: Always Use --no-pager

Git commands in slash commands **must** use `--no-pager` to prevent interactive pagers from blocking execution.

### Essential Git Commands

```markdown
# Core Status Commands
- Current branch: !`git branch --show-current`
- Status (machine-readable): !`git status --porcelain`
- Staged changes: !`git --no-pager diff --stat --cached --summary`
- Unstaged changes: !`git --no-pager diff --stat --summary`

# History & Context
- Recent commit history: !`git --no-pager log --oneline -10 --graph`
- Full diff details: !`git --no-pager diff --color=never`

# Submodule Management
- Submodule pointer status: !`git --no-pager diff --submodule=log`
- Check uncommitted changes: !`git submodule foreach --recursive --quiet 'git status --porcelain 2>/dev/null | grep -q . && echo "UNCOMMITTED: $displaypath" || true'`
```

### Best Practices
- Use `--stat` with `--summary` for comprehensive change overviews
- Add `--color=never` to avoid ANSI escape sequences
- Limit history with `-n` flags (e.g., `-10` for last 10 commits)
- Use `--porcelain` for machine-readable output

### Preflight Checks

Include early validation steps to prevent wasted work:

```markdown
## Preflight Check
**Based on the provided context without further analysis:** 
determine if conditions are met, if not STOP and warn the user
```

### Tool Restrictions with allowed-tools

Commands can restrict which tools Claude can use via the `allowed-tools` frontmatter field:

```markdown
---
allowed-tools: Bash(git:*)
---
```

This prevents accidental file modifications when only git operations are intended.

## Advanced Prompting Techniques

### Response Format Control

Use XML tags to structure desired outputs:

```markdown
---
argument-hint: [component name]
description: Generate React component with structured output
---

# Generate Component

## Task

Create a React component named $ARGUMENTS.

Output the component code in <component_code> tags.
Output the test file in <test_code> tags.
Output usage examples in <usage_examples> tags.
```

### Thinking & Reasoning Guidance

Encourage deeper analysis with explicit thinking prompts:

```markdown
After examining the codebase:
1. Carefully reflect on the architectural patterns
2. Consider multiple implementation approaches
3. Select the most idiomatic solution
```

### Contextual Motivation

Provide rationale for specific behaviors:

```markdown
## Important

We follow trunk-based development, so all changes must be backward compatible.
This ensures zero-downtime deployments and smooth rollbacks.
```

### Explicit Encouragement

For comprehensive implementations:

```markdown
Implement a fully-featured solution including:
- Error handling
- Loading states
- Accessibility features
- Performance optimizations
Don't hold back - create production-ready code.
```

## Performance Optimization

### Parallel Tool Execution

Maximize efficiency with simultaneous operations:

```markdown
## Task

For maximum efficiency, simultaneously:
1. Run all test suites
2. Check lint status
3. Verify type safety
4. Analyze bundle size

Use parallel tool invocation for all independent operations.
```

### Context Size Management

Minimize context usage:

```markdown
---
model: haiku  # Use faster models for simple tasks
---

## Context

# Only gather essential information
- Changed files: !`git diff --name-only`
- Error count: !`npm test 2>&1 | grep -c "FAIL" || echo 0`
```

### Efficient File References

Use targeted file inclusions:

```markdown
# Instead of: @src/
# Use specific patterns: @src/**/*.test.js
# Or specific files: @src/main.js @src/utils.js
```

## CLAUDE.md Integration

### Leveraging Project Context

Commands automatically inherit CLAUDE.md context:

```markdown
---
description: Run project-specific quality checks
---

# Quality Check

## Task

Run the quality checks defined in CLAUDE.md:
1. Execute the lint command from CLAUDE.md
2. Run the test command from CLAUDE.md
3. Check code coverage thresholds
4. Verify no security vulnerabilities
```

### Context Precedence

1. Command-specific instructions (highest priority)
2. CLAUDE.md project guidelines
3. User preferences
4. Default Claude Code behavior

### Dynamic Context Loading

Reference CLAUDE.md sections:

```markdown
## Task

Follow the code style guidelines from CLAUDE.md while:
1. Implementing the requested feature
2. Ensuring consistency with existing patterns
3. Running the verification steps from CLAUDE.md
```

## Subagent Usage

### Delegating Complex Tasks

Use subagents for specialized work:

```markdown
---
description: Comprehensive code review with subagent
model: opus
---

# Deep Code Review

## Context

- Changed files: !`git diff --name-only`
- Complexity metrics: !`npx complexity-report src/`

## Task

1. Analyze the changes for potential issues
2. Use the general-purpose subagent to:
   - Check for security vulnerabilities
   - Identify performance bottlenecks
   - Suggest architectural improvements
3. Generate a detailed review report
```

### Subagent Patterns

```markdown
## Task

For thorough analysis:
1. Initial assessment of the problem
2. Launch general-purpose subagent for deep research
3. Consolidate findings
4. Implement solution based on research
```

## Testing & Debugging

### Test-Driven Command Development

Create commands that verify themselves:

```markdown
---
description: Self-testing command implementation
---

# Command Self-Test

## Validation

- Command file exists: !`test -f .claude/commands/$ARGUMENTS.md && echo "✓" || echo "✗"`
- Syntax valid: !`head -1 .claude/commands/$ARGUMENTS.md | grep -q "^---$" && echo "✓" || echo "✗"`

## Task

If validation passes, execute the command.
Otherwise, report specific failures.
```

### Debug Mode

Include debug information collection:

```markdown
## Debug Context (only in verbose mode)

- Environment: !`env | grep -E "CLAUDE|NODE|PATH" | head -20`
- Working directory: !`pwd`
- Tool availability: !`which git npm node | wc -l`
```

### Error Recovery Patterns

```markdown
## Task

1. Attempt primary approach
2. If errors occur:
   - Collect diagnostic information
   - Try alternative approach
   - Report detailed failure reasons
3. Always leave system in clean state
```

## Security & Permissions

### Tool Restriction Patterns

```markdown
---
allowed-tools: Read,Grep,LS  # Read-only operations
---

---
allowed-tools: Bash(npm:*),Read  # Only npm commands
---

---
allowed-tools: Edit(@src/**/*.js)  # Edit only JS files in src
---
```

### Security Checklist

Include security validations:

```markdown
## Security Check

- No secrets in staged files: !`git diff --cached | grep -iE "(api_key|password|secret|token)" && echo "WARNING: Potential secrets detected" || echo "✓ Clean"`
- File permissions correct: !`find . -type f -perm /111 -name "*.md" | wc -l | grep "^0$" && echo "✓" || echo "✗ Executable markdown files found"`
```

### Sandboxed Execution

```markdown
---
description: Run in restricted environment
allowed-tools: Bash(docker:*)
---

## Task

Execute all operations within Docker container:
1. `docker run --rm -it -v $(pwd):/workspace node:latest bash -c "..."` 
```

## Team Collaboration

### Command Documentation Standards

```markdown
---
author: @username
created: 2024-01-15
last-modified: 2024-01-20
team: frontend
tags: [react, testing, automation]
---

# Command Purpose

## Overview
Brief description for team members

## Prerequisites
- Required tools/setup
- Expected project structure

## Usage Examples
```

### Versioning Commands

```markdown
---
version: 2.0.0
changelog: |
  2.0.0: Added parallel execution
  1.1.0: Improved error handling
  1.0.0: Initial implementation
---
```

### Team Command Libraries

Organize shared commands:

```
.claude/commands/
├── team-shared/      # Shared across all projects
│   ├── review.md
│   ├── deploy.md
│   └── test.md
├── project-specific/ # This project only
│   ├── setup.md
│   └── migrate.md
└── personal/        # Individual developer
    └── shortcuts.md
```

## Command Composition

### Chaining Commands

Create workflows from multiple commands:

```markdown
---
description: Full deployment pipeline
---

# Deploy Pipeline

## Task

1. Run /test:all
2. Run /build:production
3. Run /deploy:staging
4. Run /test:e2e
5. Run /deploy:production
```

### Conditional Execution

```markdown
## Task

- Check build status: !`npm run build 2>&1`

If build succeeds:
  - Continue with deployment
Else:
  - Run /debug:build
  - Report failures
```

## Metrics & Monitoring

### Command Performance Tracking

```markdown
## Performance Baseline

- Start time: !`date +%s`
- Memory usage: !`ps aux | grep node | awk '{sum+=$6} END {print sum/1024 " MB"}'`

[... main task ...]

## Performance Report

- End time: !`date +%s`
- Files modified: !`git diff --stat | tail -1`
```

### Success Metrics

Define measurable outcomes:

```markdown
## Success Criteria

✓ All tests pass
✓ No linting errors
✓ Bundle size < 500KB
✓ Lighthouse score > 90
✓ No security vulnerabilities
```

## Agent Integration in Commands

### Leveraging Sub-Agents from Commands

Commands can delegate complex work to specialized agents:

```markdown
---
description: Comprehensive code analysis using multiple agents
allowed-tools: Task, TodoWrite
---

# Multi-Agent Code Review

## Task

Launch parallel agent analysis:
1. Use security-auditor agent for vulnerability scan
2. Use performance-analyst for bottleneck identification
3. Use test-engineer for coverage analysis
4. Consolidate findings into actionable report
```

### Agent Delegation Patterns

```markdown
## Task

For complex analysis, delegate to specialized agents:
- If debugging errors: Launch debug-specialist agent
- If optimizing performance: Launch perf-analyst agent
- If reviewing architecture: Launch architect agent

Consolidate agent findings and present unified recommendations.
```

### Optimal Agent Selection

```markdown
---
description: Smart routing to appropriate specialists
---

# Intelligent Task Router

## Context

- Task complexity: !`echo "$ARGUMENTS" | wc -w`
- File count: !`git diff --name-only | wc -l`

## Task

Route based on complexity:
- Simple (< 5 files): Execute directly
- Medium (5-20 files): Use Haiku model agent
- Complex (> 20 files): Use Opus model specialist
```

## Parallel Execution Patterns

### The 7-Parallel Pattern

Maximize efficiency with optimal parallelization:

```markdown
---
description: Execute multiple operations simultaneously
---

# Parallel Analyzer

## Task

Launch up to 7 parallel operations for maximum efficiency:

1. **Parallel Batch 1** (execute simultaneously):
   - Check all test suites
   - Analyze code coverage
   - Run security scan
   - Check dependency vulnerabilities
   - Validate documentation
   - Lint all files
   - Check type safety

2. **Consolidation Phase**:
   - Gather all results
   - Prioritize critical issues
   - Generate unified report
```

### Resource Grouping Strategy

```markdown
## Task

Group similar operations for parallel execution:

**File Analysis Batch** (parallel):
- Read all configuration files
- Scan source directories
- Check test coverage

**Validation Batch** (parallel):
- Run unit tests
- Execute integration tests
- Perform lint checks

**Optimization Batch** (sequential):
- Apply fixes based on analysis
- Verify corrections
```

### Dependency-Aware Parallelization

```markdown
---
description: Smart parallel execution with dependency management
---

# Dependency-Aware Builder

## Context

- Dependencies: !`npm ls --depth=0 | wc -l`
- Build targets: !`ls -1 src/*/index.* | wc -l`

## Task

1. **Independent Tasks** (parallel):
   - Clean build directories
   - Check environment variables
   - Validate configurations
   
2. **Dependent Tasks** (sequential):
   - Install dependencies
   - Build components in dependency order
   - Run post-build validation
```

## Token Optimization for Commands

### Minimal Context Commands

For frequently-used commands, minimize token usage:

```markdown
---
model: haiku  # Use fastest, cheapest model
allowed-tools: Bash  # Single tool only
---

# Quick Status

## Task

!`git status --short`
```

### Progressive Context Loading

Load context only when needed:

```markdown
---
description: Efficient context management
---

# Smart Analyzer

## Initial Context (minimal)

- File count: !`ls -1 | wc -l`

## Task

If file count > 100:
  Load detailed context for large project
Else:
  Proceed with minimal context

## Detailed Context (conditional)

@package.json  # Only loaded if needed
@tsconfig.json
```

### Tool Selection Matrix for Commands

| Command Type | Optimal Tools | Token Cost | Use Case |
|-------------|--------------|------------|----------|
| Status Check | Bash | ~1,800 | Quick queries |
| Code Analysis | Read, Grep, Glob | ~3,200 | Research tasks |
| Simple Edit | Read, Edit | ~2,900 | Focused changes |
| Complex Refactor | Read, Edit, MultiEdit, Bash | ~4,500 | Major changes |
| Orchestration | Task, TodoWrite | ~3,100 | Multi-agent coordination |

### Token-Efficient Patterns

```markdown
---
description: Maximum efficiency patterns
---

# Efficient Command

## Optimization Strategies

1. **Use --no-pager for git**: Prevents blocking
2. **Limit output with head/tail**: !`command | head -20`
3. **Use counts instead of full output**: !`grep -c pattern file`
4. **Compress multi-line into single**: !`command | tr '\n' ' '`
5. **Use exit codes for checks**: !`test -f file && echo "✓" || echo "✗"`
```

## Command Success Metrics

### Tracking Command Performance

```markdown
---
description: Self-monitoring command
---

# Performance-Tracked Command

## Start Metrics

- Start time: !`date +%s`
- Initial memory: !`ps -o rss= -p $$`

## Task

[Main command logic here]

## End Metrics

- End time: !`date +%s`
- Final memory: !`ps -o rss= -p $$`
- Files changed: !`git diff --stat | tail -1`

## Success Criteria

✓ Completed in < 5 seconds
✓ Memory usage < 100MB increase
✓ All tests still pass
✓ No new linting errors
```

### Command Effectiveness Metrics

Define measurable success criteria:

```markdown
## Success Validation

- Tests pass: !`npm test 2>&1 | grep -q "failed: 0" && echo "✓" || echo "✗"`
- Coverage maintained: !`npm run coverage | grep -o "[0-9]*%" | head -1`
- Performance baseline: !`npm run benchmark | grep "ops/sec"`
- No security issues: !`npm audit --audit-level=high 2>&1 | grep -q "0 vulnerabilities" && echo "✓" || echo "✗"`
```

### A/B Testing Commands

```markdown
---
description: Command with variant testing
---

# Optimized Command v2

## Variant Selection

- Random variant: !`echo $((RANDOM % 2))`

## Task

If variant is 0:
  Use approach A (traditional method)
Else:
  Use approach B (optimized method)

## Metrics Collection

Log performance for analysis:
- Variant used
- Execution time
- Success/failure
- Resource usage
```

### Command Usage Analytics

```markdown
---
description: Usage tracking for optimization
---

# Tracked Command

## Usage Log

- Command invoked: !`echo "$(date): $ARGUMENTS" >> ~/.claude/command-usage.log`
- Previous uses: !`grep -c "$(basename $0)" ~/.claude/command-usage.log || echo 0`

## Task

[Main logic]

## Post-Execution

- Log result: !`echo "Result: success/failure" >> ~/.claude/command-usage.log`
```

## Command Anti-Patterns to Avoid

### Inefficient Patterns

```markdown
# ❌ AVOID: Loading entire directories
@src/  # Loads all files

# ✓ BETTER: Load specific files
@src/main.js @src/utils.js

# ❌ AVOID: Unbounded output
!`git log`  # Could be thousands of lines

# ✓ BETTER: Limited output
!`git log --oneline -10`

# ❌ AVOID: All tools without need
allowed-tools: # All tools available

# ✓ BETTER: Specific tools
allowed-tools: Read, Edit, Bash
```

### Context Pollution

```markdown
# ❌ AVOID: Redundant context
- Full git history: !`git log`
- All branches: !`git branch -a`
- Complete file list: !`find .`

# ✓ BETTER: Essential context only
- Recent commits: !`git log --oneline -5`
- Current branch: !`git branch --show-current`
- Changed files: !`git diff --name-only`
```

## Visual & Interactive Commands

### Screenshot Integration

```markdown
---
description: Visual regression testing
---

# Visual Test

## Context

- Current branch: !`git branch --show-current`
- Last screenshot: @tests/screenshots/baseline.png

## Task

1. Run the application
2. Take screenshot of current state
3. Compare with baseline image
4. Report visual differences
5. Update baseline if changes are intentional
```

### Progress Indicators

```markdown
## Task Progress

1. [▶] Initialize environment
2. [▶] Run validation checks
3. [▶] Execute main task
4. [▶] Cleanup temporary files
5. [▶] Generate report

Update progress indicators as each step completes.
```

## Command Lifecycle Management

### Deprecation Handling

```markdown
---
deprecated: true
replacement: /new:command
deprecation-message: This command will be removed in v3.0.0
---
```

### Migration Paths

```markdown
## Migration Notice

This command is deprecated. Please use:
- For simple cases: /quick:fix
- For complex cases: /deep:analysis
- For legacy support: /legacy:fix --compatibility
```
