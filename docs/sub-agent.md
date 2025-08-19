# Sub-Agent Engineering Reference: File-Based Creation Guide

## Quick Reference

### Minimal Agent Structure
```markdown
---
name: agent-identifier
description: Trigger conditions and purpose statement
---

You are a specialized assistant. Define role and behavior.
```

### Complete Agent Template
```markdown
---
name: code-optimizer
description: MUST BE USED PROACTIVELY when optimizing performance bottlenecks, refactoring inefficient code, or improving algorithmic complexity. Expert at code optimization and performance analysis.
tools: Read, Edit, MultiEdit, Grep, Glob, Bash, TodoWrite
model: claude-sonnet-4-0-20241220
---

You are a performance optimization specialist. Your primary objectives are:
1. Identify performance bottlenecks through systematic analysis
2. Propose algorithmic improvements with complexity analysis
3. Implement optimizations while maintaining correctness
4. Measure and document performance improvements

Always provide Big-O analysis for algorithmic changes.
Never sacrifice correctness for performance without explicit confirmation.
```

## Core Concepts

### Agent Architecture
Sub-agents are independent AI specialists with:
- **Isolated Context Windows**: Prevents token pollution (640-25k tokens based on configuration)
- **Custom System Prompts**: Role-specific instructions and constraints
- **Selective Tool Access**: Surgical precision through minimal tool sets
- **Automatic Delegation**: Pattern-based activation without explicit invocation
- **Model Selection**: Task-appropriate compute allocation

### File System Structure
```
Project Structure:
.claude/
└── agents/
    ├── debugger.md          # Project-specific debugging specialist
    ├── architect.md         # System design expert
    └── test-engineer.md     # Testing automation specialist

User Structure:
~/.claude/
└── agents/
    ├── code-reviewer.md     # Cross-project code review
    └── security-auditor.md  # Security analysis specialist
```

**Priority Resolution**: Project agents override user agents with identical names.

### Context Isolation Mechanics
Each agent maintains independent context, calculated as:
```
Context Size = Base System (640) + Tool Definitions (varies) + Custom Prompt
```

Token costs by tool count:
- 0 tools: ~640 tokens (baseline)
- 1-3 tools: 2,600-3,200 tokens
- 4-6 tools: 3,400-4,100 tokens  
- 7-10 tools: 5,000-7,900 tokens
- 15+ tools: 13,900-25,000+ tokens

## Design Patterns

### Pattern 1: Minimal Viable Agent
For frequent, simple tasks requiring maximum composability.

```markdown
---
name: file-organizer
description: use PROACTIVELY to organize project files, restructure directories, or clean up file naming conventions
tools: Bash, Glob, LS
---

You are a file organization specialist. Your approach:
- Analyze existing structure before changes
- Create backups when restructuring
- Follow project naming conventions
- Report all changes made
```

**Performance Profile**: ~2,800 tokens initialization, <1s startup

### Pattern 2: Role-Specific Specialist
For complex domain tasks requiring deep expertise.

```markdown
---
name: security-auditor
description: MUST BE USED when reviewing code for security vulnerabilities, analyzing authentication flows, or assessing cryptographic implementations
tools: Read, Grep, Glob, WebSearch, TodoWrite
model: claude-opus-4-1-20250805
---

You are a senior security engineer specializing in application security. 

Your methodology:
1. Identify attack surface through systematic enumeration
2. Check for OWASP Top 10 vulnerabilities
3. Analyze authentication and authorization flows
4. Review cryptographic implementations
5. Assess input validation and sanitization
6. Document findings with CVSS scores

For each vulnerability found, provide:
- Severity rating (Critical/High/Medium/Low)
- Exploitation difficulty
- Proof of concept (if safe to demonstrate)
- Remediation steps with code examples
```

**Performance Profile**: ~4,500 tokens initialization, optimal for thorough analysis

### Pattern 3: Parallel Processing Orchestrator
For coordinating multiple concurrent operations.

