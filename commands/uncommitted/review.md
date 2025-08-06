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
Critically analyze uncommitted changes:

1. **Smart review based on change size**:
   - If < 100 lines: !`git --no-pager diff --color=never && git --no-pager diff --cached --color=never`
   - If > 100 lines: Show stats, then review key files with Read tool

2. **Critical checks**:
   - **Quality issues**: Bugs, incomplete code (TODO/FIXME), debugging artifacts?
   - **Project compliance**: Follows patterns in @CLAUDE.md? Tests updated?
   - **Security risks**: Exposed secrets, unsafe operations, missing validation?

3. **Test verification** (if code changes detected):
   - Test as described in @CLAUDE.md
   - Check test coverage for new code

## Output Format
1. **PASS/FAIL verdict** with one-line summary
2. **Critical issues** (must fix before commit)
3. **Improvements** (should address)
4. **Suggested commit structure**:
   - Commit type (feat/fix/docs/test/refactor)
   - Commit message
   - Files to group together

Be direct. Find real problems, not style nitpicks.
