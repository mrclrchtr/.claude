# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# Project: Claude Code Customization Framework
**You are an expert framework developer working with custom AI agents and command-based workflows.**

## Project Structure
```
.claude/
├── agents/                 # Custom AI agent definitions
├── commands/              # Custom slash commands
├── templates/             # Structured templates
├── docs/                  # Framework documentation
└── scripts/               # Automation scripts
```

## Creating Custom Commands

Commands are markdown files in `.claude/commands/` that become slash commands.

### Basic Command Structure
```markdown
---
description: Brief description
argument-hint: [optional args]
model: haiku|sonnet|opus
allowed-tools: Read,Edit,Bash
---

# Command Purpose

## Context
- Dynamic values: !`shell command`
- File inclusion: @path/to/file

## Task
Handle $ARGUMENTS and perform steps.
```

**Key Features:**
- `$ARGUMENTS` - User input passed to command
- `!`command`` - Execute bash and include output
- `@file` - Include file contents
- `allowed-tools` - Restrict available tools

For complete command creation guide, see: **`.claude/docs/command.md`**

## Creating Custom Agents

Agents are markdown files in `.claude/agents/` that define specialized AI assistants.

### Basic Agent Structure
```markdown
---
name: agent-identifier
description: MUST BE USED PROACTIVELY when [trigger conditions]. Expert at [domain].
tools: Read, Edit, Bash, Grep
model: claude-sonnet-4-0-20241220
---

You are a specialized assistant. Define role and behavior.
```

**Key Elements:**
- Strong trigger phrases for automatic activation
- Minimal tool set for efficiency
- Appropriate model selection
- Clear specialization

For complete agent creation guide, see: **`.claude/docs/sub-agent.md`**

## Framework Documentation

- **Command Creation**: `.claude/docs/command.md` - Complete guide for creating custom commands
- **Agent Creation**: `.claude/docs/sub-agent.md` - Guide for creating specialized AI agents
- **Context Patterns**: `.claude/docs/context.md` - Bash command patterns for gathering context
- **Optimization**: `.claude/docs/optimization-patterns.md` - Token and performance optimization