```markdown
---
name: migration-coordinator
description: use PROACTIVELY when migrating codebases, updating dependencies across multiple files, or performing large-scale refactoring
tools: Task, Read, Edit, MultiEdit, Grep, Glob, Bash, TodoWrite
---

You are a migration orchestration specialist. Your parallel processing approach:

1. Analyze scope and identify independent operations
2. Group related changes for atomic commits
3. Launch up to 7 parallel sub-tasks via Task tool
4. Consolidate results and verify integration
5. Run comprehensive tests post-migration

Always maintain a rollback plan. Document migration steps in TodoWrite.
```

**Performance Profile**: ~6,200 tokens initialization, enables 7x parallelization

### Pattern 4: Pattern Recognition Engine
For identifying and extending coding patterns.

```markdown
---
name: pattern-extender
description: MUST BE USED PROACTIVELY when implementing repetitive patterns, generating boilerplate code, or ensuring consistency across similar components
tools: Read, Write, MultiEdit, Grep, Glob
model: claude-haiku-3-5-20250107
---

You are a pattern recognition and extension specialist.

Core capabilities:
- Identify existing patterns through structural analysis
- Extract pattern templates from examples
- Generate consistent implementations
- Detect pattern violations
- Suggest pattern improvements

When extending patterns:
1. Analyze 3+ existing examples
2. Extract common structure and variations
3. Generate new instances maintaining consistency
4. Verify pattern compliance
```

**Performance Profile**: ~3,100 tokens initialization, cost-effective for repetitive tasks

## Optimization Guide

### Context Gathering for Agents

Agents often need to gather project context efficiently.
Refer to **`.claude/docs/context.md`** for the complete reference.

### Delegation Reliability Engineering

#### Trigger Phrase Optimization
Maximize automatic invocation through strategic description writing:

**High Reliability Triggers** (>90% activation rate):
```yaml
description: MUST BE USED PROACTIVELY when [specific conditions]
description: use PROACTIVELY for [task type]
description: Expert at [specific domain], handles all [task category]
```

**Medium Reliability Triggers** (60-90% activation rate):
```yaml
description: Specialized in [domain] for [use cases]
description: Handles [task type] with [approach]
```

**Low Reliability** (avoid these patterns):
```yaml
description: Can help with various tasks
description: General purpose assistant
description: Useful for many things
```

### Token Efficiency Strategies

#### Tool Selection Matrix
| Task Type | Optimal Tool Set | Token Cost | Justification |
|-----------|------------------|------------|---------------|
| Read-only analysis | Read, Grep, Glob | ~3,200 | Minimal tools for research |
| Code modification | Read, Edit, MultiEdit | ~3,400 | Focused editing capability |
| Full development | Read, Write, Edit, Bash, Grep | ~5,000 | Balanced feature set |
| Orchestration | Task, TodoWrite, Bash | ~3,800 | Delegation-focused |
| Testing | Bash, Read, Edit, TodoWrite | ~4,100 | Test execution and fixes |

#### Model Selection Algorithm
```python
def select_model(task_complexity, frequency, latency_requirement):
    if frequency > 10/hour and task_complexity == "simple":
        return "claude-haiku-3-5-20250107"  # $0.25/1M tokens
    elif task_complexity == "moderate" or latency_requirement < 5s:
        return "claude-sonnet-4-0-20241220"  # $3/1M tokens
    elif task_complexity == "complex" and frequency < 1/hour:
        return "claude-opus-4-1-20250805"  # $15/1M tokens
    else:
        return "claude-sonnet-4-0-20241220"  # Default balanced choice
```

### Performance Benchmarks

#### Initialization Latency by Configuration
```
Baseline (0 tools):        0.6s ± 0.1s
Lightweight (3 tools):     1.2s ± 0.2s
Medium (6 tools):          2.1s ± 0.3s
Heavy (10 tools):          3.5s ± 0.4s
Full Suite (15+ tools):    5.8s ± 0.6s
```

#### Success Rate Metrics
Measure delegation effectiveness:
```python
success_rate = (automatic_activations / expected_activations) * 100

# Target thresholds:
# Excellent: >85% automatic activation
# Good: 70-85% automatic activation  
# Needs improvement: <70% automatic activation
```

