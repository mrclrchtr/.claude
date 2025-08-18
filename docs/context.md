# Context Gathering Commands Lookup

Quick reference for gathering project context efficiently. Use these commands in bash command execution (`!` prefix) or slash commands.

## Quick Reference Table

| Purpose               | Command                                                                                                                                     | Output Example                 |
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------|
| **Git Status**        | `git --no-pager status --porcelain`                | `M file.py` (machine-readable) |
| **Current Branch**    | `git branch --show-current`                        | `main`                         |
| **Recent Commits**    | `git --no-pager log --oneline -5`                  | `abc1234 commit message`       |
| **Staged Changes**    | `git --no-pager diff --stat --cached --summary`    | Files to be committed          |
| **Unstaged Changes**  | `git --no-pager diff --stat --summary`             | Modified files                 |
| **Changed Files**     | `git diff --name-only`                             | List of file paths             |
| **Tracked Files**     | `git ls-files '*.py' \| wc -l`                     | Count tracked Python files    |
| **Tracked Docs**      | `git ls-files '*.md' \| head -10`                  | List tracked markdown files   |
| **Submodule Status**  | `git --no-pager diff --submodule=log`              | Submodule changes              |
| **Working Directory** | `pwd`                                               | `/current/path`                |
| **Directory Listing** | `ls -la \| head -10`                               | Directory contents (limited)   |
| **Modern Directory**  | `eza .`                                             | Clean directory listing        |
| **Tree View**         | `eza . --tree --git-ignore \| head -15`           | Project structure (clean)     |
| **Fast File Find**    | `fd -e py . \| wc -l`                              | Count Python files (fast)     |
| **Code Search**       | `rg . -e "pattern" --type py`                      | Search in Python files        |
| **File Listing**      | `rg . --files --type py \| head -10`               | List Python files             |
| **Process Count**     | `ps aux \| grep -v grep \| grep python \| wc -l`   | Running processes              |
| **Timestamp**         | `date +%s`                                          | Unix timestamp                 |

## Git Context Gathering

### Essential Git Commands

**CRITICAL**: Always use `--no-pager` to prevent interactive pagers from blocking execution.

```bash
# Core status commands
git --no-pager status --porcelain           # Machine-readable status
git branch --show-current                   # Current branch name
git --no-pager log --oneline -5             # Recent commits (limited)

# Change analysis
git --no-pager diff --stat --cached --summary    # Staged changes summary
git --no-pager diff --stat --summary             # Unstaged changes summary
git diff --name-only                             # List changed files only

# Git-tracked files (excludes node_modules, ignored files)
git ls-files                                     # All tracked files
git ls-files '*.py'                             # Tracked Python files only
git ls-files '*.md' | head -10                  # Tracked markdown files
git ls-files --cached --others --exclude-standard '*.md'  # Include untracked but not ignored

# Submodule management
git --no-pager diff --submodule=log              # Submodule pointer changes
git submodule foreach --recursive --quiet 'git status --porcelain 2>/dev/null | grep -q . && echo "UNCOMMITTED: $displaypath" || true'
```

### Advanced Git Context

```bash
# Detailed analysis (use sparingly)
git --no-pager log --oneline -10 --graph    # Branch history
git --no-pager diff --color=never           # Full diff without colors

# Safety checks
git status --porcelain | wc -l              # Count of changed files
git diff --cached --name-only | wc -l       # Count of staged files
```

## File System Context

### Directory Analysis

```bash
# Basic directory info
pwd                                         # Current directory
ls -la | head -10                          # Directory contents (limited)
find . -name "*.js" -o -name "*.ts" | wc -l # Count specific file types

# File discovery
find . -name "package.json" | head -3      # Find config files
find . -type f -name "*.md" | head -5      # Find documentation

# Size and structure
du -sh . 2>/dev/null | head -1             # Directory size
ls -1 | wc -l                              # Count of items in directory
```

### Targeted File Search

