# .claude

A Claude Code customization framework for milestone-driven project management, memory optimization, session tracking, and specialized AI agents.

> **Note**: This framework defaults to project-specific customizations. A global installation option is available that installs to `~/.claude` with sparse checkout protection.

## 🚀 Quick Start

```bash
# Quick install (auto-detects git repo and shows appropriate options)
curl -fsSL https://raw.githubusercontent.com/mrclrchtr/.claude/main/install.sh | bash

# Or download and run locally
wget https://raw.githubusercontent.com/mrclrchtr/.claude/main/install.sh
bash install.sh
```

### Installation Options

**For Git Repositories:**
- **Submodule** (recommended): Keeps framework updatable via git
- **Copy**: Integrates framework directly into your project
- **Global**: Installs to `~/.claude` with git tracking (affects ALL projects)

**For Non-Git Directories:**
- **Clone**: Clones framework directly into `.claude/` directory with full git tracking
- **Copy**: Creates `.claude/` directory with framework files only (no git)
- **Global**: Installs to `~/.claude` with git tracking (affects ALL projects)

```bash
# After installation, start Claude Code and create project memory
/meta:create-memory .
```

## 🎯 Core Components

### 🤖 Specialized AI Agents (3)

Powerful AI specialists with multi-perspective analysis, proactive activation, and humanized personalities:

#### 📐 Architecture Planner
- **Model**: Inherits from main thread
- **Tools**: Read, Glob, Grep, Write, TodoWrite, LS
- **Expertise**: Architecture planning with 4-lens analysis (Technical, Security, Performance, Operations)
- **Workflow**: Context scan → Clarification → 4-perspective decomposition → IMPLEMENTATION_PLAN.md
- **Activation**: PROACTIVE when transforming vision documents or feature requests

#### 🔧 Debug Solution Engineer  
- **Model**: Opus (premium model for complex debugging)
- **Tools**: Read, Edit, MultiEdit, Bash, Grep, Glob, LS, TodoWrite, WebSearch, WebFetch
- **Expertise**: Root cause analysis, ranked solutions, prevention strategies
- **Focus**: Stack traces, async issues, type mismatches, memory leaks, race conditions
- **Activation**: PROACTIVE on errors, test failures, build errors, performance issues

#### 🗺️ Milestone Planner
- **Model**: Inherits from main thread
- **Tools**: Read, Glob, Grep, Write, TodoWrite, LS, Bash
- **Expertise**: Milestone decomposition with dependency mapping and timeline calculation
- **Output**: Executable milestones with verification commands and parallel task notation
- **Activation**: PROACTIVE when converting IMPLEMENTATION_PLAN.md to milestones

### 📋 Command Library (25+ Commands)

#### Commit Management (4)
- **`/commit:main`** - Intelligent parent repo commits with submodule pointer updates
- **`/commit:changed`** - Session-based staging with conventional commit message generation
- **`/commit:review [hash]`** - Critical analysis with size classification and risk assessment
- **`/commit:submodules`** - Isolated submodule commits separate from parent

#### Documentation Management (1)
- **`/docs:audit`** - Comprehensive markdown audit for inconsistencies and missing references

#### Memory & Meta Management (6)
- **`/meta:optimize-memory [path]`** - CLAUDE.md optimization using Anthropic best practices
- **`/meta:consolidate-memory [focus]`** - Multi-file deduplication with intelligent merging
- **`/meta:create-memory [dir]`** - Technology detection and pattern extraction for new CLAUDE.md
- **`/meta:optimize-command [path]`** - Command efficiency optimization preserving robustness
- **`/meta:optimize-agent [path]`** - Agent definition refinement for effectiveness
- **`/meta:update-memory`** - Refresh existing CLAUDE.md with latest patterns

#### Milestone Management (4)
- **`/milestone:create [id]`** - Extract specific milestone from IMPLEMENTATION_PLAN.md
- **`/milestone:next [name]`** - Complete lifecycle: select → analyze → implement → complete
- **`/milestone:meta`** - Synchronize MILESTONE_MANAGER.md with sequential numbering
- **`/milestone:review [name]`** - Validate against success criteria and deliverables

#### Session Management (6)
- **`/session:start [name]`** - Initialize timestamped development session with goals
- **`/session:end`** - Complete session with summary and documentation updates
- **`/session:update`** - Track progress and adjust goals mid-session
- **`/session:current`** - Display active session status and progress
- **`/session:list`** - Overview of all sessions with status indicators
- **`/session:help`** - Session management best practices guide

#### Quality Assurance (1)
- **`/uncommitted:review`** - Pre-commit analysis with test execution and security checks

#### Planning (1)
- **`/plan [files...]`** - Transform vision/requirements into structured IMPLEMENTATION_PLAN.md

### 📐 Template Infrastructure (4)

#### Milestone Template
Comprehensive structure with:
- Parallel/Sequential task notation `[P/S/B]`
- Weight class classification (lightweight/medium/heavy)
- Dependency mapping and resource allocation
- Risk matrix with mitigation strategies
- Timeline calculation with integration multipliers
- Testing requirements across 5 categories
- Troubleshooting guides with fallback strategies

#### Task Template
Simple tracking with:
- Implementation steps
- Acceptance criteria
- Dependencies
- Testing scenarios

#### Implementation Log Template
Technical tracking with:
- Chronological timeline
- Technical debt registry (High/Medium/Low)
- Milestone implementation details
- Lessons learned
- Action items

#### Milestone Manager Template
Status orchestration with:
- Phase organization
- Dependency visualization
- Status legend
- Progress tracking

### ⚙️ Advanced Configuration

#### Permission Management
```json
{
  "permissions": {
    "allow": [
      "WebFetch(domain:www.anthropic.com)",
      "mcp__github__get_file_contents",
      "Bash(mkdir:*)"
    ],
    "deny": [],
    "ask": []
  }
}
```

