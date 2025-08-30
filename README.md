# .claude

A Claude Code customization framework for milestone-driven project management, memory optimization, session tracking, and specialized AI agents.

## 🚀 Quick Start

### One-Line Install
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/mrclrchtr/.claude/main/install.sh)
```

### Alternative Install Methods

Download and run locally:
```bash
wget https://raw.githubusercontent.com/mrclrchtr/.claude/main/install.sh
bash install.sh
```

View all installation options:
```bash
bash install.sh --help
```

> **Note**: The installer automatically detects SSH access to GitHub and uses it for cloning. Falls back to HTTPS if SSH is not available.

### Installation Options

1. **Submodule** (recommended for git projects) - Git-tracked, updatable framework
2. **Direct Clone** - Full git repo in `.claude/` with updates
3. **Copy** - Standalone integration, manual updates required

### Initialize Project Memory
```bash
/meta:create-memory .
```

## 🎯 Core Components

### 🤖 Specialized AI Agents (3)

Specialized AI agents with proactive activation:

#### 📐 Architecture Planner
- **Model**: Inherits from main thread
- **Tools**: Read, Glob, Grep, Write, TodoWrite, LS
- **Expertise**: 4-lens analysis (Technical, Security, Performance, Operations)
- **Output**: IMPLEMENTATION_PLAN.md with actionable milestones
- **Activation**: PROACTIVE when transforming vision documents or feature requests

#### 🔧 Debug Solution Engineer  
- **Model**: Inherits from main thread
- **Tools**: Read, Edit, MultiEdit, Bash, Grep, Glob, LS, TodoWrite, WebSearch, WebFetch
- **Expertise**: Root cause analysis, ranked solutions, prevention strategies
- **Focus**: Errors, test failures, async issues, memory leaks, race conditions
- **Activation**: PROACTIVE on any runtime issues or unexpected behavior

#### 🗺️ Milestone Planner
- **Model**: Inherits from main thread
- **Tools**: Read, Glob, Grep, Write, TodoWrite, LS, Bash
- **Expertise**: Executable milestones with dependencies and timelines
- **Output**: MILESTONES.md with verification commands and parallel task notation
- **Activation**: PROACTIVE when converting IMPLEMENTATION_PLAN.md to milestones

### 📋 Command Library (24 Commands)

#### Commit Management (4)
- `/commit:main` - Parent repo commits with submodule updates
- `/commit:changed` - Smart staging with conventional messages  
- `/commit:review [hash]` - Critical analysis with risk assessment
- `/commit:submodules` - Isolated submodule commits

#### Memory & Meta Management (6)
- `/meta:optimize-memory [path]` - CLAUDE.md optimization
- `/meta:consolidate-memory [focus]` - Multi-file deduplication
- `/meta:create-memory [dir]` - Technology detection for new CLAUDE.md
- `/meta:optimize-command [path]` - Command efficiency optimization
- `/meta:optimize-agent [path]` - Agent definition refinement
- `/meta:update-memory` - Refresh existing CLAUDE.md patterns

#### Milestone Management (4)
- `/milestone:create [id]` - Extract milestone from IMPLEMENTATION_PLAN.md
- `/milestone:next [name]` - Complete lifecycle execution
- `/milestone:meta` - Synchronize MILESTONE_MANAGER.md
- `/milestone:review [name]` - Validate against success criteria

#### Session Management (7)
- `/session:start [name]` - Initialize development session
- `/session:end` - Complete with summary and updates
- `/session:update` - Track progress and adjust goals
- `/session:current` - Display active session status
- `/session:list` - Overview of all sessions
- `/session:load [name]` - Load and resume previous session
- `/session:help` - Session management guide

#### Quality & Planning (3)
- `/uncommitted:review` - Pre-commit analysis with security checks
- `/plan [files...]` - Transform vision into IMPLEMENTATION_PLAN.md
- `/docs:audit` - Comprehensive markdown audit

### 📐 Template Infrastructure (4)

**Milestone Template**: Parallel/Sequential tasks, dependencies, timelines, risk matrices  
**Task Template**: Implementation steps, acceptance criteria, testing scenarios  
**Implementation Log**: Technical tracking with debt registry and lessons learned  
**Milestone Manager**: Status orchestration with dependency visualization

## 🔄 Core Workflows

### Milestone-Driven Development

```bash
# Transform vision → Extract milestones → Execute → Review
/plan vision.md requirements.md
/milestone:create M1-authentication  
/milestone:next M1-authentication
/milestone:review M1-authentication
```

### Session-Based Development

```bash
# Start → Track → Complete
/session:start feature-payment-integration
/session:update  # Track progress, adjust goals
/session:end     # Generate summary, archive
```

### Memory Optimization

```bash
# Create → Optimize → Consolidate
/meta:create-memory ./backend    # Detect tech stack, extract patterns
/meta:optimize-memory ./CLAUDE.md  # Remove redundancy, update commands
/meta:consolidate-memory backend    # Deduplicate, create cross-references
```


### Framework Updates

#### Submodule Method
```bash
# Update submodule to latest version
git submodule update --remote .claude
```

#### Direct Clone Method
```bash
# Update direct clone to latest version
cd .claude && git pull
```


## 🎨 Key Features & Benefits

| Feature           | Standard Claude Code | .claude Framework               |
|-------------------|----------------------|---------------------------------|
| **AI Agents**     | Built-in generic     | 3 specialized with proactivity  |
| **Commands**      | ~10 basic            | 24 with advanced workflows      |
| **Memory Mgmt**   | Manual CLAUDE.md     | 6 optimization commands         |
| **Planning**      | Ad-hoc               | Structured milestone system     |
| **Session Track** | None                 | Complete lifecycle management   |
| **Quality Gates** | Basic                | Comprehensive review pipeline   |

## 🏗️ Use Cases

- **Team Development**: Shared milestone structures and standardized workflows
- **MVP Development**: Session-based sprints with milestone tracking
- **Legacy Projects**: Documentation audits and technical debt tracking
- **Open Source**: Standardized contribution workflows

## 🔧 Customization & Extension

### Extending Templates
- Analyze usage patterns with `/docs:audit`
- Identify missing sections or workflows
- Propose enhancements following existing structure
- Validate across different project types

## 📄 License

MIT License - Adapt freely for your organization's needs.
