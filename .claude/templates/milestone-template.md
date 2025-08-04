# Milestone: {ID} {Title} {Weight-Class-Emoji} [P/S/B]

**Parallel Track**: {Track Name if applicable}  
**Dependencies**: {Upstream milestone IDs}  
**Can Run In Parallel With**: {Other milestone IDs}  
**Status**: {pending/in_progress/completed}

## Prerequisites
{List any critical blockers or setup requirements that must be resolved before this milestone can begin}
- [ ] {Blocker 1: Description and resolution approach}
- [ ] {Environment requirement: e.g., Docker setup, API keys}
- [ ] {Previous milestone completion: Specific deliverables needed}

## Overview
Brief description of the milestone's purpose and its role in the larger project context.

## Objectives
- [ ] Clear, measurable objective 1
- [ ] Clear, measurable objective 2
- [ ] Clear, measurable objective 3

## Deliverables
- [ ] Specific deliverable 1 (est. tokens: {X})
- [ ] Specific deliverable 2 (est. tokens: {Y})
- [ ] Specific deliverable 3 (est. tokens: {Z})

## Success Criteria
- **Automated tests**: {specific test suite/coverage requirements}
- **Manual validation**: {specific validation procedures}
- **Performance metrics**: {measurable performance requirements}
- **Quality metrics**: {code quality, documentation standards}

## Timeline
- **Start**: {Condition or date}
- **Duration**: {Base estimate} ({Adjusted with integration multipliers if applicable})
- **Buffer**: {20% minimum, specify additional days for complex work}
- **Blocker Resolution Time**: {Additional time if prerequisites not met}
- **Parallel Speedup**: {X% if run concurrently with specified milestones}
- **Critical Path**: {Yes/No - does this block other work?}

## Risk Factors
| Risk | Impact | Likelihood | Mitigation Strategy | Owner |
|------|--------|------------|-------------------|--------|
| {Risk description} | H/M/L | H/M/L | {Specific mitigation} | {Team/Person} |

## Resource Allocation
| Team/Resource | Tasks | Capacity | Conflicts |
|---------------|-------|----------|-----------|
| {Team name} | {Task list} | {Hours/Points} | {Other milestones needing same resource} |

## Dependencies
### Upstream Dependencies
- {Milestone ID}: {What it provides}
- {External system}: {Integration requirements}

### Downstream Impact
- {Milestone ID}: {What this enables}
- {Feature/Component}: {How it's affected}

## Technical Specifications
### Architecture Decisions
- {Key technical choices and rationale}

### Integration Points
- {External APIs/Services with error handling approach}
- {Internal interfaces with contract definitions}

### Implementation Notes
- {Critical technical details}
- {Performance considerations}
- {Security considerations}

## Testing Requirements
- **Unit Tests**: {Coverage target, specific test cases}
- **Integration Tests**: {API contracts, system boundaries}
- **E2E Tests**: {User flows, critical paths}
- **Performance Tests**: {Load targets, response times}
- **Security Tests**: {Vulnerability scans, penetration tests}

## Documentation Requirements
- [ ] Code documentation (inline comments, function docs)
- [ ] API documentation (if applicable)
- [ ] Architecture decision records (ADRs)
- [ ] User-facing documentation
- [ ] Runbook/operational guide

## Troubleshooting
**Common Issues and Solutions:**
1. **{Issue 1}**
   - Error: {Specific error message}
   - Solution: {Step-by-step resolution with code/commands}
   
2. **{Issue 2}**
   - Error: {Specific error message}
   - Solution: {Step-by-step resolution with code/commands}

**Fallback Strategies:**
- If {primary approach} fails: {Alternative approach}
- If {dependency} unavailable: {Workaround}

## Implementation Examples
```bash
# Example commands for setup/testing
{command 1}
{command 2}
```

```{language}
// Example code snippet showing key implementation
{code example}
```

## Notes
- **Token Budget**: {lightweight <3K / medium 10-15K / heavy 25K+}
- **Integration Multipliers Applied**: {2x CLI, 3x complex API, 1.5x documented library, 2x blocker resolution}
- **Parallel Execution Notes**: {Specific coordination requirements}