#### Installation Methods
- **Git Submodule**: Maintains separation, git-tracked updates, recommended for git repos
- **Framework Copy**: Full integration into project, manual updates required
- **Direct Clone**: Clones framework directly into `.claude/` directory, git-tracked updates
- **Global Git**: Installs to `~/.claude` with sparse checkout, affects all Claude Code sessions

### Important: Framework vs Claude Code Directories

| Directory   | Purpose                                              | Managed By                      |
|-------------|------------------------------------------------------|---------------------------------|
| `~/.claude` | Claude Code global configuration, settings, projects | Claude Code (or Global Install) |
| `.claude/`  | Project-specific customization framework             | This framework                  |

> ⚠️ **Global Installation Note**: The Global Git installation method makes `~/.claude` a git repository with sparse checkout to track only framework files. Claude Code's own files are protected by `.gitignore`. For project-specific installs, `~/.claude` remains untouched.

## 🔄 Core Workflows

### Milestone-Driven Development

```bash
# 1. Transform vision into plan
/plan vision.md requirements.md tech-spec.md

# 2. Extract executable milestones
/milestone:create M1-authentication
/milestone:create M2-api-integration

# 3. Execute with automatic tracking
/milestone:next M1-authentication
# → Analyzes deliverables
# → Implements with progress tracking
# → Updates CLAUDE.md, IMPLEMENTATION_LOG.md
# → Marks completion in MILESTONE_MANAGER.md

# 4. Review and validate
/milestone:review M1-authentication
/uncommitted:review
```

### Session-Based Development

```bash
# Start focused work session
/session:start feature-payment-integration

# Track progress during development
/session:update
# → Updates goals
# → Records blockers
# → Adjusts timeline

# Complete with documentation
/session:end
# → Generates summary
# → Updates logs
# → Archives session
```

### Memory Optimization Pipeline

```bash
# Create technology-specific memory
/meta:create-memory ./backend
# → Detects: Node.js, Express, PostgreSQL
# → Extracts: Patterns, conventions, workflows

# Optimize existing memory
/meta:optimize-memory ./CLAUDE.md
# → Removes redundancy
# → Updates commands
# → Preserves critical workflows

# Consolidate across project
/meta:consolidate-memory backend
# → Deduplicates across files
# → Creates cross-references
# → Maintains hierarchy
```

### Global Installation Management

```bash
# Update framework globally (affects all projects)
cd ~/.claude && git pull claude-framework main

# Check global framework status
cd ~/.claude && git status

# View framework files (only these are tracked)
cd ~/.claude && ls agents/ commands/ docs/ scripts/ templates/

# Add custom global modifications
cd ~/.claude && git add . && git commit -m "feat: add custom global configuration"
```

## 🎨 Key Features & Benefits

| Feature                | Standard Claude Code | .claude Framework                       |
|------------------------|----------------------|-----------------------------------------|
| **AI Agents**          | Built-in generic     | 3 specialized with proactive activation |
| **Commands**           | ~10 basic            | 25+ with sophisticated workflows        |
| **Memory Mgmt**        | Manual CLAUDE.md     | 6 optimization commands                 |
| **Planning**           | Ad-hoc               | Structured milestone system             |
| **Session Tracking**   | None                 | Complete lifecycle management           |
| **Quality Gates**      | Basic                | Comprehensive review pipeline           |
| **Documentation**      | Manual               | Automated audit & sync                  |
| **Parallel Execution** | Manual coordination  | Built-in orchestration                  |
| **Risk Management**    | None                 | Integrated matrices                     |
| **Technical Debt**     | Untracked            | Registry with priorities                |

## 🏗️ Use Cases

- **Team Development**: Shared milestone structures and standardized workflows
- **MVP Development**: Session-based sprints with milestone tracking
- **Legacy Projects**: Documentation audits and technical debt tracking
- **Open Source**: Standardized contribution workflows

## 🔧 Customization & Extension

### Creating Custom Commands
```markdown
---
description: Your command description
argument-hint: [expected args]
allowed-tools: Bash(git:*), Read
model: claude-sonnet-4-0
---

# Command implementation
```

### Adding Specialized Agents
```markdown
---
name: (emoji) Agent Name
description: MUST BE USED PROACTIVELY when...
tools: Read, Write, specific-tools
model: inherit
---

You are an expert in...
```

### Extending Templates
- Analyze usage patterns with `/docs:audit`
- Identify missing sections or workflows
- Propose enhancements following existing structure
- Validate across different project types

## 🚦 Best Practices

### Memory Management
- Keep CLAUDE.md under 2000 tokens
- Use `/meta:optimize-memory` monthly
- Consolidate when exceeding 3 CLAUDE.md files
- Document patterns, not implementations

### Milestone Planning
- Use weight classes for resource allocation
- Define clear success criteria upfront
- Include troubleshooting guides
- Track technical debt in implementation log

### Session Discipline
- Start sessions for focused work periods
- Update progress at natural breakpoints
- End sessions with clear summaries
- Review session patterns weekly

### Quality Assurance
- Run `/uncommitted:review` before all commits
- Use `/commit:review` for critical changes
- Execute `/docs:audit` weekly
- Maintain test coverage above 80%

## 📊 Usage Guidelines

- Use `/plan` command for structured planning
- Track milestone completion with MILESTONE_MANAGER.md
- Optimize memory usage with `/meta:optimize-memory`
- Leverage Bug Hunter agent for debugging
- Maintain documentation consistency with `/docs:audit`

## 📄 License

MIT License - Adapt freely for your organization's needs.

---

*Enhance Claude Code with structured workflows and project management tools.*