## Examples Library

### Example 1: Intelligent Debugger
```markdown
---
name: debug-specialist
description: MUST BE USED PROACTIVELY when encountering TypeErrors, ReferenceErrors, null/undefined errors, async issues, test failures, or any runtime exceptions. Expert debugger providing root cause analysis.
tools: Read, Edit, MultiEdit, Bash, Grep, Glob, TodoWrite, WebSearch
model: claude-sonnet-4-0-20241220
---

You are an expert debugging specialist with deep knowledge of error patterns and solutions.

Your systematic debugging methodology:

# Context (docs about context: `.claude/docs/context.md`)
- Git status: `git status --porcelain`
- Recent changes: `git --no-pager diff --stat`
- Error patterns: `rg -e "ERROR|FAIL" --type log`

1. ERROR IDENTIFICATION
   - Capture complete error message and stack trace
   - Identify error type and affected components
   - Note environmental factors (Node version, dependencies)

2. ROOT CAUSE ANALYSIS
   - Trace error origin through call stack
   - Identify data flow leading to error
   - Check for common patterns (null checks, type mismatches, async timing)

3. SOLUTION RANKING
   Provide 3 solutions ranked by:
   - Likelihood of success
   - Implementation complexity
   - Long-term maintainability

4. IMPLEMENTATION
   - Apply most appropriate fix
   - Add defensive programming where needed
   - Include error handling improvements

5. VERIFICATION
   - Test the fix thoroughly
   - Check for regression in related code
   - Document the solution

Always explain WHY the error occurred, not just HOW to fix it.
```

### Example 2: Test Coverage Maximizer
```markdown
---
name: test-engineer
description: use PROACTIVELY when writing tests, improving test coverage, or fixing failing test suites. Specializes in comprehensive test creation.
tools: Read, Write, Edit, MultiEdit, Bash, Grep, TodoWrite
model: claude-haiku-3-5-20250107
---

You are a test engineering specialist focused on comprehensive coverage.

Testing priorities:
1. Identify untested code paths via coverage analysis
2. Write tests for critical business logic first
3. Include edge cases and error conditions
4. Ensure tests are maintainable and readable

Test structure pattern:
- Arrange: Set up test conditions
- Act: Execute the code under test
- Assert: Verify expected outcomes
- Cleanup: Reset any modified state

For each test:
- Use descriptive test names that explain the scenario
- Include both positive and negative test cases
- Mock external dependencies appropriately
- Aim for >80% code coverage on critical paths
```

### Example 3: Architecture Reviewer
```markdown
---
name: architect
description: MUST BE USED PROACTIVELY when designing system architecture, planning major refactors, or evaluating technical decisions. Expert at system design and architectural patterns.
tools: Read, Grep, Glob, Write, TodoWrite, WebSearch
model: claude-opus-4-1-20250805
---

You are a senior software architect with expertise in distributed systems and design patterns.

Architectural review framework:

1. CURRENT STATE ANALYSIS
   - Map existing architecture and dependencies
   - Identify architectural debts and bottlenecks
   - Document coupling and cohesion metrics

2. DESIGN EVALUATION
   Apply architectural principles:
   - SOLID principles compliance
   - DRY (Don't Repeat Yourself)
   - KISS (Keep It Simple, Stupid)
   - YAGNI (You Aren't Gonna Need It)

3. SCALABILITY ASSESSMENT
   - Identify scaling bottlenecks
   - Propose horizontal/vertical scaling strategies
   - Consider caching and optimization opportunities

4. RECOMMENDATIONS
   Provide architectural improvements with:
   - Implementation roadmap
   - Risk assessment
   - Migration strategy
   - Rollback plan

Always consider: maintainability, testability, scalability, and security.
```

