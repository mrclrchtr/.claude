# Claude Code Subagents - Creation Guide

## Overview

**Subagents** are specialized AI assistants within Claude Code that handle specific types of tasks with their own dedicated context windows, custom system prompts, and configurable tool access.

Subagents represent a paradigm shift in AI workflows from manual orchestration to automatic delegation, from project-specific solutions to portable specialist tools. They are pre-configured AI personalities that operate independently from the main Claude Code conversation, featuring:

- Specific expertise areas with focused responsibilities
- Isolated context windows preventing token bloat
- Configurable tool access for surgical precision
- Custom system prompts that guide behavior and approach
- Automatic activation based on task matching
- Portability across projects (single .md file)

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

You are a [role/specialty description]. Your subagent's system prompt 
should start with "You are a" to clearly establish the agent's identity.
This can be multiple paragraphs and should clearly define the subagent's 
role, capabilities, and approach to solving problems.
```

### Configuration Fields

- **`name`** (Required): Unique identifier using lowercase letters and hyphens. Consider short nicknames for frequently used agents (e.g., "a1" for quick invocation)
- **`description`** (Required): Natural language description of the subagent's purpose. Include phrases like "use PROACTIVELY" or "MUST BE USED" for more reliable automatic activation (Tool SEO)
- **`tools`** (Optional): Comma-separated list of specific tools. If omitted, inherits all tools from the main thread. Minimize tool count for better token efficiency
- **`model`** (Optional): Specify which Claude model the agent should use (https://docs.anthropic.com/en/docs/about-claude/models/overview.md). Match model to task complexity for optimal cost/performance

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

### Nickname Usage

Configure short nicknames for efficiency:
```
> ask a1 to review the navigation UX
> ask s1 to check for security issues
> ask p1, c1, a1 to review the changes (multi-agent invocation)
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

### Token-First Design
- **Optimize initialization cost**: Each agent invocation has a token cost based on tool count and configuration
- **Lightweight agents** (< 3k tokens): Ideal for frequent tasks, maximum composability
- **Medium agents** (10-15k tokens): Balanced for moderate complexity
- **Heavy agents** (25k+ tokens): Reserve for complex analysis requiring deep reasoning

### Configuration Best Practices
- **Start with Claude-generated agents**: Generate initial subagent with Claude, then customize
- **Design focused subagents**: Create subagents with single, clear purposes and responsibilities
- **Write detailed system prompts**: Include specific instructions, examples, and constraints
- **Use "You are a" pattern**: Begin system prompts with "You are a [role]" for clarity and consistency (e.g., "You are an expert architect", "You are a systematic debugging specialist")
- **Limit tool access**: Only grant necessary tools - fewer tools mean faster initialization
- **Make descriptions action-oriented**: Write specific, actionable description fields with trigger phrases
- **Test thoroughly**: Verify subagent behavior and automatic activation reliability
- **Version control**: Check project subagents into version control for team collaboration

### Model Selection Strategy
- **Haiku + Lightweight agents**: Frequent, simple tasks with minimal cost
- **Sonnet + Medium agents**: Balanced approach for moderate complexity
- **Opus + Heavy agents**: Complex analysis requiring maximum reasoning
- **Experiment freely**: Test unconventional model/agent combinations for breakthrough discoveries

## Performance Considerations

### Token Usage by Tool Count
Approximate token costs for agent initialization:
- **0 tools**: ~640 tokens (best case with empty CLAUDE.md)
- **1-3 tools**: 2.6k - 3.2k tokens
- **4-6 tools**: 3.4k - 4.1k tokens
- **7-10 tools**: 5k - 7.9k tokens
- **15+ tools**: 13.9k - 25k+ tokens

### Optimization Strategies
- **Context preservation**: Isolated contexts prevent token bloat in main conversation
- **Chainability**: Lightweight agents enable fluid multi-agent workflows
- **Latency management**: Tool count directly impacts initialization time (2.6s - 7s+)
- **Parallel execution**: Multiple subagents can work simultaneously on independent tasks
- **Cost efficiency**: Match agent weight to task frequency for optimal token usage

## Advanced Features

### No CLAUDE.md Inheritance
Subagents do not automatically inherit the project's CLAUDE.md configuration, preventing context pollution and ensuring consistent behavior across projects.

### Visual Distinction
Subagents can be visually distinguished through terminal color formatting in their indicator, making it easier to track which agent is responding during complex workflows.

### Tool SEO
Configuring automatic delegation is a form of "Tool SEO" - optimize your agent's name, description, and trigger phrases to improve Claude's reliability in invoking your agent automatically.

## Getting Started

1. **Foundation First**: Start with one simple, focused agent that solves a specific problem
2. **Token Optimization**: Begin with lightweight agents (minimal tools) for maximum composability
3. **Test Reliability**: Verify automatic activation before expanding functionality
4. **Iterate Based on Data**: Let empirical results guide optimization, not assumptions
5. **Share Discoveries**: Contribute findings to expand collective knowledge

## Summary

Subagents represent the evolution from prompt engineering to agent engineering - specialized, portable, and efficient AI assistants that automatically handle specific tasks. They offer isolated contexts, surgical tool selection, and can be optimized for different performance profiles based on token usage and model selection. The key to success is starting simple, optimizing for tokens, and experimenting with different configurations to find breakthrough combinations.
