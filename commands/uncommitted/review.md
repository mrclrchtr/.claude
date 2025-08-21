---
description: Critically analyze all uncommitted changes before committing
allowed-tools: Bash(git:*), Bash(test:*), Bash(find:*), Bash(grep:*)
---

# Critical Uncommitted Changes Review

## Repository Status
- Branch: !`git branch --show-current`
- File status: !`git status --porcelain`

## Recent History
- Last 5 commits: !`git --no-pager log --oneline -5`

## Change Statistics  
- Ready to commit: !`git --no-pager diff --stat --cached`
- Not yet staged: !`git --no-pager diff --stat`

## Full Changes
- Ready to commit: !`git --no-pager diff --cached --color=never --unified=5`
- Not yet staged: !`git --no-pager diff --color=never --unified=5`

## Test Configuration Discovery
- package.json test scripts: !`grep -E '"(test|spec)"' package.json 2>/dev/null || echo "No package.json found"`
- Makefile test targets: !`grep -E '^test' Makefile 2>/dev/null || echo "No Makefile found"`
- Python test setup: !`test -f pytest.ini && echo "pytest.ini found" || test -f setup.py && grep test setup.py 2>/dev/null || echo "No Python test config found"`
- Go test presence: !`find . -name "*_test.go" -type f 2>/dev/null | head -5 | wc -l | xargs -I {} echo "{} Go test files found"`
- Test directories: !`test -d tests && echo "tests/ directory exists" || test -d test && echo "test/ directory exists" || echo "No standard test directory found"`
- CI test commands: !`test -f .github/workflows && grep -h "run:" .github/workflows/*.yml 2>/dev/null | grep -i test | head -3 || echo "No GitHub Actions test commands found"`

## Task
Analyze all changes and provide actionable feedback:

1. **Focus areas** (prioritize actual problems):
   - **Path accuracy**: All file paths in configs/CI match actual locations?
   - **Import issues**: Verbose debug output or missing dependencies?
   - **Duplicate files**: Redundant files that should be consolidated?
   - **Completeness**: TODOs, FIXMEs, commented code, debug artifacts?
   - **Test coverage**: Tests actually verify the behavior changes?
   - **Breaking changes**: API/config/dependency compatibility issues?
   - **CLAUDE.md updates** @CLAUDE.md up to date? (check against `Maintenance Rules` in @CLAUDE.md)
   - **Documentation sync**: @docs (especially @docs/IMPLEMENTATION_LOG.md, @docs/MILESTONE_MANAGER.md, @docs/TECHNICAL_DEBT.md, @docs/milestones, @docs/architecture) up to date?

2. **Test verification** (only if code changes detected):
   - Based on the test configuration discovered above, run the appropriate test command
   - If no clear test command found, check @CLAUDE.md for test instructions
   - Verify no test regressions compared to baseline
   - Report specific test failures with file and line numbers

## Output Format

**Summary**
- 2-3 lines describing the changes and overall assessment
- No verbose risk categories or theoretical analysis

**Critical Issues**
- Only blocking problems that MUST be fixed (e.g., broken CI paths, missing files, failing tests)
- Include specific line numbers and files

**Improvements (Should Address)**  
- Non-blocking but important issues (e.g., duplicate files, verbose imports)
- Be specific and actionable

**Test Results** (if tests were run)
- Command executed: [exact command]
- Pass/Fail status
- Any new failures introduced by changes

Provide direct, unfiltered feedback. Be the thorough reviewer everyone needs but nobody wants.
Focus on actual problems, not hypothetical edge cases. Keep feedback specific and actionable.
