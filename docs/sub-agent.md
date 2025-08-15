# Claude Code Subagents - Comprehensive Guide

## Overview

**Subagents** are specialized AI assistants within Claude Code that handle specific types of tasks with their own dedicated context windows, custom system prompts, and configurable tool access. They represent a paradigm shift towards **agent-first design**, where AI agents are treated as first-class participants in creation, iteration, and scaling.

Subagents are pre-configured AI personalities that operate independently from the main Claude Code conversation, featuring specific expertise areas, isolated context windows, configurable tool access, and custom system prompts that guide behavior and approach.

## Core Architecture & Philosophy

### Architecture Principles

- **Parallel Task Delegation**: Subagents operate like programming threads, performing independent operations simultaneously for improved execution efficiency
- **Explicit Orchestration**: The main agent coordinates subagent activities with careful task delegation and explicit instructions
- **Context Isolation**: Each subagent maintains its own context window, preventing pollution and enabling focused problem-solving
- **Pattern Extension**: Beyond simple task execution, subagents recognize and creatively extend patterns to generate new value

### Agent-First Philosophy

Subagents embody the agent-first design philosophy by:
- Moving beyond human task automation to enabling agents as creative partners
- Building modular, templatable experiences that agents can systematically vary
- Enabling mass customization and personalization at scale
- Creating systems where agents can generate infinite variations from finite foundations

### Operational Architecture

**Main Agent:**
- Interactive but can have higher latency
- Orchestrates and coordinates sub-agent activities
- Manages overall workflow and task completion
- Maintains primary context window

**Sub-Agents:**
- Execute tasks independently with dedicated context windows
- Handle file operations, code searches, and bash commands
- Primarily used for read/search operations for safety
- Results consume space in the main agent's context

## Configuration & Setup

### Quick Start Guide

1. **Open the subagents interface**: Run `/agents`
2. **Select 'Create New Agent'**: Choose project-level or user-level subagent
3. **Define the subagent**:
   - Generate with Claude first, then customize (recommended approach)
   - Describe the subagent in detail and when it should be used
   - Select tools to grant access to (or leave blank to inherit all tools)
   - Edit system prompt in your preferred editor by pressing `e`
4. **Save and use**: Subagent becomes available automatically or via explicit invocation

### File Locations & Priority

| Type | Location | Scope | Priority |
|------|----------|-------|----------|
| **Project subagents** | `.claude/agents/` | Available in current project | Highest |
| **User subagents** | `~/.claude/agents/` | Available across all projects | Lower |

*Note: Project-level subagents take precedence over user-level subagents when names conflict.*

### Configuration Format

Subagents are defined as Markdown files with YAML frontmatter:

```markdown
---
name: your-sub-agent-name
description: Description of when this subagent should be invoked
tools: tool1, tool2, tool3  # Optional - inherits all tools if omitted
model: claude-sonnet-4-0  # Optional - specify Claude model
---

Your subagent's system prompt goes here. This can be multiple paragraphs
and should clearly define the subagent's role, capabilities, and approach
to solving problems.
```

### Configuration Fields

- **`name`** (Required): Unique identifier using lowercase letters and hyphens
- **`description`** (Required): Natural language description of the subagent's purpose
- **`tools`** (Optional): Comma-separated list of specific tools. If omitted, inherits all tools from the main thread
- **`model`** (Optional): Specify which Claude model the agent should use

### Tool Configuration Options

1. **Omit the `tools` field**: Inherit all tools from main thread (default), including MCP tools
2. **Specify individual tools**: Comma-separated list for granular control

## Usage Methods & Examples

### Automatic Delegation

Claude Code proactively delegates tasks based on:
- Task description in your request
- The `description` field in subagent configurations
- Current context and available tools

*Tip: Include phrases like "use PROACTIVELY" or "MUST BE USED" in your description field for more proactive use.*

### Explicit Invocation

Request specific subagents by mentioning them:
```
> Use the test-runner subagent to fix failing tests
> Have the code-reviewer subagent look at my recent changes
> Ask the debugger subagent to investigate this error
```