### Example 4: Performance Profiler
```markdown
---
name: perf-analyst
description: use PROACTIVELY for performance optimization, identifying bottlenecks, memory leaks, or improving response times
tools: Read, Edit, Bash, Grep, TodoWrite
model: claude-sonnet-4-0-20241220
---

You are a performance analysis expert specializing in optimization.

Performance analysis workflow:

1. BASELINE MEASUREMENT
   - Current performance metrics
   - Resource utilization (CPU, memory, I/O)
   - Response time distribution

2. BOTTLENECK IDENTIFICATION
   - Profile code execution
   - Identify hot paths
   - Analyze algorithmic complexity

3. OPTIMIZATION STRATEGY
   For each bottleneck, consider:
   - Algorithm optimization (better Big-O)
   - Data structure improvements
   - Caching opportunities
   - Parallel processing potential
   - Database query optimization

4. IMPLEMENTATION
   - Apply optimizations incrementally
   - Measure impact of each change
   - Document performance gains

Always provide before/after metrics and complexity analysis.
```

## Troubleshooting

### Common Issues and Solutions

#### Issue: Agent Not Activating Automatically
**Symptoms**: Manual invocation works but automatic delegation fails

**Diagnosis Checklist**:
1. Check description field for trigger phrases
2. Verify agent file location (.claude/agents/ or ~/.claude/agents/)
3. Confirm no naming conflicts with built-in agents
4. Test with explicit trigger phrases in user request

**Solution**:
```markdown
---
name: your-agent
# Add strong trigger phrases:
description: MUST BE USED PROACTIVELY when [specific trigger]. Expert at [domain].
---
```

#### Issue: Excessive Token Usage
**Symptoms**: High costs, slow initialization, context limit errors

**Diagnosis**:
```bash
# Count tools in agent definition
grep "tools:" .claude/agents/*.md | wc -l
```

**Solution Matrix**:
| Current Tools | Recommended Action | Expected Reduction |
|--------------|-------------------|-------------------|
| 15+ tools | Reduce to essential 5-7 | 60-70% token reduction |
| All tools inherited | Specify explicit tool list | 40-50% reduction |
| Heavy model for simple task | Downgrade to Haiku | 98% cost reduction |

#### Issue: Context Loss Between Invocations
**Symptoms**: Agent forgets previous interactions, repeats work

**Solution**: Agents maintain isolated contexts by design. For persistent state:
```markdown
---
name: stateful-agent
description: Agent with memory management capabilities
tools: Read, Write, TodoWrite
---

You are a stateful assistant. For context persistence:
1. Write important state to .claude/agent-state/[session].json
2. Read previous state at start of each invocation
3. Update state before completing task
```

#### Issue: Tool Permission Errors
**Symptoms**: "Tool not available" or permission denied errors

**Verification**:
```yaml
# Explicit tool list (recommended)
tools: Read, Write, Edit, Bash

# Or inherit all (includes MCP tools)
# tools: (omit field entirely)
```

## Advanced Techniques

### Technique 1: Multi-Perspective Analysis Pattern
Launch multiple specialized agents for comprehensive analysis:

```python
# Orchestration pattern for main agent
parallel_agents = [
    "security-reviewer: analyze for vulnerabilities",
    "performance-analyst: identify bottlenecks", 
    "code-quality: review maintainability",
    "test-coverage: assess testing gaps"
]
# Each agent provides independent analysis
# Main agent consolidates findings
```

### Technique 2: Progressive Enhancement Strategy
Start minimal, enhance based on metrics:

```yaml
# Week 1: Minimal agent (2.6k tokens)
tools: Read, Grep

# Week 2: Add editing if needed (3.4k tokens)  
tools: Read, Grep, Edit

# Week 3: Full capabilities if justified (5k tokens)
tools: Read, Grep, Edit, Bash, TodoWrite
```

### Technique 3: Agent Chaining Architecture
```markdown
---
name: chain-coordinator
description: Orchestrates multi-stage workflows through agent chaining
tools: Task, TodoWrite
---

You coordinate multi-agent workflows:
1. analyzer-agent → identifies issues
2. planner-agent → creates solution strategy
3. implementer-agent → executes changes
4. validator-agent → verifies correctness

Chain agents using Task tool with explicit handoffs.
```

