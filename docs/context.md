# Context Gathering Commands - Ultimate AI Reference

Essential commands for efficient project context gathering. Optimized for AI agents and slash commands.

## Core Principles

1. **Speed & Efficiency**: Always use modern tools (fd, rg, eza) for 3-10x faster execution
2. **Follow Symlinks**: All commands use symlink-following flags (-L, --follow, --follow-symlinks)
3. **Right-Sized Commands**: Use commands that match expected output size - avoid artificial limits that can confuse AI
4. **Pre-Assessment First**: Check scope before full execution for potentially large outputs (diffs, trees, finds, lists)
5. **Filter Before Limit**: Use filters/excludes/ignore-globs first; depth limits (--level, --max-depth) only as last resort
6. **Machine-Readable**: Prefer `--porcelain` and structured formats over human-readable output
7. **Respect .gitignore**: Use git-aware tools or git ls-files to honor project ignore patterns
8. **Single Operations**: Avoid complex pipelines in slash commands - use simple, atomic operations
9. **Fallback Strategy**: Always provide standard tool alternatives when modern tools unavailable
10. **Context-Aware**: Commands optimized for AI agents gathering project understanding

## Context Selection Strategy

When adding context to any agent or command, ALWAYS perform this analysis first:

### Three Essential Questions (Ask in Order)
1. **What context directly enables success?** Include only information that the agent/command cannot function without
2. **What context improves quality?** Add context that significantly enhances output quality or efficiency  
3. **What context is noise?** Identify and remove any context that consumes tokens without providing value

### Implementation Steps
1. **Define core task** - What must this agent/command accomplish?
2. **Identify minimum viable context** - What's the absolute minimum needed for basic functionality?
3. **Add value-driven context** - Include only context with clear benefit-to-token ratio > 1
4. **Remove redundant knowledge** - Exclude what AI models already know (basic syntax, common patterns, politeness)
5. **Validate through testing** - Start minimal, add context only when errors or quality issues occur

## Quick Reference Matrix

| Need           | Fast (Modern)                                           | Fallback                            | Output      |
|----------------|---------------------------------------------------------|-------------------------------------|-------------|
| Current branch | `git branch --show-current`                             | -                                   | `main`      |
| Changed files  | `git status --porcelain`                                | -                                   | `M file.py` |
| Staged changes | `git --no-pager diff --stat --cached`                   | -                                   | statistics  |
| Unstaged diff  | `git --no-pager diff --stat`                            | -                                   | statistics  |
| Full diff      | `git --no-pager diff --color=never`                     | -                                   | detailed    |
| Count Python   | `fd --follow -e py . \| wc -l`                          | `find -L . -name "*.py" \| wc -l`   | `42`        |
| Find TODOs     | `rg . -e "TODO" --type py --count`                      | `grep -r "TODO" . --include="*.py"` | `5`         |
| Tree view      | `eza . --tree --level=2 --git-ignore --follow-symlinks` | `ls -LR`                            | structured  |
| Recent files   | `eza -l --sort=modified . --follow-symlinks \| head -5` | `ls -Llt \| head -5`                | list        |
| CLAUDE.md      | `find -L . -name "CLAUDE.md" -not -path "./.claude/*"`  | -                                   | paths       |
| All docs       | `git ls-files '*.md' \| grep -v CLAUDE`                 | `find -L . -name "*.md"`            | count       |
| Commands       | `find -L .claude/commands -name "*.md"`                 | -                                   | list        |

## Core Commands (Always Available)

```bash
# Git Essentials - Always use --no-pager
git branch --show-current                    # Current branch
git status --porcelain                       # Changed files (machine-readable)
git --no-pager log --oneline -5              # Recent commits

# Change Statistics
git --no-pager diff --stat --cached --summary    # Staged changes summary
git --no-pager diff --stat --summary             # Unstaged changes summary
git diff --name-only                       # Changed file list

# Full Diffs (ALWAYS pre-check with --stat first)
git --no-pager diff --cached --color=never --unified=5  # Full staged diff (check scope first)
git --no-pager diff --color=never --unified=5           # Full unstaged diff (check scope first)

# Submodules (if applicable)
git --no-pager diff --submodule=log          # Submodule changes
git submodule status --recursive              # Submodule state

# Project Structure
pwd                                           # Working directory  
ls *.json *.toml *.yaml 2>/dev/null          # Config files
which npm python cargo 2>/dev/null           # Available tools
```

