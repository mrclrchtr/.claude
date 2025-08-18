# Context Gathering Commands - Optimized for AI

Essential commands for efficient project context gathering. Prioritizes speed, clarity, and AI-readability.

## Core Commands (Always Available)

```bash
# Git Status - Essential project state
git branch --show-current                    # Current branch
git status --porcelain                       # Changed files (M=modified, A=added, ??=untracked)
git --no-pager log --oneline -5              # Recent commits

# Project Structure
pwd                                           # Working directory  
ls                                            # Directory contents (clean output)
ls *.json *.toml *.yaml 2>/dev/null          # Config files

# File Discovery (use git ls-files for tracked only)
git ls-files '*.py' | wc -l                  # Count tracked Python files
git ls-files '*.md' | head -10               # List tracked markdown files
find . -name "*.py" -type f | wc -l          # All Python files (if needed)
```

## Modern Tools (Preferred - 3-10x Faster)

```bash
# File Discovery - fd/rg respect .gitignore by default
fd -e py . | wc -l                           # Count Python files (fast)
fd -e js -e ts . | wc -l                     # Count JS/TS files
rg . --files --type py | head -10            # List Python files

# Code Analysis  
rg . -e "TODO|FIXME" --type py --count       # Find TODOs
rg . -e "def |class " --type py --count      # Code structure
rg . -e "^import|^from.*import" --type py | head -5  # Dependencies

# Project Structure - eza needs --git-ignore flag
eza . --tree --level=2 --git-ignore | head -15  # Clean tree view (respects .gitignore)
eza -l --sort=modified . | head -5           # Recently modified (shows all files)

# Fallback if modern tools unavailable
ls                                           # Use ls instead of eza
find . -name "*.py" | wc -l                  # Use find instead of fd
grep -r "pattern" . --include="*.py"         # Use grep instead of rg
```

## Efficient Context Patterns

```bash
# Combined Operations (single line, multiple insights)
echo "Python: $(fd -e py . | wc -l), JS: $(fd -e js . | wc -l), MD: $(fd -e md . | wc -l)"
git status --porcelain | wc -l && git branch --show-current

# Git Change Summary  
git --no-pager diff --stat --cached --summary    # Staged changes
git --no-pager diff --stat --summary             # Unstaged changes
git diff --name-only | head -10                  # Changed file list

# Quick Project Type Detection
ls *.json *.toml *.yaml 2>/dev/null | head -3    # Config files indicate project type
which npm python cargo 2>/dev/null               # Available build tools
```

## Common Use Cases

### 1. Quick Project Overview
```bash
pwd && ls && git branch --show-current
echo "Files: Python=$(fd -e py . | wc -l), JS=$(fd -e js . | wc -l)"  
git status --porcelain | wc -l
```

### 2. Pre-Commit Context
```bash
git status --porcelain                       # What changed
git --no-pager diff --stat --cached          # What's staged
git --no-pager log --oneline -3              # Recent history
```

### 3. Code Analysis
```bash
rg . -e "TODO|FIXME" --type py --count       # Outstanding work
rg . -e "def |class " --type py | head -10   # Code structure  
rg . -e "^import" --type py | head -5         # Dependencies
```

## Special Discovery Commands

```bash
# CLAUDE.md files (AI instructions)
find . -name "CLAUDE.md" -not -path "./.idea/*" -not -path "./.claude/*"

# All documentation (excluding tool/IDE dirs and CLAUDE.md)
git ls-files --cached --others --exclude-standard '*.md' | grep -v -E '(\.idea|\.claude|bruno|\.yarn|CLAUDE\.md)'

# Clean project structure (excludes common tool directories)
eza . --tree --all --git-ignore --ignore-glob=".idea|.claude|bruno|.yarn|node_modules"

# Claude commands/agents discovery
find .claude/commands -name "*.md" -type f 2>/dev/null
find .claude/agents -name "*.md" -type f 2>/dev/null
find .claude/docs -name "*.md" -type f 2>/dev/null
```

## Slash Command Integration

```markdown
# In .claude/commands/*.md files:
## Context
- Branch: !`git branch --show-current`  
- Changed: !`git status --porcelain | wc -l`
- Structure: !`eza . --tree --level=2 --git-ignore | head -10`
- Files: !`echo "py=$(fd -e py . | wc -l) js=$(fd -e js . | wc -l)"`
- CLAUDE.md: !`find . -name "CLAUDE.md" -not -path "./.idea/*" -not -path "./.claude/*"`
- Docs: !`git ls-files '*.md' | grep -v -E '(\.idea|\.claude|CLAUDE\.md)' | wc -l`
```

## Best Practices

### Key Principles
1. **Always limit output**: Use `head -n`, `wc -l`, or `--count`
2. **Prefer machine-readable**: `git status --porcelain` over `git status`
3. **Use modern tools when available**: fd/rg/eza are 3-10x faster
4. **Combine commands**: Single line with multiple insights
5. **Respect .gitignore**: Use `git ls-files` or tools that respect .gitignore

### Tool Selection Guide

| Need        | Best Tool                | Fallback                        |
|-------------|--------------------------|---------------------------------|
| List files  | `ls` or `eza .`          | `ls -la`                        |
| Find files  | `fd -e ext .`            | `find . -name "*.ext"`          |
| Search code | `rg . -e "pattern"`      | `grep -r "pattern" .`           |
| Count files | `fd -e py . \| wc -l`    | `find . -name "*.py" \| wc -l`  |
| Tree view   | `eza . --tree --level=2` | `tree -L 2` or `find . -type d` |

### Performance Tips
- fd/rg respect .gitignore by default, eza requires `--git-ignore` flag
- Use `git ls-files` for tracked files only (fastest for git repos)
- Combine operations: `echo "py=$(fd -e py .) js=$(fd -e js .)"`
- Always specify `.` for current directory with modern tools

---

## Quick Reference

**Remember**: Modern tools (fd/rg/eza) are 3-10x faster and respect (mostly) .gitignore by default.
Always limit output, prefer machine-readable formats, and combine commands for efficiency.