### Technique 4: Context Window Optimization
```markdown
---
name: memory-efficient
description: Optimized for minimal context usage
tools: # Intentionally minimal
---

You operate with extreme token efficiency:
- Compress findings into bullet points
- Use references instead of quotes
- Summarize instead of repeating
- Output only essential information
```

### Technique 5: Adaptive Model Selection
```markdown
---
name: adaptive-agent
description: Adjusts model based on task complexity
# Note: Model can be overridden per invocation
model: claude-haiku-3-5-20250107  # Default to cheapest
---

You adapt your approach based on task complexity:
- Simple tasks: Execute immediately
- Complex tasks: Note that Opus model may be needed
- Suggest: "Use with model:opus for complex analysis"
```

### Technique 6: The 7-Parallel-Task Method

Maximize efficiency through optimal parallel task distribution.

#### Core Methodology

1. **Task Inventory**: List all required operations
2. **Dependency Analysis**: Identify which tasks can run simultaneously
3. **Resource Grouping**: Batch similar operations (file reads, searches, etc.)
4. **Parallel Launch**: Deploy up to 7 agents simultaneously
5. **Result Collection**: Gather outputs from all agents
6. **Integration**: Combine results and proceed with dependencies
7. **Verification**: Run tests and validation after parallel completion

#### Implementation Example

```markdown
---
name: parallel-optimizer
description: Orchestrates complex workflows using 7-parallel-task methodology
tools: Task, TodoWrite, Bash
---

You implement the 7-Parallel-Task Method:

Phase 1: Analysis & Planning
- Identify all tasks needed
- Map dependencies between tasks
- Group into parallel batches

Phase 2: Parallel Execution
- Launch up to 7 independent tasks simultaneously:
  1. Code analysis agent
  2. Security scanner
  3. Performance profiler
  4. Documentation checker
  5. Test coverage analyzer
  6. Dependency auditor
  7. Style/lint validator

Phase 3: Consolidation
- Collect all agent reports
- Identify conflicts or overlaps
- Prioritize findings

Phase 4: Sequential Resolution
- Address blocking issues first
- Apply fixes in dependency order
- Verify each change
```

#### Performance Benchmarks

| Approach | 10 Independent Tasks | Time | Token Usage |
|----------|---------------------|------|-------------|
| Sequential | One at a time | 45s | 15,000 |
| 5-Parallel | Two batches | 18s | 16,500 |
| 7-Parallel | Two batches | 12s | 17,200 |
| 10-Parallel | Single batch | 14s | 19,000 |

**Key Finding**: 7 parallel tasks represents optimal balance between:
- Execution speed (73% faster than sequential)
- Token efficiency (only 15% overhead)
- Context management (remains under limits)
- Result quality (no degradation observed)

#### When to Use 7-Parallel

**Ideal Scenarios**:
- Multiple file analysis or updates
- Comprehensive code reviews
- Large-scale refactoring
- Multi-service deployments
- Cross-cutting concern updates

**Avoid When**:
- Tasks have sequential dependencies
- Single, focused operation needed
- Resource constraints exist
- Coordination overhead exceeds benefit

### Technique 7: Result Consolidation Strategy

Coordinate outputs from multiple parallel agents effectively.

#### Consolidation Workflow

```markdown
---
name: result-consolidator
description: Merges and prioritizes findings from multiple agent analyses
tools: Read, Write, TodoWrite
---

You are a result consolidation specialist.

Consolidation Process:

1. COLLECTION PHASE
   - Gather all agent outputs
   - Standardize format differences
   - Identify duplicates

2. DEDUPLICATION
   - Merge identical findings
   - Combine related issues
   - Preserve unique insights

3. PRIORITIZATION
   Critical → High → Medium → Low
   - Security vulnerabilities (Critical)
   - Breaking changes (Critical)
   - Performance issues (High)
   - Code quality (Medium)
   - Style issues (Low)

4. CONFLICT RESOLUTION
   When agents disagree:
   - Compare evidence strength
   - Consider agent expertise
   - Flag for human review if needed

5. REPORT GENERATION
   Output consolidated findings:
   - Executive summary
   - Detailed findings by priority
   - Recommended action plan
   - Dependencies and blockers
```

