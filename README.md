# cc-base

A comprehensive Claude Code customization framework that transforms your development workflow with sophisticated milestone-driven project management, advanced memory optimization, session tracking, and specialized AI agents. This enterprise-ready foundation provides a complete ecosystem for teams seeking systematic, scalable development practices.

## Features

### 🏗️ Specialized Agents (3)
Powerful AI specialists with multi-perspective analysis and parallel task orchestration:

- **Architecture Planner** - Expert software architect using multi-perspective analysis (Technical, Security, Performance, Operations) and 7-Parallel-Task Method for actionable technical roadmaps
- **Debug Solution Engineer** - Systematic problem analysis specialist providing root cause analysis and actionable solutions for runtime errors, logic bugs, and performance issues
- **Milestone Planner** - Implementation plan transformer creating trackable milestones with parallel task orchestration, timeline estimation, and comprehensive project decomposition

### 📋 Custom Slash Commands (25+)
Comprehensive command suite across 7 categories for complete workflow automation:

#### Commit Management
- `/commit/main` - Commit parent repository changes and submodule pointer updates with safety checks
- `/commit/changed` - Stage and commit modified/created files from current session with generated conventional commit message
- `/commit/review [commit_hash]` - Critical commit analysis with comprehensive review (size classification, risk assessment, test verification)
- `/commit/submodules` - Commit changes within submodules separately from parent repository

#### Documentation Management
- `/docs/audit` - Comprehensive documentation audit identifying inconsistencies, missing cross-references, and conflicts across all markdown files

#### Advanced Memory Management
- `/meta/optimize-command [command-path]` - Optimize slash command efficiency while preserving robustness and error handling
- `/meta/optimize-memory [path/to/CLAUDE.md]` - Optimize CLAUDE.md following Anthropic's memory best practices with comprehensive analysis
- `/meta/consolidate-memory [focus_area]` - Intelligent consolidation of all CLAUDE.md files with deduplication and cross-referencing
- `/meta/create-memory [target/directory]` - Create comprehensive CLAUDE.md files using technology detection and pattern extraction
- `/meta/optimize-agent [agent-path]` - Optimize agent definitions for efficiency and effectiveness
- `/meta/update-memory` - Update existing CLAUDE.md files with latest project patterns and configurations

#### Milestone-Driven Development
- `/milestone/create [identifier]` - Extract specific milestone from IMPLEMENTATION_PLAN.md using milestone-planner agent with template structure
- `/milestone/next [milestone_name]` - Execute complete milestone lifecycle from planning to completion with deliverable tracking and documentation updates
- `/milestone/meta` - Sync milestone manager with existing milestone files and maintain sequential numbering
- `/milestone/review [milestone_name]` - Comprehensive milestone review and validation against success criteria

#### Session Management System
- `/session/start [session_name]` - Create new development session with timestamp, goals, and progress tracking
- `/session/end` - Complete current session with summary and documentation updates
- `/session/update` - Update current session progress and goals
- `/session/current` - Display current active session information
- `/session/list` - List all available sessions with status
- `/session/help` - Session management guidance and best practices

#### Code Review & Quality
- `/uncommitted/review` - Critical analysis of all uncommitted changes with test verification, security checks, and comprehensive feedback

#### Implementation Planning
- `/plan [file1.md file2.md ...]` - Transform input files into detailed IMPLEMENTATION_PLAN.md using architecture-planner agent with multi-perspective analysis

### 🏛️ Template Infrastructure (4)
Structured templates enabling consistent project workflows:

- **Milestone Template** - Comprehensive milestone structure with prerequisites, objectives, deliverables, success criteria, timeline estimation, risk factors, resource allocation, dependencies, technical specifications, testing requirements, and troubleshooting guides
- **Task Template** - Simple task tracking with implementation steps, acceptance criteria, dependencies, and testing scenarios
- **Implementation Log Template** - Technical debt registry, milestone implementation details, lessons learned, and action items with chronological tracking
- **Milestone Manager Template** - Milestone status tracking with phase organization, dependency mapping, and status legend

### ⚙️ Advanced Configuration
- **Permissions Management** - Granular tool permissions for bash commands, web fetching, and MCP servers
- **MCP Integration** - Configured for comprehensive MCP server integration with tool inheritance
- **Script Automation** - Automated milestone structure creation and project setup
- **Memory Optimization** - CLAUDE.md consolidation and optimization tools following Anthropic best practices

## Advanced Workflows

### 🏁 Milestone-Driven Development Lifecycle
Complete project execution using milestone-based approach:

