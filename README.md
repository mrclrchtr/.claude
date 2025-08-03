# cc-base

A simple base project for tracking Claude Code custom slash commands, agents, and related configurations. This project serves as a reusable foundation that can be integrated into other projects to quickly set up Claude Code customizations.

## Features

### Custom Slash Commands
- **Commit Commands**: Automated git staging and conventional commit message generation
  - `/commit/all` - Stage all changes and commit with generated conventional commit message
  - `/commit/changed` - Stage and commit only modified/created files from current session with generated conventional commit message

- **Milestone Commands**: Implementation plan-based milestone management
  - `/milestone/create [identifier]` - Extract specific milestone from IMPLEMENTATION_PLAN.md and create milestone document with template structure
  - `/milestone/next [milestone_name]` - Execute complete milestone lifecycle from planning to completion with deliverable tracking
  - `/milestone/meta` - Sync milestone manager with existing milestone files and maintain sequential numbering

- **Meta Commands**: Command optimization and management
  - `/meta/optimize-command [command-path]` - Optimize slash command efficiency while preserving robustness and error handling

### Specialized Agents
- **Architecture Planner**: Transform vision documents into detailed implementation plans and create milestone breakdowns with technical specifications

### Configuration
- **Permissions Management**: Predefined tool permissions for bash commands, web fetching, and MCP servers
- **MCP Integration**: Configured for Zen MCP server integration
- **Templates**: Reusable templates for tasks and milestones

## Structure
```
.claude/
├── agents/              # Custom agent definitions
├── commands/            # Slash command definitions
├── docs/               # Documentation and guides
├── scripts/            # Utility scripts
├── templates/          # Reusable templates
└── settings.local.json # Local configuration
```