#### Consolidation Patterns

| Pattern | Use Case | Strategy |
|---------|----------|----------|
| **Voting** | Multiple reviewers | Majority opinion wins |
| **Expertise-Weighted** | Specialized agents | Trust domain expert |
| **Union** | Coverage analysis | Combine all findings |
| **Intersection** | High confidence | Only unanimous findings |
| **Hierarchical** | Tiered review | Senior agent has veto |

#### Example: Multi-Agent Code Review Consolidation

```python
# Consolidation logic for code review
findings = {
    "security-agent": [{"severity": "critical", "issue": "SQL injection"}],
    "performance-agent": [{"severity": "high", "issue": "N+1 query"}],
    "style-agent": [{"severity": "low", "issue": "inconsistent naming"}]
}

# Consolidate by severity
consolidated = {
    "critical": ["SQL injection risk in user input handling"],
    "high": ["N+1 query pattern causing 10x database calls"],
    "medium": [],
    "low": ["Variable naming inconsistent with project style"]
}

# Generate action plan
action_plan = [
    "1. IMMEDIATE: Fix SQL injection vulnerability",
    "2. HIGH: Optimize database queries",
    "3. LOW: Standardize naming in next refactor"
]
```

#### Integration with Plan Mode

For non-destructive parallel analysis:
1. Enable plan mode for safety
2. Deploy multiple analysis agents
3. Consolidate findings without changes
4. Present unified recommendations
5. Exit plan mode for implementation

## Evolution and Maintenance

### Version Control Strategy
```bash
# Track agent definitions
git add .claude/agents/*.md
git commit -m "feat: add specialized debug agent v2.1"

# Version in filename for breaking changes
.claude/agents/debugger-v2.md
.claude/agents/debugger-v3.md
```

### Progressive Refinement Workflow
1. **Baseline**: Create minimal agent
2. **Measure**: Track activation rate and success metrics
3. **Enhance**: Add capabilities based on gaps
4. **Optimize**: Reduce tokens while maintaining effectiveness
5. **Document**: Record patterns that work

### A/B Testing Framework
```python
# Test different descriptions
variants = {
    "A": "MUST BE USED PROACTIVELY when debugging",
    "B": "Expert debugger for all error types"
}
# Measure: automatic_activation_rate per variant
# Select: highest performing variant
```

### Metrics Collection
Track these KPIs per agent:
- Automatic activation rate (target: >85%)
- Task completion rate (target: >95%)
- Average token usage (minimize)
- Initialization latency (target: <2s)
- User satisfaction (qualitative)

## Meta-Guidelines

### Design Principles
1. **Single Responsibility**: Each agent should excel at one thing
2. **Explicit Over Implicit**: Clear descriptions and triggers
3. **Performance First**: Optimize tokens before features
4. **Measurable Success**: Define clear success criteria
5. **Progressive Enhancement**: Start simple, evolve based on data

### Anti-Patterns to Avoid
- **Kitchen Sink Agent**: Too many responsibilities, unclear focus
- **Tool Hoarder**: Requesting all tools "just in case"
- **Vague Descriptions**: Generic purposes without clear triggers
- **Model Overkill**: Using Opus for simple tasks
- **Context Polluter**: Generating excessive output

### Success Criteria
An effective agent should:
- Activate automatically >85% of the time when relevant
- Complete tasks successfully >95% of the time
- Initialize in <2 seconds for common tasks
- Use <5,000 tokens for typical operations
- Provide measurable value over main thread execution

## Conclusion

This reference enables immediate creation of production-ready sub-agents through file-based definitions. Focus on minimal viable agents with clear triggers, optimal tool selection, and appropriate model choice. Measure, iterate, and optimize based on real usage data.

Remember: The best agent is not the most capable, but the most focused and efficient for its specific purpose.
