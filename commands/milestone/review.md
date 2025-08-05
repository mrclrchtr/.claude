---
argument-hint: [milestone_name]
description: Critically analyze milestone implementation and documentation
model: claude-opus-4-0
allowed-tools: Bash(git log:*), Bash(git diff:*), Bash(find:*)
---

# Critical Milestone Review

## Context
- Manager: @docs/MILESTONE_MANAGER.md
- Available milestones: !`find docs/milestones -name "M[0-9]*-*.md" -o -name "M[0-9]*_[0-9]*-*.md" -type f | sort`
- Implementation status: !`git log --oneline --grep="[Mm]ilestone\|M[0-9]_" -10`
- Recent changes: !`git diff --stat HEAD~5..HEAD`

## Task
Critically analyze milestone implementation ($ARGUMENTS or last [DONE]):

1. **Locate milestone**
   - If no argument: find last [DONE] milestone
   - Error if not found: "Milestone not found: $ARGUMENTS"

2. **Deep analysis of @$MILESTONE_PATH**:
   - **Deliverables audit**: Compare promised vs actual implementation
   - **Documentation accuracy**: Verify docs reflect real progress, not aspirational claims
   - **Protocol compliance**: Confirm ALL administrative requirements completed
   - **Blind spots**: Expose unstated assumptions and overlooked requirements
   - **Waste analysis**: Identify effort spent on non-essential activities

3. **Implementation review**:
   - Analyze git commits related to milestone
   - Verify code changes match documented deliverables
   - Check for incomplete or deferred work disguised as "future improvements"

4. **Critical assessment**:
   - What was actually built vs what was promised?
   - Which assumptions need validation before production?
   - What routine but critical tasks might have been skipped?
   - Where did scope creep or perfectionism waste effort?

5. **Documentation compliance**:
   - Verify updates to @docs/IMPLEMENTATION_PLAN.md reflect current state
   - Confirm @docs/IMPLEMENTATION_LOG.md contains detailed technical decisions following the "How to Update This Log" guidelines (timeline entries, milestone sections, technical debt, lessons learned)
   - Check related milestone document has complete status updates

Be direct, objective, and brutally honest. No sugar-coating allowed.
