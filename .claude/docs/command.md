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
---

# Commit All Changes

## Context

- Git status: !`git status --porcelain`
- Staged changes: !`git diff --cached`
- Unstaged changes: !`git diff`
- Current branch: !`git branch --show-current`

## Task

1. Stage all changes with `git add .`
2. Analyze changes to create appropriate commit message
3. Use provided argument as message or generate intelligent one
4. Execute commit and verify success
```

## Best Practices

- **Start with Context**: Always gather current system state
- **Be Specific**: Define exact steps and expected outcomes
- **Handle Errors**: Include error handling for common failure scenarios
- **Use Namespaces**: Organize related commands in subdirectories
- **Test Arguments**: Verify `$ARGUMENTS` handling works correctly