```bash
# Configuration files
ls -la *.json *.yaml *.yml 2>/dev/null     # Config files in root
find . -name ".env*" 2>/dev/null           # Environment files

# Documentation
find . -name "README*" -o -name "*.md" | head -5

# Source code patterns
find . -name "*.py" -path "*/test*" | wc -l     # Test files
find . -name "*.js" ! -path "*/node_modules/*" | wc -l  # JS excluding deps
```

## Process & System Context

### Running Processes

```bash
# Process monitoring
ps aux | grep -v grep | grep python | wc -l    # Python processes
ps aux | grep -v grep | grep node | wc -l      # Node processes
ps -o rss= -p $$                               # Memory of current process

# System info
date +%s                                       # Unix timestamp
uptime | awk '{print $3}' | sed 's/,//'       # System uptime
```

### Environment Context

```bash
# Development environment
which git npm node python | wc -l              # Available tools
env | grep -E "NODE|PYTHON|PATH" | head -5     # Environment variables
uv --version 2>/dev/null || echo "uv not found" # Tool versions
```

## Project Context

### Dependency Analysis

```bash
# Package managers
ls package.json pyproject.toml Cargo.toml Gemfile 2>/dev/null | wc -l
npm list --depth=0 2>/dev/null | head -5      # Node dependencies
pip list | wc -l 2>/dev/null                  # Python packages

# Lock files
ls -la *lock* *.lock 2>/dev/null              # Lock file status
```

### Build & Test Context

```bash
# Build status
npm run build 2>&1 | tail -5                  # Recent build output
make -n 2>/dev/null | head -3                 # Available make targets

# Test status  
npm test 2>&1 | grep -c "failed" || echo 0    # Test failure count
find . -name "*test*" -type f | wc -l         # Test file count
```

## Modern CLI Tools

### Fast Directory Navigation with `eza`

**Note**: `eza` requires `.` to specify current directory.

```bash
# Basic listing (faster and cleaner than ls)
eza .                                         # Simple directory listing
eza -la .                                     # Long format with hidden files
eza --tree . | head -10                       # Tree view (limited)
eza --icons .                                 # With file type icons
eza --git-ignore .                            # Respect .gitignore

# Useful flags
eza -l --sort=modified .                      # Sort by modification time
eza --tree --level=2 .                        # Tree with depth limit
eza -la --group-directories-first .           # Directories first
```

### Fast File Search with `fd`

**Note**: `fd` searches from current directory by default.

```bash
# File search by extension
fd -e py .                                    # Find Python files
fd -e js -e ts .                              # Multiple extensions
fd . --type f --extension py | wc -l         # Count Python files

# Advanced search
fd . --type d | head -10                      # Find directories only
fd . --hidden --no-ignore | head -5          # Include hidden/ignored files
fd "test" . --type f                          # Find files with "test" in name
fd . --size +1m                              # Files larger than 1MB

# Performance comparison
# find . -name "*.py" | wc -l               # Traditional (slower)
# fd -e py . | wc -l                        # Modern (faster)
```

### Code Search with `rg` (ripgrep)

**Note**: `rg` requires `.` to specify search directory and `-e` for pattern.

```bash
# Basic pattern search
rg . -e "pattern" --type py                   # Search in Python files
rg . -e "TODO|FIXME" --type py               # Multiple patterns
rg . -e "import.*pandas" --type py           # Regex patterns

# File operations
rg . --files --type py | head -10             # List Python files
rg . --files --type js | wc -l               # Count JavaScript files
rg . --count -e "def " --type py             # Count function definitions

# Advanced search
rg . -e "pattern" --type py --stats          # Show search statistics
rg . -e "error" -i --type py                 # Case insensitive
rg . -e "pattern" -A 3 -B 1 --type py       # Context lines (after/before)
rg . -e "class.*Test" --type py             # Find test classes

# Performance features
rg . --type py --count | head -5             # Fast file matching counts
rg . -e "pattern" --files-with-matches       # Only show filenames
```

### Interactive Filtering with `fzf`

```bash
# Basic filtering (useful for dynamic selection)
echo "file1\nfile2\ntest" | fzf --filter="test"  # Filter patterns
fd -e py . | fzf --filter="test"                  # Filter Python files

# For context gathering (non-interactive mode)
ls | fzf --filter="py" | head -5                  # Filter file list
git branch | fzf --filter="feature"               # Filter branches
```

