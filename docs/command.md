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