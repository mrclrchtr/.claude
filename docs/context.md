# Context Gathering Commands - Ultimate AI Reference

Essential commands for efficient project context gathering. Optimized for AI agents and slash commands.

## Quick Reference Matrix

| Need           | Fast (Modern)                                       | Fallback                            | Output      |
|----------------|-----------------------------------------------------|-------------------------------------|-------------|
| Current branch | `git branch --show-current`                         | -                                   | `main`      |
| Changed files  | `git status --porcelain`                            | -                                   | `M file.py` |
| Staged changes | `git --no-pager diff --stat --cached`               | -                                   | statistics  |
| Unstaged diff  | `git --no-pager diff --stat`                        | -                                   | statistics  |
| Full diff      | `git --no-pager diff --color=never`                 | -                                   | detailed    |
| Count Python   | `fd -e py . \| wc -l`                               | `find . -name "*.py" \| wc -l`      | `42`        |
| Find TODOs     | `rg . -e "TODO" --type py --count`                  | `grep -r "TODO" . --include="*.py"` | `5`         |
| Tree view      | `eza . --tree --level=2 --git-ignore`               | `ls -R`                             | structured  |
| Recent files   | `eza -l --sort=modified . \| head -5`               | `ls -lt \| head -5`                 | list        |
| CLAUDE.md      | `find . -name "CLAUDE.md" -not -path "./.claude/*"` | -                                   | paths       |
| All docs       | `git ls-files '*.md' \| grep -v CLAUDE`             | `find . -name "*.md"`               | count       |
| Commands       | `find .claude/commands -name "*.md"`                | -                                   | list        |

## Core Commands (Always Available)

```bash
# Git Essentials - Always use --no-pager
git branch --show-current                    # Current branch
git status --porcelain                       # Changed files (machine-readable)
git --no-pager log --oneline -5              # Recent commits

# Change Statistics
git --no-pager diff --stat --cached --summary    # Staged changes summary
git --no-pager diff --stat --summary             # Unstaged changes summary
git diff --name-only | head -10                  # Changed file list

# Full Diffs (use sparingly - large output)
git --no-pager diff --cached --color=never --unified=5  # Full staged diff
git --no-pager diff --color=never --unified=5           # Full unstaged diff

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
fd -e py . | wc -l                           # Count Python files
fd -e js -e ts . | wc -l                     # Count JS/TS files
fd . --type d | head -10                     # Find directories

# Code Analysis  
rg . -e "TODO|FIXME" --type py --count       # Find TODOs
rg . -e "def |class " --type py --count      # Code structure
rg . -e "^import|^from.*import" --type py | head -5  # Dependencies
rg . -e "pattern" -A 2 -B 1 --type py        # With context lines
rg . -e "pattern" --files-with-matches       # Only show filenames

# Project Structure
eza . --tree --level=2 --git-ignore | head -15  # Clean tree view
eza -l --sort=modified . | head -5           # Recently modified
```

## Context Patterns for AI

### Quick Project Scan
```bash
# One-liner project overview
echo "Branch: $(git branch --show-current), Changes: $(git status --porcelain | wc -l), Python: $(fd -e py . | wc -l), JS: $(fd -e js . | wc -l)"
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
find . -name "CLAUDE.md" -not -path "./.idea/*" -not -path "./.claude/*"

# All documentation (excludes tool/IDE dirs and CLAUDE.md)
git ls-files --cached --others --exclude-standard '*.md' | grep -v -E '(\.idea|\.claude|bruno|\.yarn|CLAUDE\.md)'

# Clean project structure (excludes common tool directories)
eza . --tree --all --git-ignore --ignore-glob=".idea|.claude|bruno|.yarn|node_modules"

# Claude command/agent discovery
find .claude/commands -name "*.md" -type f 2>/dev/null    # Custom commands
find .claude/agents -name "*.md" -type f 2>/dev/null      # AI agents
find .claude/docs -name "*.md" -type f 2>/dev/null        # Documentation
find .claude/templates -name "*.md" -type f 2>/dev/null   # Templates

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

## Full Changes (use sparingly - large output)
- Ready to commit: !`git --no-pager diff --cached --color=never --unified=5`
- Not yet staged: !`git --no-pager diff --color=never --unified=5`

## Project Context
- Structure: !`eza . --tree --all --git-ignore --ignore-glob=".idea|.claude|bruno|.yarn|node_modules" | head -15`
- Files: !`echo "py=$(fd -e py . | wc -l) js=$(fd -e js . | wc -l) md=$(fd -e md . | wc -l)"`
- TODOs: !`rg . -e "TODO|FIXME" --type py --count`

## Discovery
- CLAUDE.md: !`find . -name "CLAUDE.md" -not -path "./.idea/*" -not -path "./.claude/*"`
- All Docs: !`git ls-files --cached --others --exclude-standard '*.md' | grep -v -E '(\.idea|\.claude|bruno|\.yarn|CLAUDE\.md)' | wc -l`
- Commands: !`find .claude/commands -name "*.md" -type f 2>/dev/null | wc -l`
- Agents: !`find .claude/agents -name "*.md" -type f 2>/dev/null | wc -l`
```

## Performance Rules

1. **Always limit output**: `head -n`, `wc -l`, `--count`
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

### Dynamic Filtering (when available)
```bash
fd -e py . | fzf --filter="test" | head -5   # Filter test files
```

---
**Key**: This file optimized for Claude Code AI agents. Modern tools preferred but fallbacks always provided.