### Modern Tools Integration Examples

```bash
# Combined workflows
fd -e py . | rg . -e "TODO" --files-stdin        # Find TODOs in Python files
eza --tree . | head -20 && fd . --type d | wc -l # Structure overview

# Fast project analysis
rg . --type py --count | sort -nr | head -5      # Files with most Python matches
fd -e py . | wc -l && fd -e js . | wc -l         # Multi-language file counts
rg . -e "import|require" --type py --type js --count  # Dependency analysis

# Git integration
git diff --name-only | head -10                  # Get changed files first
git ls-files | rg . -e "test" --files-stdin     # Find test files in git
```

### Context Gathering with Modern Tools

```bash
# Project overview (fast)
eza . && fd . --type d | wc -l && fd -e py . | wc -l

# Code quality check
rg . -e "TODO|FIXME|HACK" --type py --count && rg . -e "def test" --type py --count

# Recent changes analysis
git diff --name-only | head -5 && eza -l --sort=modified . | head -5

# Language distribution
fd -e py . | wc -l && fd -e js . | wc -l && fd -e ts . | wc -l

# Dependencies and imports
rg . -e "^import|^from.*import" --type py | head -10
rg . -e "^require|^import.*from" --type js | head -10
```

## Specialized Context Patterns

### Documentation Discovery

```bash
# Find documentation structure (excludes common build/test directories)
find . -name "*.md" -not -path "./tmp.*/*" -not -path "./node_modules/*" -not -path "./.*cache/*" | head -20
find docs -type f -name "*.md" | sort && ls -la *.md 2>/dev/null

# Command and agent discovery
find .claude/commands -name "*.md" -type f 2>/dev/null | head -20
find .claude/agents -name "*.md" -type f 2>/dev/null

# Configuration files discovery
find . -name "package.json" -o -name "pyproject.toml" -o -name "Cargo.toml" -o -name "pom.xml"
find . -name "*.config.*" -o -name ".env*" | head -10
```

### Milestone and Status Discovery

```bash
# Milestone file patterns
find docs/milestones -name "M[0-9]*-*.md" -o -name "M[0-9]*_[0-9]*-*.md" -type f | sort
find . -name "M[0-9]*-*.md" -o -name "M[0-9]*_[0-9]*-*.md" -type f | head -5

# Git commit analysis for milestones
git --no-pager log --oneline --grep="[Mm]ilestone\|M[0-9]_" -10
git --no-pager diff --stat HEAD~5..HEAD

# Combined status and discovery
git status --porcelain --branch && find . -name "M[0-9]*-*.md" | head -5
```

### TODO and Issue Tracking

```bash
# TODO/FIXME discovery patterns
rg . -e "TODO|FIXME|HACK|XXX" --type py --count
rg . -e "TODO|FIXME" --files-with-matches | head -10
rg . -e "TODO.*:" --type py -A 1 | head -20  # TODOs with context

# Issue patterns in comments
rg . -e "BUG|BROKEN|TEMP" --type py --files-with-matches
rg . -e "/\*.*TODO.*\*/" --type js  # Block comment TODOs
```

### Repository Analysis

```bash
# Key project files discovery
find . -maxdepth 2 -name "README*" -o -name "LICENSE*" -o -name "CHANGELOG*"
find . -name "Dockerfile*" -o -name "docker-compose*" -o -name ".github" -type d

# Build and test configuration
find . -name "Makefile" -o -name "*.mk" -o -name "justfile"
find . -name "*test*" -type d | head -5
find . -name "*.test.*" -o -name "*_test.*" | wc -l
```

### Performance Comparison

| Operation | Traditional | Modern | Speed Improvement |
|-----------|------------|--------|-------------------|
| List files | `ls -la` | `eza .` | ~2x faster, cleaner |
| Find Python files | `find . -name "*.py"` | `fd -e py .` | ~5x faster |
| Search in files | `grep -r "pattern" .` | `rg . -e "pattern"` | ~10x faster |
| Count file types | `find . -name "*.py" \| wc -l` | `fd -e py . \| wc -l` | ~3x faster |

