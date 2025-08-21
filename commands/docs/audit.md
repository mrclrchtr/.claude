---
description: Audit documentation for inconsistencies and fix them
---

# Documentation Audit

## Context

- Documentation files: !`find . -name "*.md" -not -path "./tmp.benchmarks/*" -not -path "./polyglot-benchmark/*" -not -path "./node_modules/*"`
- Structure: !`find docs -type f -name "*.md" | sort && ls -la *.md 2>/dev/null`

## Task

Audit markdown documentation for inconsistencies.
Exclude polyglot-benchmark/ (upstream exercises).

### 1. Analysis

Identify:
- Conflicting facts, versions, paths, commands
- Missing cross-references, outdated info
- Duplicate content, naming inconsistencies

### 2. Resolution

For each issue span a sub agent that:
- Verify against code/implementation
- If clear → Fix automatically
- If ambiguous → STOP, ask user
- Document fix in report

### 3. Output

Create `docs/documentation-audit-report.md`:
- Issues found and fixes applied
- User decisions needed
- Maintenance recommendations

## Rules

- CLAUDE.md is single source of truth
- Milestone status only in MILESTONE_MANAGER.md and milestone files
- Use references, avoid duplication
- When uncertain, ask user
