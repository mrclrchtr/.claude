---
argument-hint: [commit_hash]
description: Critically analyze a single commit's changes and impact
model: claude-opus-4-1-20250805
allowed-tools: Bash(git show:*), Bash(git diff:*), Bash(git log:*), Bash(git rev-parse:*)
---

# Critical Commit Review

## Context
- Target commit: !`git rev-parse --short ${ARGUMENTS:-HEAD}`
- Current branch: !`git branch --show-current`
- Recent history: !`git log --oneline -5`

## Commit Classification
- **Size**: !`git show --stat --format="" ${ARGUMENTS:-HEAD} | tail -1`
- **Files changed**: !`git show --name-only --format="" ${ARGUMENTS:-HEAD} | wc -l`
- **Type**: Extract from commit message (feat/fix/docs/chore/refactor/test/style)
- **Risk level**: Assess based on files touched (config/core/test/docs)

## Review Depth Guide
- **Documentation-only changes** (*.md, *.txt): Skip sections 3-4
- **< 10 line changes**: Focus on sections 0-2, quick scan 3
- **Config/dependency changes**: Emphasize sections 4-5
- **Feature/refactor commits**: Full review required
- **Test-only changes**: Focus on test quality (section 3)

## Task
Critically analyze commit `${ARGUMENTS:-HEAD}`:

1. **Quick checks**:
   - **Stats**: !`git --no-pager show --stat --no-patch ${ARGUMENTS:-HEAD}`
   - **Full diff**: !`git --no-pager show ${ARGUMENTS:-HEAD}`
   - **Tests pass**: Run appropriate test command as described in @CLAUDE.md
   - **Linting clean**: Check style compliance if applicable

2. **Core review** (focus here):
   - **Atomic**: Does this do ONE thing well?
   - **Accurate**: Does message match actual changes?
   - **Complete**: Any TODOs, FIXMEs, or commented code?
   - **Quality**: Obvious bugs, code duplication, performance issues?
   - **Testing**: Do tests verify the actual behavior changes?

3. **Impact assessment**:
   - **Breaking changes**: APIs, configs, dependencies?
   - **Hidden risks**: Edge cases, production scenarios?
   - **Project compliance**: Commit format (feat/fix/docs/chore), milestone tag (M0, M1, etc)?
   - **CLAUDE.md updates** @CLAUDE.md up to date? (check against `CLAUDE.md rules` in @CLAUDE.md)
   - **Documentation sync**: @docs up to date?

## Output format
1. **PASS/FAIL verdict** with reasoning
2. **Critical issues** that must be fixed
3. **Minor issues** that should be addressed
4. **Questions** for the author

No sugar-coating. Be the reviewer everyone needs but nobody wants.
