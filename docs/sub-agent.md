# Claude Code Subagents - Creation Guide

## Overview

**Subagents** are specialized AI assistants within Claude Code that handle specific types of tasks with their own dedicated context windows, custom system prompts, and configurable tool access.

Subagents are pre-configured AI personalities that operate independently from the main Claude Code conversation, featuring:
- Specific expertise areas
- Isolated context windows
- Configurable tool access
- Custom system prompts that guide behavior and approach

## Configuration & Setup

### File Locations & Priority

| Type | Location | Scope | Priority |
|------|----------|-------|----------|
| **Project subagents** | `.claude/agents/` | Available in current project | Highest |
| **User subagents** | `~/.claude/agents/` | Available across all projects | Lower |

*Note: Project-level subagents take precedence over user-level subagents when names conflict.*

### Configuration Format

Subagents are defined as Markdown files with YAML frontmatter:

```markdown
---
name: your-sub-agent-name
description: Description of when this subagent should be invoked
tools: tool1, tool2, tool3  # Optional - inherits all tools if omitted
model: claude-sonnet-4-0  # Optional - specify Claude model
---

Your subagent's system prompt goes here. This can be multiple paragraphs
and should clearly define the subagent's role, capabilities, and approach
to solving problems.
```

### Configuration Fields

- **`name`** (Required): Unique identifier using lowercase letters and hyphens
- **`description`** (Required): Natural language description of the subagent's purpose. Include phrases like "use PROACTIVELY" or "MUST BE USED" for more proactive use
- **`tools`** (Optional): Comma-separated list of specific tools. If omitted, inherits all tools from the main thread
- **`model`** (Optional): Specify which Claude model the agent should use (https://docs.anthropic.com/en/docs/about-claude/models/overview.md)

### Tool Configuration Options

1. **Omit the `tools` field**: Inherit all tools from main thread (default), including MCP tools
2. **Specify individual tools**: Comma-separated list for granular control

## Usage Methods

### Automatic Delegation

Claude Code proactively delegates tasks based on:
- Task description in your request
- The `description` field in subagent configurations
- Current context and available tools

To improve reliability:
- Update your agent's name for clarity
- Refine the description field with action-oriented language
- Include "use PROACTIVELY" or "MUST BE USED" in descriptions

### Explicit Invocation

Request specific subagents by mentioning them:
```
> Use the test-runner subagent to fix failing tests
> Have the code-reviewer subagent look at my recent changes
> Ask the debugger subagent to investigate this error
```

### Chaining Subagents

For complex workflows, chain multiple subagents:
```
> First use the code-analyzer subagent to find issues, then use the optimizer subagent to fix them
```

### Example Subagents

#### Code Reviewer
- **Purpose**: Expert code review for quality, security, and maintainability
- **Tools**: Read, Grep, Glob, Bash

#### Debugger
- **Purpose**: Debugging specialist for errors, test failures, and unexpected behavior
- **Tools**: Read, Edit, Bash, Grep, Glob

#### Data Scientist
- **Purpose**: Data analysis expert for SQL queries and insights
- **Tools**: Bash, Read, Write

## Best Practices

- **Start with Claude-generated agents**: Generate initial subagent with Claude, then customize
- **Design focused subagents**: Create subagents with single, clear purposes and responsibilities
- **Write detailed system prompts**: Include specific instructions, examples, and constraints
- **Limit tool access**: Only grant necessary tools for security and focus
- **Make descriptions action-oriented**: Write specific, actionable description fields
- **Test thoroughly**: Verify subagent behavior before deploying widely
- **Version control**: Check project subagents into version control for team collaboration

## Performance Considerations

- **Context preservation**: Helps preserve main conversation context
- **Latency**: May add slight latency during initial context gathering
- **Parallel execution**: Multiple subagents can work simultaneously on independent tasks

## Summary

Subagents are specialized AI assistants that handle specific tasks with their own context windows and configurable tool access. They can be created at project level (`.claude/agents/`) or user level (`~/.claude/agents/`) and are configured using Markdown files with YAML frontmatter. The `/agents` command provides an easy interface for creating and managing subagents.
