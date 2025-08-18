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

## Core Architecture & Philosophy

### Parallel Task Delegation
Subagents operate like programming threads, performing independent operations simultaneously for improved execution efficiency. "Like programming with threads, explicit orchestration of which steps get delegated to sub-agents yields the best results."

### Key Architectural Principles
- **Explicit Orchestration**: The main agent coordinates subagent activities with careful task delegation
- **Context Isolation**: Each subagent maintains its own context window, preventing pollution
- **Pattern Extension**: Beyond simple task execution, subagents recognize and creatively extend patterns
- **Agent-First Design**: Moving beyond human task automation to enabling agents as creative partners

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

## Quick Start Guide

1. **Open the subagents interface**: Run `/agents`
2. **Select 'Create New Agent'**: Choose project-level or user-level subagent
3. **Define the subagent**:
   - Generate with Claude first, then customize (recommended approach)
   - Describe the subagent in detail and when it should be used
   - Select tools to grant access to (or leave blank to inherit all tools)
   - Edit system prompt in your preferred editor by pressing `e`
4. **Save and use**: Subagent becomes available automatically or via explicit invocation

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

## Advanced Patterns & Workflows

### The 7-Parallel-Task Method

For maximum efficiency when dealing with multiple related tasks:

1. **Identify Parallelizable Tasks**: Find operations that don't depend on each other
2. **Group by Resource Type**: Batch similar operations (file reads, searches, etc.) to improve token efficiency
3. **Launch Up to 7 Tasks Simultaneously**: This represents the optimal balance between parallel processing and context management
4. **Explicit Orchestration**: Provide detailed delegation instructions for each parallel task
5. **Consolidate Results**: Gather outputs and proceed with sequential dependencies
6. **Verify Integration**: Run tests, linting, and builds after parallel completion
7. **Iterate Based on Results**: Use findings to inform next parallel batch

**Key Principle**: "Like programming with threads, explicit orchestration of which steps get delegated to sub-agents yields the best results."

### Split-Role Sub-Agents Pattern

Enable multiple specialized agent perspectives to analyze a single task simultaneously:

#### Implementation Strategy
1. **Activate Plan Mode** for safe exploration
2. **Enable ultrathink** for enhanced reasoning capabilities
3. **Define specific, non-overlapping role perspectives**
4. **Launch sub-agents to analyze tasks concurrently**
5. **Consolidate findings from all perspectives**

#### Common Role Divisions

**Code Review Roles:**
- Factual Analyst: Objective code correctness
- Senior Engineer: Architectural decisions and best practices
- Security Expert: Vulnerability identification
- Consistency Reviewer: Code style and pattern adherence

**Benefits**: Comprehensive analysis, cost-effective intelligence, parallel processing, enhanced problem-solving

### Task Type Analysis for Subagent Selection

#### Perfect Parallelizable Tasks
Tasks ideal for immediate sub-agent parallelization:
- **Non-destructive operations**: Research, analysis, comparison matrices
- **Isolated workflows**: Each agent works independently without interference
- **Consolidatable outputs**: Results can be merged by the main agent

*Example*: "Research 8 different MCPs and write pros/cons for each" - perfect for parallel sub-agents.

#### The Consolidation Strategy
For tasks requiring coordination:
1. **Enter Plan Mode** for non-destructive execution
2. **Deploy parallel sub-agents** for different perspectives
3. **Consolidate suggestions** in the main agent
4. **Clear context if needed** to action suggestions from a fresh start

## Advanced Debugging & Quality Patterns

### Systematic Testing Approach
1. **Isolation Testing**: Test each agent independently before integration
2. **Edge Case Validation**: Explicitly test boundary conditions and error scenarios
3. **Performance Benchmarking**: Measure response time, token usage, and accuracy
4. **Integration Testing**: Verify agent interactions in composed workflows

### Common Issues and Solutions
| Issue | Symptoms | Solution |
|-------|----------|----------|
| **Context Loss** | Agent forgets previous information | Ensure proper context preservation in prompts |
| **Tool Misuse** | Agent uses wrong tools | Refine tool descriptions and constraints |
| **Over-delegation** | Too many sub-tasks created | Add explicit limits in system prompts |
| **Token Overflow** | Responses cut off | Implement chunking strategies |

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

### Agent Weight Classifications

Agents are categorized by token usage to optimize performance and cost:

| Weight Class | Token Range | Use Cases | Recommended Model | Initialization Impact |
|--------------|-------------|-----------|-------------------|----------------------|
| **Lightweight** | <3,000 tokens | Simple, frequent tasks like file operations, basic searches | Haiku | Low cost, high composability |
| **Medium-weight** | 10,000-15,000 tokens | Balanced complexity with moderate reasoning | Sonnet | Moderate cost, balanced performance |
| **Heavy** | 25,000+ tokens | Complex analysis, deep reasoning, sophisticated problem-solving | Opus | High cost, workflow bottlenecks |

