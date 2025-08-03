# Claude Code Subagents - Comprehensive Summary

## Overview

**Subagents** are specialized AI assistants within Claude Code that handle specific types of tasks with their own dedicated context windows, custom system prompts, and configurable tool access. They enable more efficient problem-solving by providing task-specific configurations while preserving the main conversation context.

## What Are Subagents?

Subagents are pre-configured AI personalities that operate independently from the main Claude Code conversation. Each subagent features:

- **Specific expertise area** with focused purpose
- **Isolated context window** separate from main conversation
- **Configurable tool access** with granular permissions
- **Custom system prompt** that guides behavior and approach

## Key Benefits

### Context Preservation
Each subagent operates in its own context, preventing pollution of the main conversation and keeping it focused on high-level objectives.

### Specialized Expertise
Subagents can be fine-tuned with detailed instructions for specific domains, leading to higher success rates on designated tasks.

### Reusability
Once created, subagents can be used across different projects and shared with your team for consistent workflows.

### Flexible Permissions
Each subagent can have different tool access levels, allowing you to limit powerful tools to specific subagent types.

## Quick Start Guide

1. **Open the subagents interface**: Run `/agents`
2. **Select 'Create New Agent'**: Choose project-level or user-level subagent
3. **Define the subagent**:
   - Generate with Claude first, then customize (recommended approach)
   - Describe the subagent in detail and when it should be used
   - Select tools to grant access to (or leave blank to inherit all tools)
   - Edit system prompt in your preferred editor by pressing `e`
4. **Save and use**: Subagent becomes available automatically or via explicit invocation

## Configuration

### File Locations

| Type | Location | Scope | Priority |
|------|----------|-------|----------|
| **Project subagents** | `.claude/agents/` | Available in current project | Highest |
| **User subagents** | `~/.claude/agents/` | Available across all projects | Lower |

*Note: Project-level subagents take precedence over user-level subagents when names conflict.*

### File Format

Subagents are defined as Markdown files with YAML frontmatter:

```markdown
---
name: your-sub-agent-name
description: Description of when this subagent should be invoked
tools: tool1, tool2, tool3  # Optional - inherits all tools if omitted
---

Your subagent's system prompt goes here. This can be multiple paragraphs
and should clearly define the subagent's role, capabilities, and approach
to solving problems.
```

### Configuration Fields

- **`name`** (Required): Unique identifier using lowercase letters and hyphens
- **`description`** (Required): Natural language description of the subagent's purpose
- **`tools`** (Optional): Comma-separated list of specific tools. If omitted, inherits all tools from the main thread

### Tool Configuration Options

1. **Omit the `tools` field**: Inherit all tools from main thread (default), including MCP tools
2. **Specify individual tools**: Comma-separated list for granular control

## Management

### Using /agents Command (Recommended)

The `/agents` command provides a comprehensive interface for:

- Viewing all available subagents (built-in, user, and project)
- Creating new subagents with guided setup
- Editing existing custom subagents and their tool access
- Deleting custom subagents
- Managing tool permissions with complete tool listings
- Seeing which subagents are active when duplicates exist

### Direct File Management

You can also manage subagents by working directly with their files in the `.claude/agents/` or `~/.claude/agents/` directories.

## Usage Methods

### Automatic Delegation

Claude Code proactively delegates tasks based on:
- Task description in your request
- The `description` field in subagent configurations
- Current context and available tools

*Tip: Include phrases like "use PROACTIVELY" or "MUST BE USED" in your description field for more proactive use.*

### Explicit Invocation

Request specific subagents by mentioning them:
```
> Use the test-runner subagent to fix failing tests
> Have the code-reviewer subagent look at my recent changes
> Ask the debugger subagent to investigate this error
```

## Example Subagents

### Code Reviewer
**Purpose**: Expert code review for quality, security, and maintainability
**Tools**: Read, Grep, Glob, Bash
**Key Features**: Runs git diff, focuses on modified files, provides prioritized feedback

### Debugger
**Purpose**: Debugging specialist for errors, test failures, and unexpected behavior
**Tools**: Read, Edit, Bash, Grep, Glob
**Key Features**: Root cause analysis, systematic debugging process, minimal fixes

### Data Scientist
**Purpose**: Data analysis expert for SQL queries, BigQuery operations, and insights
**Tools**: Bash, Read, Write
**Key Features**: Optimized SQL queries, BigQuery CLI tools, data-driven recommendations

## Best Practices

### Design Principles
- **Start with Claude-generated agents**: Generate initial subagent with Claude, then customize
- **Design focused subagents**: Create subagents with single, clear responsibilities
- **Write detailed prompts**: Include specific instructions, examples, and constraints
- **Limit tool access**: Only grant necessary tools for security and focus

### Operational Best Practices
- **Version control**: Check project subagents into version control for team collaboration
- **Make descriptions action-oriented**: Write specific, actionable description fields
- **Test thoroughly**: Verify subagent behavior before deploying to team

## Advanced Usage

### Chaining Subagents
For complex workflows, chain multiple subagents:
```
> First use the code-analyzer subagent to find performance issues, then use the optimizer subagent to fix them
```

### Dynamic Selection
Claude Code intelligently selects subagents based on context and task requirements.

## Performance Considerations

### Benefits
- **Context efficiency**: Agents preserve main context, enabling longer overall sessions
- **Specialized processing**: Task-specific optimization improves results

### Trade-offs
- **Latency**: Subagents start with clean slate and may add latency while gathering required context
- **Setup overhead**: Initial configuration requires time investment

## Integration Points

### Related Features
- **Slash commands**: Other built-in Claude Code commands
- **Settings**: Configure Claude Code behavior
- **Hooks**: Automate workflows with event handlers
- **MCP Tools**: Subagents can access MCP tools from configured servers

### Team Collaboration
- Share subagents through version control
- Standardize workflows across team members
- Maintain consistent code quality and practices

## Summary

Subagents represent a powerful way to extend Claude Code's capabilities through specialized, reusable AI assistants. They provide context isolation, task-specific expertise, and flexible tool management while maintaining the efficiency and focus of the main conversation. The combination of automatic delegation and explicit invocation makes them suitable for both proactive assistance and directed task execution.