### Modern Tools Best Practices

```bash
# ✅ Use specific directory reference
eza .                                            # Correct
rg . -e "pattern"                               # Correct
fd -e py .                                      # Correct

# ❌ Avoid implicit directory
eza                                             # May fail
rg "pattern"                                    # Less predictable
fd -e py                                        # May search wrong directory

# ✅ Combine for efficiency
rg . --files --type py | head -10               # List then limit
fd -e py . | rg . -e "TODO" --files-stdin      # Chain operations

# ✅ Use appropriate flags
rg . -e "pattern" --type py --count             # Count matches
fd . --type f --extension py                    # Explicit file type
eza --git-ignore .                              # Respect project ignores
```

## Performance Optimization

### Efficient Context Patterns

```bash
# Use counts instead of full output
grep -c "pattern" file                        # Count matches
wc -l < file                                  # Count lines
ls -1 | wc -l                                 # Count directory items

# Limit output size
command | head -10                            # First 10 lines
command | tail -5                             # Last 5 lines
command 2>&1 | grep "ERROR" | head -3         # Filtered output

# Combine operations
git status --porcelain | wc -l && git branch --show-current  # Multiple checks
```

### Context Size Management

```bash
# Compress multi-line into single line
git log --oneline -3 | tr '\n' ' '            # Compact format

# Use exit codes for boolean checks
test -f file && echo "✓" || echo "✗"          # File existence
git diff --quiet && echo "clean" || echo "dirty"  # Git status check

# Aggregate information
find . -name "*.py" | wc -l && find . -name "*.js" | wc -l  # Multiple counts
```

## Context Gathering Best Practices

### 1. Always Limit Output

```bash
# ❌ Avoid unlimited output
git log                                       # Could be thousands of lines
find .                                        # Every file in project

# ✅ Use limits
git log --oneline -10                         # Limited history
find . -name "*.py" | head -20                # Limited file search
```

### 2. Use Machine-Readable Formats

```bash
# ❌ Human-readable (harder to parse)
git status

# ✅ Machine-readable
git status --porcelain                        # Consistent format
ls -1                                         # One item per line
```

### 3. Handle Errors Gracefully

```bash
# ❌ May fail silently
command

# ✅ Handle errors
command 2>/dev/null || echo "command failed"
which tool >/dev/null && echo "available" || echo "missing"
```

### 4. Group Related Commands

```bash
# ✅ Efficient parallel context gathering
- Current state: !`git branch --show-current && git status --porcelain | wc -l`
- Recent changes: !`git log --oneline -3`
- File counts: !`find . -name "*.py" | wc -l && find . -name "*.js" | wc -l`
```

## Common Use Cases

### Pre-Commit Context

```bash
# Essential pre-commit checks
git --no-pager status --porcelain              # What will be committed
git --no-pager diff --stat --cached --summary  # Staged changes
git branch --show-current                      # Current branch
git log --oneline -3                           # Recent commits for context
```

### Debugging Context

```bash
# Error investigation
git --no-pager diff --name-only                # Files that changed
ps aux | grep python | wc -l                  # Running processes  
ls -la *.log 2>/dev/null                      # Log files
tail -5 *.log 2>/dev/null                     # Recent log entries
```

### Project Overview Context

```bash
# New project analysis
pwd && ls -la | head -10                      # Location and structure
find . -name "package.json" -o -name "pyproject.toml" -o -name "Cargo.toml"  # Project type
git branch --show-current && git log --oneline -5  # Git status
```

### Performance Monitoring Context

```bash
# Resource usage
ps -o rss= -p $$ | awk '{print $1/1024 " MB"}'  # Memory usage
date +%s                                        # Timestamp for benchmarking
find . -name "*.py" | wc -l                    # Code volume
```

## Security Considerations

### Safe Context Gathering

