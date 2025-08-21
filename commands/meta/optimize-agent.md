---
argument-hint: [agent-file-path]
description: Optimize sub-agent for efficiency
allowed-tools: Read, Edit, MultiEdit
---

# Optimize Sub-Agent

## Context

- Agent path: $ARGUMENTS
- Agent content: @$ARGUMENTS
- Agent documentation: @.claude/docs/sub-agent.md
- Optimization patterns: @.claude/docs/optimization-patterns.md
- Context commands: @.claude/docs/context.md

## Task

Analyze the agent at $ARGUMENTS to determine if optimization would provide meaningful value.

### What Agent Optimization Actually Means

Optimization = Making agents MORE EFFECTIVE through:
1. **Trigger Reliability** (Priority 1) - Fix weak activation phrases
2. **Token Efficiency** (Priority 2) - Reduce context overhead (target <5K tokens)
3. **Tool Precision** (Priority 3) - Remove unnecessary tools
4. **Model Right-Sizing** (Priority 4) - Match model to task complexity

### Optimization Decision Tree

Ask these questions IN ORDER:
1. Does agent fail to activate automatically? → YES: Fix triggers (HIGH VALUE)
   - *Example: "Can help with" → "MUST BE USED PROACTIVELY when"*
2. Does agent use >7K tokens or all tools? → YES: Reduce scope (HIGH VALUE)
   - *Example: 15+ tools → 3-5 essential tools*
3. Is agent using wrong model for task? → YES: Right-size (MEDIUM VALUE)
   - *Example: opus for simple grep → haiku*
4. Are there redundant instructions? → YES: Consolidate (LOW VALUE)
5. Would changes improve by >20%? → YES: Proceed
6. **None of the above? → STOP: Output "Agent analysis complete. No significant improvements needed."**

### When NOT to Optimize
- Agent activates reliably (>85% when expected)
- Token usage already <5K
- Model matches complexity
- This is 2nd+ optimization pass
- Agent performance metrics are good

### Rev the Engine (Self-Critique)

Before optimizing:
1. State planned changes
2. Challenge: "Will this break activation?"
3. Consider: "Am I removing critical context?"
4. Identify: "What could fail after changes?"
5. Refine approach based on critique

### Agent-Specific Optimization Patterns

#### Trigger Phrase Optimization (>90% activation)
```yaml
# STRONG (use these)
description: MUST BE USED PROACTIVELY when [specific condition]
description: Expert at [domain], handles all [task type]

# WEAK (avoid these)
description: Can help with various tasks
description: General purpose assistant
```

#### Tool Selection Matrix
| Task Type | Optimal Tools | Tokens | Justification |
|-----------|--------------|--------|---------------|
| Analysis | Read, Grep, Glob | ~3.2K | Research only |
| Editing | Read, Edit, MultiEdit | ~3.4K | Focused changes |
| Testing | Bash, Read, TodoWrite | ~4.1K | Test & track |
| Orchestration | Task, TodoWrite | ~3.1K | Delegation |

#### Model Selection Algorithm
- **haiku**: Simple, frequent tasks (>10/hour)
- **sonnet**: Moderate complexity, balanced
- **opus**: Complex, infrequent (<1/hour)
- **inherit**: Use main thread model (default)

### Optimization Process

1. **Analyze current agent**:
   - Measure trigger phrase strength
   - Count tools and estimate tokens
   - Check model appropriateness
   - Review context gathering efficiency

2. **Assess improvement value**:
   - Activation improvement: 50% value
   - Token reduction by half: 30% value
   - Model right-sizing: 15% value
   - Style changes: <5% value (skip)
   
   **>20% total? Proceed. Otherwise stop.**

3. **Apply optimizations**:
   - Strengthen trigger phrases with "MUST BE USED PROACTIVELY"
   - Reduce tools to essential 3-5
   - Update bash commands per @.claude/docs/context.md patterns
   - Select appropriate model or inherit
   - Remove default AI knowledge

4. **Validate**:
   - Activation: Description includes strong triggers
   - Efficiency: <5K token initialization
   - Focus: Single clear responsibility
   - Tools: Minimal necessary set

### Common Agent Anti-Patterns

```markdown
❌ Vague triggers: "helps with debugging"
✓ Strong triggers: "MUST BE USED PROACTIVELY when encountering errors"

❌ All tools: tools: (inherit all)
✓ Precise tools: tools: Read, Edit, Bash

❌ Verbose context: Full file contents
✓ Efficient context: Counts and stats

❌ Model overkill: opus for simple tasks  
✓ Right-sized: haiku for simple, inherit for default
```

### Success Metrics

An optimized agent should achieve:
- >85% automatic activation when relevant
- <5K token initialization
- <2 second startup
- Clear single responsibility
- Measurable improvement over main thread

### Output Format

Provide optimized agent with:
1. Strengthened trigger descriptions
2. Minimal tool set (3-5 tools)
3. Efficient context patterns
4. Appropriate model selection
5. Report: changes made, tokens saved, activation improved

Rev the engine before finalizing!