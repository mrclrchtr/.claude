---
description: Update CLAUDE.md with important learnings from current coding session
allowed-tools: Bash(fd:*), Bash(git:*), Bash(rg:*), Bash(eza:*)
argument-hint: [path/to/CLAUDE.md to update]
---

# Update CLAUDE.md with Session Learnings

## Context

- Target CLAUDE.md: $ARGUMENTS (if specified)
- All CLAUDE.md files: !`fd -L CLAUDE.md --type f --exclude .idea --exclude .claude`
- All documentation: !`git ls-files --cached --others --exclude-standard '*.md' | rg -v '\.idea' | rg -v '\.claude' | rg -v '\.yarn' | rg -v 'bruno' | rg -v 'CLAUDE\.md'`
- Project structure: !`eza . --tree --all --git-ignore --follow-symlinks --ignore-glob=".idea|.claude|bruno|.yarn|node_modules"`

## Target Detection

If $ARGUMENTS is provided, use that path. Otherwise, find the best CLAUDE.md:

1. **Working directory**: The directory where the most coding happened in this session
2. **Parent directories**: Walk up to find nearest CLAUDE.md
3. **Project root**: Git root CLAUDE.md
4. **STOP** otherwise and ask user to specify a path

## Task

Analyze the current coding session and update the target CLAUDE.md with relevant learnings.

### Session Analysis

1. **Recent Changes Analysis**
   - Identify new patterns, tools, or workflows discovered
   - Note any debugging techniques or solutions found
   - Capture new dependencies or configuration changes

2. **Learning Extraction**
   - New commands that proved useful
   - Testing approaches that worked
   - Development workflow improvements
   - Architecture insights gained
   - Error resolution patterns
   - Tool configuration discoveries
   - Explicit corrective actions advised by the user

3. **Pattern Recognition**
   - Repeated actions that could be systematized
   - Common debugging steps
   - Frequently used command combinations
   - New best practices established

### Update Strategy

Focus on these high-value additions:

1. **Commands Section**
   - Add newly discovered useful commands
   - Update existing commands with better options
   - Include commands that solved specific problems

2. **Development Guidelines**
   - New coding patterns established
   - Testing strategies that proved effective
   - Architecture decisions made

3. **Troubleshooting Section**
   - Error patterns encountered and solutions
   - Debugging techniques that worked
   - Common gotchas discovered

4. **Project-Specific Insights**
   - Domain knowledge gained
   - Technology-specific learnings
   - Workflow optimizations

### Content Integration

- **Preserve existing structure** and don't duplicate content
- **Merge related information** rather than creating new sections
- **Use concrete examples** from the actual session
- **Focus on actionable insights** over general advice
- **Maintain conciseness** - add value without bloat

## Expected Output

**Updated CLAUDE.md** with:

1. **Enhanced Commands** - New useful commands discovered
2. **Improved Guidelines** - Patterns and practices learned
3. **Troubleshooting Updates** - Solutions to problems encountered
4. **Session-Specific Insights** - Key learnings from this work

**Update Report**:
- Number of new commands added
- Guidelines enhanced or added
- Troubleshooting entries updated
- Key insights captured
- Word count change
- Validation that existing workflows remain intact

The updated CLAUDE.md should be immediately more useful for future sessions, incorporating the practical knowledge gained from real development work.
