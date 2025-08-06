---
description: Critically analyze all uncommitted changes before committing
model: claude-opus-4-1-20250805
allowed-tools: Bash(git:*)
---

# Critical Uncommitted Changes Review

## Context
- Current branch: !`git branch --show-current`
- Working tree: !`git status --porcelain`
- Change summary: !`git --no-pager diff --shortstat; git --no-pager diff --cached --shortstat`

## Changes Detail
- **Staged**: !`git --no-pager diff --stat --cached --summary`
- **Unstaged**: !`git --no-pager diff --stat --summary`
- **Untracked**: !`git ls-files --others --exclude-standard | head -10`

## Task
Analyze uncommitted changes and provide actionable feedback:

1. **Get changes**:
   - If < 100 lines: !`git --no-pager diff --color=never && git --no-pager diff --cached --color=never`
   - If > 100 lines: Show stats, then review key files with Read tool

2. **Focus areas** (prioritize actual problems):
   - **Path accuracy**: All file paths in configs/CI match actual locations?
   - **Import issues**: Verbose debug output or missing dependencies?
   - **Duplicate files**: Redundant files that should be consolidated?
   - **Completeness**: TODOs, FIXMEs, commented code, debug artifacts?
   - **Test coverage**: Tests actually verify the behavior changes?
   - **Breaking changes**: API/config/dependency compatibility issues?
   - **CLAUDE.md updates** @CLAUDE.md up to date? (check against `CLAUDE.md rules` in @CLAUDE.md)
   - **Documentation sync**: @docs up to date?

3. **Test verification** (only if code changes detected):
   - Run tests as described in @CLAUDE.md
   - Verify no test regressions

## Output Format

**Summary**
- 2-3 lines describing the changes and overall assessment
- No verbose risk categories or theoretical analysis

**Critical Issues**
- Only blocking problems that MUST be fixed (e.g., broken CI paths, missing files)
- Include specific line numbers and files

**Improvements (Should Address)**  
- Non-blocking but important issues (e.g., duplicate files, verbose imports)
- Be specific and actionable

Provide direct, unfiltered feedback. Be the thorough reviewer everyone needs but nobody wants.
Focus on actual problems, not hypothetical edge cases. Keep feedback specific and actionable.