### Example Subagents

#### Code Reviewer
**Purpose**: Expert code review for quality, security, and maintainability
**Tools**: Read, Grep, Glob, Bash
**Key Features**: Runs git diff, focuses on modified files, provides prioritized feedback

#### Debugger
**Purpose**: Debugging specialist for errors, test failures, and unexpected behavior
**Tools**: Read, Edit, Bash, Grep, Glob
**Key Features**: Root cause analysis, systematic debugging process, minimal fixes

#### Data Scientist
**Purpose**: Data analysis expert for SQL queries, BigQuery operations, and insights
**Tools**: Bash, Read, Write
**Key Features**: Optimized SQL queries, BigQuery CLI tools, data-driven recommendations

## Advanced Patterns & Workflows

### Parallel Processing & Task Delegation

#### Efficient Parallel Workflows

1. **Explicit Step Definition**: Provide detailed, unambiguous steps for each delegated task
2. **Task Grouping**: Group related tasks together to optimize token costs
3. **Clear Instructions**: Use specific instructions to minimize ambiguity and rework

#### The 7-Parallel-Task Method

For maximum efficiency when dealing with multiple related tasks:

1. **Identify Parallelizable Tasks**: Find operations that don't depend on each other
2. **Group by Resource Type**: Batch similar operations (file reads, searches, etc.)
3. **Launch Up to 7 Tasks Simultaneously**: This represents the optimal balance
4. **Explicit Orchestration**: Like programming with threads, explicit coordination yields best results
5. **Consolidate Results**: Gather outputs and proceed with sequential dependencies
6. **Verify Integration**: Run tests and builds after parallel completion
7. **Iterate Based on Results**: Use findings to inform next parallel batch

**Key Principle**: "Like programming with threads, explicit orchestration of which steps get delegated to sub-agents yields the best results."

#### Structured Workflow Example

```markdown
## Parallel Feature Implementation Workflow
1. Create main component file
2. Create component styles/CSS (parallel)
3. Create test files (parallel)
4. Update imports and exports (parallel)
5. Run tests and fix issues (sequential)
```

#### Orchestration Best Practices

- **Strip Comments**: When reading files for analysis to reduce token usage
- **Minimize Context Transfer**: Only pass essential information between agents
- **Strategic Delegation**: Delegate tasks that don't require constant human intervention
- **Batch Similar Operations**: Combine small configuration updates to prevent over-splitting

### Chaining Subagents

For complex workflows, chain multiple subagents:
```
> First use the code-analyzer subagent to find performance issues, then use the optimizer subagent to fix them
```

### Split-Role Sub-Agents Pattern

Split-role sub-agents enable multiple specialized agent perspectives to analyze a single task simultaneously, providing comprehensive insights through parallel analysis.

#### Implementation Strategy
1. **Activate Plan Mode** for safe exploration and experimentation
2. **Enable ultrathink** for enhanced reasoning capabilities
3. **Define specific, non-overlapping role perspectives**
4. **Launch sub-agents to analyze tasks concurrently**
5. **Consolidate findings from all perspectives**

#### Common Role Divisions

**Code Review Roles:**
- Factual Analyst: Objective code correctness
- Senior Engineer: Architectural decisions and best practices
- Security Expert: Vulnerability identification
- Consistency Reviewer: Code style and pattern adherence
- Redundancy Checker: Duplicate or unnecessary code

**User Experience Roles:**
- Creative Designer: Innovative design solutions
- Novice User: Accessibility and ease-of-use
- Marketing Specialist: User engagement and conversion
- SEO Expert: Search optimization and discoverability

**Documentation Roles:**
- Technical Accuracy Checker: Information correctness
- Beginner Accessibility Reviewer: Clarity for new users
- Content Clarity Specialist: Overall readability and structure

#### Benefits of Split-Role Approach
- **Comprehensive Analysis**: Surfaces insights that single-agent approaches might miss
- **Cost-Effective Intelligence**: Maximizes capabilities without requiring expensive models
- **Parallel Processing**: Multiple perspectives analyzed simultaneously
- **Enhanced Problem-Solving**: Combines diverse expertise for robust solutions