```bash
# ❌ Avoid exposing secrets
env                                           # May contain secrets
cat .env                                      # Direct secret exposure

# ✅ Safe patterns
env | grep -E "NODE|PYTHON" | grep -v -E "KEY|TOKEN|SECRET"  # Filtered env
git diff --cached | grep -iE "(api_key|password|secret)" && echo "WARNING" || echo "✓"
```

### File Permission Checks

```bash
# Check for security issues
find . -type f -perm /111 -name "*.md" | wc -l  # Executable docs (suspicious)
ls -la .env* 2>/dev/null                        # Environment file permissions
git status --porcelain | grep -E "^\?\?" | grep -E "\.(key|pem|crt)$"  # Untracked secrets
```

## Integration with Slash Commands

### Traditional Context in Command Files

```markdown
---
description: Example command with traditional context gathering
---

# Command with Context

## Context

- Current branch: !`git branch --show-current`
- Modified files: !`git diff --name-only | wc -l`
- Staged changes: !`git --no-pager diff --stat --cached --summary`
- Working directory: !`pwd`

## Task

Use the gathered context to...
```

### Modern Context in Command Files

```markdown
---
description: Example command with modern tools
---

# Modern Command with Fast Context

## Context

- Project structure: !`eza --tree . | head -15`
- Python files: !`fd -e py . | wc -l`
- TODOs found: !`rg . -e "TODO|FIXME" --type py --count`
- Recent changes: !`eza -l --sort=modified . | head -5`
- Dependencies: !`rg . -e "^import" --type py | head -10`

## Task

Based on the modern tool analysis above...
```

### Real-World Usage Examples from Commands

Based on actual usage in `.claude/commands/meta/optimize-memory.md`:

```markdown
## Context

- Project structure: !`eza . --tree --all --git-ignore --ignore-glob=".idea|.claude|bruno|.yarn"`
- Tracked documentation: !`git ls-files --cached --others --exclude-standard '*.md' | grep -v -E '(\.idea|\.claude|bruno|\.yarn)/'`
```

### Integration Patterns

```markdown
# ✅ Efficient context gathering (modern)
- Overview: !`eza . && fd . --type d | wc -l`
- Code stats: !`fd -e py . | wc -l && rg . -e "def " --type py --count`
- Issues: !`rg . -e "TODO|FIXME|BUG" --type py --files-with-matches | head -5`

# ✅ Git-aware file discovery
- Tracked files: !`git ls-files '*.py' | wc -l`
- Documentation: !`git ls-files '*.md' | head -10`
- Modified tracked: !`git ls-files | xargs -I {} rg . -e "import" -l {} | head -5`

# ✅ Language-specific analysis
- Python: !`git ls-files '*.py' | wc -l && rg . -e "class |def " --type py --count`
- JavaScript: !`git ls-files '*.js' | wc -l && rg . -e "function|const|class" --type js --count`

# ✅ Combined git + modern tools
- Changed files: !`git diff --name-only | head -5`
- Modified recently: !`eza -l --sort=modified . | head -3`
- Git structure: !`eza . --tree --git-ignore | head -15`
```

### Advanced Git + Modern Tool Combinations

```bash
# Git-tracked file analysis with modern tools
git ls-files '*.py' | xargs rg . -e "import" -l        # Imports in tracked Python files
git ls-files | xargs eza -l --sort=modified | head -5  # Recently modified tracked files

# Exclude patterns for clean project view
eza . --tree --all --git-ignore --ignore-glob=".idea|.claude|node_modules|.git"

# Combine git ls-files with ripgrep for targeted search
git ls-files '*.py' | wc -l && rg . -e "TODO" --type py --count

# Filter documentation by git status
git ls-files --cached --others --exclude-standard '*.md' | grep -v -E '(node_modules|\.git)/'
```

### Performance-Optimized Context

```markdown
## Context (Minimal)

- Status: !`git status --porcelain | wc -l && git branch --show-current`
- Files: !`find . -name "*.py" | wc -l`

## Context (Detailed - only when needed)

- Changes: !`git --no-pager diff --stat --summary`
- Recent commits: !`git log --oneline -5`
```

---