## Modern Tools (3-10x Faster)

```bash
# File Discovery - respects .gitignore by default
fd --follow -e py . | wc -l                           # Count Python files
fd --follow -e js -e ts . | wc -l                     # Count JS/TS files
fd --follow . --type d                       # Find directories (check count first)

# Code Analysis  
rg . -e "TODO|FIXME" --type py --count       # Find TODOs
rg . -e "def |class " --type py --count      # Code structure
rg . -e "^import|^from.*import" --type py    # Dependencies (adapt based on project size)
rg . -e "pattern" -A 2 -B 1 --type py        # With context lines
rg . -e "pattern" --files-with-matches       # Only show filenames

# Project Structure
eza . --tree --level=2 --git-ignore --follow-symlinks  # Clean tree view (ALWAYS pre-check size and adapt)
eza -l --sort=modified . --follow-symlinks | head -5           # Recently modified
```

## Context Patterns for AI

### Quick Project Scan
```bash
# One-liner project overview
echo "Branch: $(git branch --show-current), Changes: $(git status --porcelain | wc -l), Python: $(fd --follow -e py . | wc -l), JS: $(fd --follow -e js . | wc -l)"
```

### Pre-Commit Context
```bash
git status --porcelain                       # What changed
git --no-pager diff --stat --cached          # What's staged
git --no-pager log --oneline -3              # Recent history
```

### Code Quality Check
```bash
rg . -e "TODO|FIXME" --type py --count       # Outstanding work
rg . -e "def test" --type py --count         # Test coverage indicator
ps aux | grep -v grep | grep python | wc -l  # Running processes
date +%s                                      # Timestamp for benchmarking
```

## Special Discovery Commands

```bash
# CLAUDE.md files (AI context instructions)
find -L . -name "CLAUDE.md" -not -path "./.idea/*" -not -path "./.claude/*"

# All documentation (excludes tool/IDE dirs and CLAUDE.md) - check count first
git ls-files --cached --others --exclude-standard '*.md' | grep -v -E '(\.idea|\.claude|bruno|\.yarn|CLAUDE\.md)'

# Clean project structure (excludes common tool directories)
eza . --tree --all --git-ignore --follow-symlinks --ignore-glob=".idea|.claude|bruno|.yarn|node_modules"

# Claude command/agent discovery
find -L .claude/commands -name "*.md" -type f 2>/dev/null    # Custom commands
find -L .claude/agents -name "*.md" -type f 2>/dev/null      # AI agents
find -L .claude/docs -name "*.md" -type f 2>/dev/null        # Documentation
find -L .claude/templates -name "*.md" -type f 2>/dev/null   # Templates

# Agent listing with descriptions
find -L .claude/agents -name "*.md" -exec grep -H "^description:" {} \; 2>/dev/null

# Dependency check
ls package.json pyproject.toml Cargo.toml 2>/dev/null | wc -l
npm list --depth=0 2>/dev/null | head -3     # Node deps
```

## Slash Command Integration