1. **Plan Creation**: `/plan [vision.md requirements.md]` - Transform vision into detailed implementation plan
2. **Milestone Extraction**: `/milestone/create M1` - Extract specific milestones from implementation plan
3. **Execution**: `/milestone/next M1` - Execute milestone lifecycle with automated documentation updates
4. **Review & Validation**: `/milestone/review M1` - Comprehensive milestone review against success criteria
5. **Documentation Sync**: Automatic updates to CLAUDE.md, IMPLEMENTATION_LOG.md, and MILESTONE_MANAGER.md

### 📋 Session-Based Project Tracking
Organized development sessions with comprehensive tracking:

1. **Session Initiation**: `/session/start feature-auth` - Create named session with goals and timestamp
2. **Progress Tracking**: `/session/update` - Regular progress updates and goal adjustments
3. **Current Status**: `/session/current` - View active session information and progress
4. **Session Management**: `/session/list` - Overview of all sessions and their status
5. **Session Completion**: `/session/end` - Complete session with summary and documentation

### 🧠 Memory Optimization Workflows
Systematic CLAUDE.md management and optimization:

1. **Memory Creation**: `/meta/create-memory ./backend` - Create technology-specific CLAUDE.md with pattern detection
2. **Memory Optimization**: `/meta/optimize-memory ./CLAUDE.md` - Optimize existing memory files using best practices
3. **Memory Consolidation**: `/meta/consolidate-memory` - Intelligent deduplication across all CLAUDE.md files
4. **Memory Maintenance**: `/meta/update-memory` - Keep memory files current with project evolution

### 🔍 Documentation Audit Processes
Comprehensive documentation management and quality assurance:

1. **Documentation Audit**: `/docs/audit` - Identify inconsistencies, missing references, and conflicts
2. **Review Integration**: `/uncommitted/review` - Critical analysis before commits with documentation checks
3. **Cross-Reference Validation**: Automatic verification of @-references and documentation links

## Repository Structure

```
.claude/
├── agents/                    # Specialized AI agents
│   ├── architecture-planner.md   # Multi-perspective planning agent
│   ├── debug-solution-engineer.md # Systematic debugging specialist  
│   └── milestone-planner.md       # Milestone orchestration expert
├── commands/                  # Slash command definitions (25+ commands)
│   ├── commit/                   # Git workflow automation
│   │   ├── main.md              # Parent repo commit with submodule support
│   │   ├── changed.md           # Session-based commit automation
│   │   ├── review.md            # Critical commit analysis
│   │   └── submodules.md        # Submodule-specific commit handling
│   ├── docs/                    # Documentation management
│   │   └── audit.md             # Comprehensive documentation audit
│   ├── meta/                    # Memory & command optimization
│   │   ├── optimize-command.md   # Command efficiency optimization
│   │   ├── optimize-memory.md    # CLAUDE.md optimization
│   │   ├── consolidate-memory.md # Multi-file memory consolidation
│   │   ├── create-memory.md      # Technology-aware memory creation
│   │   ├── optimize-agent.md     # Agent definition optimization
│   │   └── update-memory.md      # Memory maintenance automation
│   ├── milestone/               # Milestone-driven development
│   │   ├── create.md            # Milestone extraction from plans
│   │   ├── next.md              # Milestone lifecycle execution
│   │   ├── meta.md              # Milestone manager synchronization
│   │   └── review.md            # Milestone validation and review
│   ├── session/                 # Session management system
│   │   ├── session-start.md      # Session initiation with tracking
│   │   ├── session-end.md        # Session completion and summary
│   │   ├── session-update.md     # Progress tracking and updates
│   │   ├── session-current.md    # Active session status display
│   │   ├── session-list.md       # Session overview and management
│   │   └── session-help.md       # Session system guidance
│   ├── uncommitted/             # Code quality assurance
│   │   └── review.md            # Pre-commit change analysis
│   └── plan.md                  # Implementation plan generation
├── docs/                      # Framework documentation
│   ├── claude-md.md             # CLAUDE.md best practices guide
│   ├── command.md               # Slash command template & documentation
│   └── sub-agent.md             # Comprehensive subagent system guide
├── scripts/                   # Automation utilities
│   └── create-milestone-structure.sh # Milestone directory setup automation
├── sessions/                  # Session tracking storage
├── templates/                 # Reusable workflow templates
│   ├── milestone-template.md     # Comprehensive milestone structure
│   ├── task-template.md          # Simple task tracking template
│   ├── implementation-log-template.md # Technical debt & milestone tracking
│   └── milestone-manager-template.md  # Milestone status management
└── settings.local.json        # Local configuration overrides
```