## Performance & Best Practices

### Key Benefits
- **Context Preservation**: Each subagent operates in its own context, preventing pollution of the main conversation
- **Specialized Expertise**: Fine-tuned with detailed instructions for specific domains
- **Reusability**: Once created, can be used across different projects and shared with teams
- **Flexible Permissions**: Different tool access levels for security and focus
- **Context efficiency**: Agents preserve main context, enabling longer overall sessions
- **Parallel execution**: Multiple tasks completed simultaneously
- **Pattern recognition**: Agents can identify and extend patterns creatively
- **Scalable personalization**: Mass customization without linear resource scaling

### Performance Metrics & Optimization

#### Key Metrics to Track
1. **Token Metrics**: Usage patterns, cumulative costs, efficiency ratios
2. **Speed Metrics**: Response time, processing efficiency, parallel speedup
3. **Quality Metrics**: Output accuracy, relevance score, error rates
4. **User Satisfaction**: Task success rate, rework frequency, subjective quality

#### Agent Weight Classifications

Agents are categorized by token usage to optimize performance and cost:

| Weight Class | Token Range | Use Cases | Recommended Model |
|--------------|-------------|-----------|-------------------|
| **Lightweight** | <3,000 tokens | Simple, frequent tasks like file operations, basic searches | Haiku |
| **Medium-weight** | 10,000-15,000 tokens | Balanced complexity with moderate reasoning | Sonnet |
| **Heavy** | 25,000+ tokens | Complex analysis, deep reasoning, sophisticated problem-solving | Opus |

**Strategic Model-Agent Pairing:**
- **Haiku + Lightweight Agents**: Maximize speed for simple operations
- **Sonnet + Medium Agents**: Balance capability with efficiency
- **Opus + Heavy Agents**: Leverage maximum intelligence for complex tasks

#### Trade-offs
- **Latency**: Subagents start with clean slate and may add latency while gathering required context
- **Setup overhead**: Initial configuration requires time investment
- **Token initialization**: Each agent invocation has upfront token cost
- **Context window limits**: Results consume space in main agent's context
- **Coordination complexity**: Managing multiple parallel agents requires careful orchestration

#### Optimization Strategies
1. **Agent Selection**: Choose lightweight agents for simple tasks, reserve complex agents for high-value operations
2. **Parallel Processing**: Batch related tasks for concurrent execution, balance parallelism with context constraints
3. **Model Optimization**: Match model capabilities to agent requirements, experiment with unconventional pairings
4. **Resource Management**: Monitor tool access, prevent context pollution, implement smart routing

### Best Practices & Engineering

#### Design Principles
- **Start with Claude-generated agents**: Generate initial subagent with Claude, then customize
- **Design focused subagents**: Create subagents with single, clear responsibilities
- **Write detailed prompts**: Include specific instructions, examples, and constraints
- **Limit tool access**: Only grant necessary tools for security and focus
- **Consider personality**: Match agent personality to function for enhanced collaboration

#### Lightweight Architecture Principles
- **Keep agents under 3,000 tokens** for maximum composability and efficiency
- **Single-purpose focus** with clear, specific responsibilities
- **Proactive activation** by including "use PROACTIVELY" in descriptions
- **Clear, unambiguous descriptions** that enable reliable auto-activation

#### Humanizing Agents

Transform mechanical interactions into natural, personalized collaborations by:
- **Matching personality to function**: Align each agent's personality with their specialized role
- **Using expressive elements**: Implement text-faces and nicknames for distinct personalities
- **Balancing intensity**: Adjust personality expression based on professional context

**Text-Face Personality System:**

A systematic approach to agent personalities organized by development roles:

| Role Category                     | Personality Traits                           | Text-Face Examples             | Focus Areas                               |
|-----------------------------------|----------------------------------------------|--------------------------------|-------------------------------------------|
| **Debugging & Testing**           | Playful, aggressive, skeptical               | (ง'̀-'́)ง, ಠ_ಠ, (╯°□°)╯        | Finding bugs, breaking things, edge cases |
| **Code Review & Quality**         | Laid-back, detail-oriented, security-focused | ( ͡° ͜ʖ ͡°), (▀̿Ĺ̯▀̿ ̿), ʕ•ᴥ•ʔ | Architecture, security, best practices    |
| **Performance & Optimization**    | High-energy, efficiency-driven               | ⚡(ﾉ◕ヮ◕)ﾉ⚡, (⌐■_■), ༼ つ ◕_◕ ༽つ  | Speed, efficiency, resource usage         |
| **Development & Refactoring**     | Gentle, friendly, focused                    | (◕‿◕), (´･ω･`), ♪(´▽｀)         | Code improvement, restructuring           |
| **Documentation & Communication** | Loving, sweet, intense                       | (♥‿♥), ✿◕ ‿ ◕✿, (づ｡◕‿‿◕｡)づ     | Clarity, accessibility, user guidance     |
| **Operations & Management**       | Cool, protective, observant                  | (⌐■_■), ಠ╭╮ಠ, (╯︵╰,)           | System stability, monitoring, oversight   |

**Implementation Guidelines:**
1. **Start Conservative**: Begin with subtle personalities and increase based on team reception
2. **Context Awareness**: Match intensity to professional environment
3. **Functional Alignment**: Ensure personality enhances rather than distracts from primary purpose
4. **Cultural Sensitivity**: Consider team dynamics and preferences
5. **Iterative Refinement**: Adjust based on user engagement and feedback

**Benefits of Personality-Driven Agents:**
- Transforms solo coding into team-like experience
- Increases engagement and enjoyment in technical tasks
- Creates memorable interactions that improve workflow adoption
- Reduces cognitive load through emotional associations

#### Operational Best Practices
- **Version control**: Check project subagents into version control for team collaboration
- **Make descriptions action-oriented**: Write specific, actionable description fields
- **Test thoroughly**: Verify subagent behavior before deploying to team
- **Community validation**: Share agents for broader testing and feedback
- **Iterative improvement**: Continuously refine based on real-world usage patterns

#### Common Engineering Pitfalls
- **Over-complexity**: Avoid excessive initialization costs or complex multi-step processes
- **Rigid Model Assumptions**: Test unconventional model/agent combinations
- **Heavyweight Dependencies**: Prevent single agents from becoming workflow bottlenecks
- **Poor Activation Patterns**: Ensure descriptions are specific enough for reliable invocation

#### Advanced Engineering Patterns

**Always Be Experimenting (A.B.E.) Methodology:**
- **Challenge Assumptions**: Question conventional wisdom about model-task pairings
- **Cross-Model Experimentation**: Test unexpected combinations (e.g., Haiku for complex reasoning)
- **Systematic Benchmarking**: Measure performance across different configurations
- **Community Sharing**: Contribute discoveries to collective knowledge base
- **Iterative Learning**: Continuously refine based on empirical results

**Technical Implementation Patterns:**
- **No CLAUDE.md Inheritance**: Avoid inheriting default behaviors that may conflict with specialized roles
- **Nickname Systems**: Implement short, memorable names for quick invocation (e.g., "debugger" → "dbg")
- **Visual Differentiation**: Use clear visual cues (colors, icons, text-faces) for different agent types
- **Automatic Delegation**: Use task descriptions to route work appropriately
- **Domain Specialization**: Create agents with deep expertise in specific areas
- **Portable Design**: Build agents that work across multiple projects

**Engineering Evolution Path:**
1. **Prompt Engineering**: Basic interaction optimization
2. **Context Engineering**: Managing conversation state and memory
3. **Agent Engineering**: Creating reusable, composable AI systems

### Advanced Debugging & Quality Patterns

#### Systematic Testing Approach
1. **Isolation Testing**: Test each agent independently before integration
2. **Edge Case Validation**: Explicitly test boundary conditions and error scenarios
3. **Performance Benchmarking**: Measure response time, token usage, and accuracy
4. **Integration Testing**: Verify agent interactions in composed workflows

#### Quality Assurance Strategies
- **Behavioral Testing**: Validate agent responses against expected outcomes
- **Regression Testing**: Ensure changes don't break existing functionality
- **Load Testing**: Verify performance under high-frequency usage
- **Error Recovery**: Test agent behavior with malformed inputs or missing context

#### Debugging Techniques
1. **Verbose Logging**: Enable detailed output for troubleshooting
2. **Context Inspection**: Examine agent context windows for issues
3. **Tool Usage Analysis**: Monitor which tools agents use and how
4. **Response Validation**: Implement automated checks for agent outputs

#### Common Issues and Solutions
| Issue | Symptoms | Solution |
|-------|----------|----------|
| **Context Loss** | Agent forgets previous information | Ensure proper context preservation in prompts |
| **Tool Misuse** | Agent uses wrong tools | Refine tool descriptions and constraints |
| **Over-delegation** | Too many sub-tasks created | Add explicit limits in system prompts |
| **Token Overflow** | Responses cut off | Implement chunking strategies |

### Context Management Best Practices

- **Preserve Naming Conventions**: Maintain project architecture and patterns
- **Utilize Existing Functions**: Leverage established utility functions
- **Minimize Context Pollution**: Keep sub-agent contexts focused and isolated
- **Strategic Resource Allocation**: Balance token efficiency with parallel processing benefits

## Management & Integration

### Using /agents Command (Recommended)

The `/agents` command provides a comprehensive interface for:

- Viewing all available subagents (built-in, user, and project)
- Creating new subagents with guided setup
- Editing existing custom subagents and their tool access
- Deleting custom subagents
- Managing tool permissions with complete tool listings
- Seeing which subagents are active when duplicates exist

### Direct File Management

You can also manage subagents by working directly with their files in the `.claude/agents/` or `~/.claude/agents/` directories.

### Integration Points

#### Related Features
- **Slash commands**: Other built-in Claude Code commands
- **Settings**: Configure Claude Code behavior
- **Hooks**: Automate workflows with event handlers
- **MCP Tools**: Subagents can access MCP tools from configured servers

#### Team Collaboration
- Share subagents through version control
- Standardize workflows across team members
- Maintain consistent code quality and practices

### Community Ecosystem Vision

**Building a Collaborative Agent Network:**

#### Shared Agent Libraries
- **Agent Marketplaces**: Curated collections of specialized agents for common tasks
- **Domain-Specific Collections**: Industry-focused agent libraries (e.g., web dev, data science, DevOps)
- **Quality Standards**: Community-driven validation and rating systems
- **Version Management**: Semantic versioning for agent configurations

#### Collaboration Patterns
1. **Agent Templates**: Shareable base configurations for common patterns
2. **Composition Recipes**: Documented workflows combining multiple agents
3. **Performance Benchmarks**: Community-contributed performance data
4. **Best Practice Guides**: Collective wisdom on agent design and usage

#### Ecosystem Benefits
- **Reduced Duplication**: Leverage existing agent configurations
- **Collective Intelligence**: Learn from community discoveries
- **Rapid Innovation**: Build on proven agent patterns
- **Quality Improvement**: Continuous refinement through shared usage

#### Contributing to the Ecosystem
1. **Document Your Agents**: Clear descriptions and usage examples
2. **Share Performance Data**: Contribute benchmarking results
3. **Report Edge Cases**: Help improve agent robustness
4. **Propose Standards**: Participate in community conventions

### Dynamic Selection

Claude Code intelligently selects subagents based on context and task requirements.

## Summary

Subagents represent a powerful way to extend Claude Code's capabilities through specialized, reusable AI assistants. They provide context isolation, task-specific expertise, and flexible tool management while maintaining the efficiency and focus of the main conversation. The combination of automatic delegation and explicit invocation makes them suitable for both proactive assistance and directed task execution.

The agent-first philosophy enables mass customization, parallel processing, and creative pattern extension, transforming how we approach complex software engineering tasks. Through careful design, optimization, and humanization, subagents become valuable collaborative partners in the development process.