```markdown
## Repository Status
- Branch: !`git branch --show-current`
- File status: !`git status --porcelain`

## Recent History
- Last 5 commits: !`git --no-pager log --oneline -5`

## Change Statistics  
- Ready to commit: !`git --no-pager diff --stat --cached`
- Not yet staged: !`git --no-pager diff --stat`

## Full Changes (ALWAYS pre-check with --stat first)
- Ready to commit: !`git --no-pager diff --cached --color=never --unified=5`
- Not yet staged: !`git --no-pager diff --color=never --unified=5`

## Project Context
- Structure: !`eza . --tree --all --git-ignore --follow-symlinks --ignore-glob=".idea|.claude|bruno|.yarn|node_modules"`
- Files: !`echo "py=$(fd --follow -e py . | wc -l) js=$(fd --follow -e js . | wc -l) md=$(fd --follow -e md . | wc -l)"`
- TODOs: !`rg . -e "TODO|FIXME" --type py --count`

## Discovery
- CLAUDE.md: !`find -L . -name "CLAUDE.md" -not -path "./.idea/*" -not -path "./.claude/*"`
- All Docs: !`git ls-files --cached --others --exclude-standard '*.md' | grep -v -E '(\.idea|\.claude|bruno|\.yarn|CLAUDE\.md)' | wc -l`
- Commands: !`find -L .claude/commands -name "*.md" -type f 2>/dev/null | wc -l`
- Agents: !`find -L .claude/agents -name "*.md" -exec grep -H "^description:" {} \; 2>/dev/null`
```

## Performance Rules

1. **Right-sized commands**: Use appropriate commands for expected output - avoid artificial limits
2. **Machine-readable**: `--porcelain` over human formats
3. **Modern tools first**: fd/rg/eza (3-10x faster)
4. **Combine operations**: Single line, multiple insights
5. **Respect .gitignore**: Use git ls-files or modern tools

## Advanced Patterns

### Submodule-aware
```bash
git submodule foreach --recursive --quiet 'git status --porcelain 2>/dev/null | grep -q . && echo "UNCOMMITTED: $displaypath"'
```

### Security Check
```bash
git diff --cached | grep -iE "(api_key|password|secret)" && echo "⚠️ SECRETS" || echo "✓"
```

### Process Monitoring
```bash
ps aux | grep -v grep | grep -E "python|node" | wc -l
ps -o rss= -p $$ | awk '{print $1/1024 " MB"}'  # Memory usage
```

### Bash Command Permissions
```bash
# Avoid multi-operation commands in slash commands - use single operations
wc -lw file.md                    # ✓ Simple word/line count  
wc -lw file.md | awk '{...}'       # ✗ Requires approval - multiple operations
```

### Adaptive Command Patterns

Commands requiring pre-assessment and size-based adaptation. **Always check scope first, filter before limiting depth.**

```bash
# Git Diffs - Pre-check: git diff --stat | wc -l
# <20 files: full diff | 20-100: stat + selective | 100+: summary only
git --no-pager diff --stat --summary    # Always start here
git --no-pager diff --color=never --unified=5  # Full (small changes only)

# Directory Discovery - Pre-check: fd --follow . --type d | wc -l  
# <50: all dirs | 50-200: basic excludes | 200+: extensive excludes + depth if needed
fd --follow . --type d --exclude="node_modules" --exclude="build" --exclude="dist"

# Dependencies - Pre-check: rg . -e "^import" --type py | wc -l
# <50: all imports | 50-200: externals only | 200+: count + key frameworks
rg . -e "^from [^.]*import" --type py    # External only
rg . -e "^from (numpy|pandas|requests)" --type py  # Key frameworks

# File Discovery - Pre-check: find -L . -name "*.ext" | wc -l
# <100: all files | 100-500: basic excludes | 500+: extensive + focus/depth
find -L . -name "*.md" -not -path "*/node_modules/*" -not -path "*/dist/*"

# Tree Views - Pre-check: fd --follow . | wc -l
# <100: all | 100-1000: basic filters | 1000+: extensive filters | 5000+: max filters
eza . --tree --all --git-ignore --follow-symlinks --ignore-glob="node_modules|dist|build|*.log|__pycache__"
# Add --level=N only if filtering insufficient
```

### Dynamic Filtering (when available)
```bash
fd --follow -e py . | fzf --filter="test"     # Filter test files
```

---
**Key**: This file optimized for Claude Code AI agents. Modern tools preferred but fallbacks always provided.