**Critical Insight**: Lightweight agents are the most composable and effortless to use. They enable fluid orchestration in multi-agent workflows.

### Token Usage by Tool Count
Approximate token costs for agent initialization:
- **0 tools**: ~640 tokens (best case with empty CLAUDE.md)
- **1-3 tools**: 2.6k - 3.2k tokens
- **4-6 tools**: 3.4k - 4.1k tokens
- **7-10 tools**: 5k - 7.9k tokens
- **15+ tools**: 13.9k - 25k+ tokens

### Cost-Performance Optimization

**Current Pricing Reality (2025)**:
- Premium Models: Claude Opus ($15/$75 per million tokens)
- Mid-Tier Options: Claude Sonnet ($3/$15 per million tokens)
- Budget-Friendly: Claude Haiku ($0.25/$1.25 per million tokens)

**"Rev the Engine" Technique**: Maximize single-model performance before escalating to expensive models.

### Optimization Strategies
- **Context preservation**: Isolated contexts prevent token bloat in main conversation
- **Chainability**: Lightweight agents enable fluid multi-agent workflows
- **Latency management**: Tool count directly impacts initialization time (2.6s - 7s+)
- **Parallel execution**: Multiple subagents can work simultaneously on independent tasks
- **Cost efficiency**: Match agent weight to task frequency for optimal token usage
- **A.B.E. (Always Be Experimenting)**: Test unconventional model/agent combinations for breakthrough discoveries

## Advanced Features

### No CLAUDE.md Inheritance
Subagents do not automatically inherit the project's CLAUDE.md configuration, preventing context pollution and ensuring consistent behavior across projects.

### Visual Distinction
Subagents can be visually distinguished through terminal color formatting in their indicator, making it easier to track which agent is responding during complex workflows.

### Tool SEO
Configuring automatic delegation is a form of "Tool SEO" - optimize your agent's name, description, and trigger phrases to improve Claude's reliability in invoking your agent automatically.

### Humanizing Agents with Personality

Transform mechanical interactions into natural, personalized collaborations using the Text-Face Personality System:

| Role Category | Personality Traits | Text-Face Examples | Focus Areas |
|---|---|---|---|
| **Debugging & Testing** | Playful, aggressive, skeptical | (ง'̀-'́)ง, ಠ_ಠ, (╯°□°)╯ | Finding bugs, breaking things, edge cases |
| **Code Review & Quality** | Laid-back, detail-oriented, security-focused | ( ͡° ͜ʖ ͡°), (▀̿Ĺ̯▀̿ ̿), ʕ•ᴥ•ʔ | Architecture, security, best practices |
| **Performance & Optimization** | High-energy, efficiency-driven | ⚡(ﾉ◕ヮ◕)ﾉ⚡, (⌐■_■), ༼ つ ◕_◕ ༽つ | Speed, efficiency, resource usage |
| **Development & Refactoring** | Gentle, friendly, focused | (◕‿◕), (´･ω･`), ♪(´▽｀) | Code improvement, restructuring |
| **Documentation & Communication** | Loving, sweet, intense | (♥‿♥), ✿◕ ‿ ◕✿, (づ｡◕‿‿◕｡)づ | Clarity, accessibility, user guidance |

**Implementation Guidelines:**
- Start conservative and increase based on team reception
- Match personality to function for enhanced collaboration
- Consider team dynamics and professional context

## Getting Started

1. **Foundation First**: Start with one simple, focused agent that solves a specific problem
2. **Token Optimization**: Begin with lightweight agents (minimal tools) for maximum composability
3. **Test Reliability**: Verify automatic activation before expanding functionality
4. **Iterate Based on Data**: Let empirical results guide optimization, not assumptions
5. **Share Discoveries**: Contribute findings to expand collective knowledge

## Management & Integration

### Using /agents Command (Recommended)

The `/agents` command provides a comprehensive interface for:
- Viewing all available subagents (built-in, user, and project)
- Creating new subagents with guided setup
- Editing existing custom subagents and their tool access
- Deleting custom subagents
- Managing tool permissions with complete tool listings

### Team Collaboration
- Share subagents through version control
- Standardize workflows across team members
- Maintain consistent code quality and practices

## Summary

Subagents represent the evolution from prompt engineering to agent engineering - specialized, portable, and efficient AI assistants that automatically handle specific tasks. They offer isolated contexts, surgical tool selection, and can be optimized for different performance profiles based on token usage and model selection.

The combination of automatic delegation and explicit invocation makes them suitable for both proactive assistance and directed task execution. Through careful design, optimization, and humanization, subagents become valuable collaborative partners in the development process.

Key success factors:
- Start simple with lightweight agents for maximum composability
- Optimize for tokens to control costs and performance
- Experiment with unconventional model/agent combinations (A.B.E. methodology)
- Use parallel processing patterns like the 7-Parallel-Task Method
- Leverage advanced patterns like Split-Role Sub-Agents for comprehensive analysis
- Share discoveries with the community to advance collective knowledge