## Quick Start

### 1. Integration Setup
```bash
# Copy .claude directory to your project
cp -r cc-base/.claude your-project/
cd your-project

# Initialize milestone structure
./.claude/scripts/create-milestone-structure.sh

# Create project-specific CLAUDE.md
# (Use /meta/create-memory command in Claude Code)
```

### 2. Essential Commands
```bash
# Create implementation plan from vision documents
/plan docs/vision.md docs/requirements.md

# Extract and work on milestones
/milestone/create M1
/milestone/next M1

# Session-based development
/session/start auth-feature
/session/update
/session/end

# Memory optimization
/meta/optimize-memory ./CLAUDE.md
/docs/audit
```

### 3. Workflow Integration
- **Planning Phase**: Use `/plan` to transform vision into structured implementation plans
- **Development Phase**: Execute milestones with `/milestone/next` for automated tracking
- **Quality Phase**: Review changes with `/uncommitted/review` before commits
- **Maintenance Phase**: Optimize memory and documentation with `/meta/*` and `/docs/audit`

## Integration Examples

### Enterprise Development Team
```bash
# Team lead creates implementation plan
/plan project-vision.md technical-requirements.md

# Developers work on individual milestones
/milestone/create M1-authentication
/milestone/next M1-authentication

# Continuous integration with quality checks
/uncommitted/review
/commit/main

# Documentation maintenance
/docs/audit
/meta/consolidate-memory
```

### Solo Developer Workflow
```bash
# Start development session
/session/start feature-implementation

# Plan and execute
/plan feature-spec.md
/milestone/create M1
/milestone/next M1

# Quality assurance
/uncommitted/review
/commit/changed

# Session completion
/session/end
```

### Memory Management Workflow
```bash
# Create technology-specific memory
/meta/create-memory ./backend
/meta/create-memory ./frontend

# Optimize and consolidate
/meta/optimize-memory ./CLAUDE.md
/meta/consolidate-memory

# Maintain documentation
/docs/audit
/meta/update-memory
```

## Key Features Comparison

| Feature | Basic Claude Code | cc-base Framework |
|---------|------------------|-------------------|
| **Agents** | Built-in only | 3 specialized + extensible |
| **Commands** | Limited set | 25+ comprehensive commands |
| **Workflows** | Manual | Automated milestone-driven |
| **Memory Management** | Basic | Advanced optimization suite |
| **Session Tracking** | None | Complete session lifecycle |
| **Documentation** | Manual | Automated audit & maintenance |
| **Quality Assurance** | Basic | Comprehensive review system |
| **Templates** | None | 4 structured workflow templates |
| **Automation** | Limited | Script-based setup & maintenance |

## Advanced Use Cases

### 🏢 Enterprise Scale Development
- **Multi-team coordination** with shared milestone structures
- **Standardized documentation** across all projects using memory consolidation
- **Quality gates** with automated review processes before commits
- **Knowledge transfer** through comprehensive session tracking and implementation logs

### 🚀 Rapid Prototyping
- **Fast iteration** with session-based development tracking
- **Quick setup** using automated scripts and template generation
- **Memory optimization** for context-aware development assistance
- **Milestone-based validation** ensuring prototype completeness

### 🔧 Legacy System Modernization
- **Documentation audit** to identify outdated information and inconsistencies
- **Incremental planning** using milestone extraction from modernization plans
- **Technical debt tracking** through implementation log templates
- **Memory consolidation** to unify scattered documentation

### 📚 Educational Projects
- **Learning progression** tracked through milestone completion
- **Best practices** enforcement through specialized agents
- **Documentation habits** developed through audit processes
- **Session-based learning** with progress tracking and reflection

## Contributing

### Adding Custom Commands
1. Create new command files in `.claude/commands/[category]/`
2. Follow the template structure in `docs/command.md`
3. Test thoroughly with various scenarios
4. Update this README with new command documentation

### Extending Agents
1. Use the architecture-planner agent as a template
2. Define specific expertise areas and use cases
3. Include proactive usage triggers in descriptions
4. Test with real-world scenarios

### Template Improvements
1. Analyze current template usage patterns
2. Identify common pain points or missing sections
3. Propose enhancements following existing structure
4. Validate improvements across different project types

## License

MIT License - Feel free to adapt and extend for your organization's needs.

---

*Transform your Claude Code experience with enterprise-ready workflow automation, comprehensive memory management, and systematic project execution.*
