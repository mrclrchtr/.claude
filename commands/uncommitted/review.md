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

## Review Depth Guide
- **Documentation-only changes** (*.md, *.txt): Skip sections 3-4
- **< 10 line changes**: Focus on core review, quick test check
- **Config/dependency changes**: Emphasize security, compatibility, breaking changes
- **Feature/refactor changes**: Full comprehensive review required
- **Test-only changes**: Focus on test quality and coverage

## Task
Critically analyze uncommitted changes:

1. **Smart review based on change size**:
   - If < 100 lines: !`git --no-pager diff --color=never && git --no-pager diff --cached --color=never`
   - If > 100 lines: Show stats, then review key files with Read tool

2. **Core review** (focus here):
   - **Atomic changes**: Are changes grouped logically for clean commits?
   - **Completeness**: Any TODOs, FIXMEs, commented code, debugging artifacts?
   - **Code quality**: Obvious bugs, code duplication, performance issues?
   - **Accuracy**: Will commit messages accurately describe these changes?
   - **Test coverage**: Do tests verify the actual behavior changes?
   - **Security**: Exposed secrets, unsafe operations, missing validation?
   - **Project compliance**: Follows patterns in @CLAUDE.md?
   - **CLAUDE.md updates**: Is @CLAUDE.md up to date? (check against `CLAUDE.md rules` in @CLAUDE.md)
   - **Documentation sync**: Are @docs files updated for any architecture/API changes?

3. **Impact assessment** (critical for large changes):
   - **Breaking changes**: APIs, configs, dependencies?
   - **Hidden risks**: Edge cases, production scenarios?
   - **File type risks**: Config (high), Core (high), Test (low), Docs (minimal)

4. **Test verification** (if code changes detected):
   - Test as described in @CLAUDE.md
   - Check test coverage for new code
   - Verify no regressions in existing tests

## Output Format
1. **PASS/FAIL verdict** with one-line summary
2. **Risk assessment** per change group (high/medium/low) with file type analysis
3. **Critical issues** (must fix before commit)
4. **Improvements** (should address)
5. **Suggested commit structure** (based on atomic changes principle):
   - Commit type (feat/fix/docs/test/refactor/chore)
   - Commit message recommendation
   - Files to group together
   - Order of commits if multiple needed
6. **Follow-up actions** (if issues found that need separate commits)

Be direct. Find real problems, not style nitpicks. Focus on the Core review section for maximum value.
