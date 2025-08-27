---
description: Create a new CLAUDE.md file following Anthropic's memory best practices
allowed-tools: Bash(eza:*), Bash(ls:*), Bash(find:*), Bash(cat:*), Bash(git:*), Bash(grep:*)
argument-hint: [target/directory/path for CLAUDE.md]
---

# Create CLAUDE.md

## Context
- Target directory: $ARGUMENTS
- All CLAUDE.md files: !`find . -name "CLAUDE.md" -not -path "./.idea/*" -not -path "./.claude/*"`
- All documentation: !`git ls-files --cached --others --exclude-standard '*.md' | grep -v '\.idea' | grep -v '\.claude' | grep -v '\.yarn' | grep -v bruno | grep -v CLAUDE.md`
- Project structure: !`eza . --tree --all --git-ignore --ignore-glob=".idea|.claude|bruno|.yarn|node_modules"`

## Task

Create a comprehensive CLAUDE.md file using best practices from: @docs/claude-md.md

### CLAUDE.md Requirements

1. **Project Overview** (150 words max)
   - Tech stack identification
   - Architecture summary
   - Key domain concepts

2. **Essential Commands**
   - Development workflow
   - Testing procedures
   - Build/deployment commands
   - Validation/linting

3. **Project Structure**
   - Key directories
   - Important files
   - Generated/protected files

4. **Development Guidelines**
   - Code patterns
   - Best practices
   - Do not touch lists

### Content Strategy

- **Analyze existing files** to understand:
  - Primary programming language(s)
  - Framework/libraries in use
  - Testing setup
  - Build tools
  - Documentation patterns

- **Extract actionable patterns** from:
  - Existing code structure
  - Configuration files
  - Development scripts
  - Documentation style

- **Define expert persona** based on:
  - Technology stack
  - Domain/industry
  - Code complexity level

### Template Structure

```markdown
# Project: [Detected Name]
**You are an expert [language] developer specializing in [domain].**

## Tech Stack
[Auto-detected from package files and code]

## Commands
[Extracted from package.json scripts, Makefile, etc.]

## Project Structure
[Generated from actual directory structure]

## Cornerstone Files
[Key files that define patterns - actual paths]

## Critical Rules
[Technology-specific best practices]

## Code Patterns
[Extracted from existing code examples]

## Do Not Touch
[Auto-generated files, configs, etc.]

## Self-Correction Loop
[Validation commands for this project]
```

## Analysis Approach

Before creating CLAUDE.md:

1. **Technology Detection**
   - Identify primary language from file extensions
   - Detect frameworks from package files
   - Find testing frameworks and tools
   - Locate build systems and configs

2. **Pattern Extraction**
   - Analyze existing code for conventions
   - Extract import patterns
   - Identify error handling approaches
   - Find testing patterns

3. **Command Discovery**
   - Parse package.json scripts
   - Check for Makefile, build scripts
   - Find development shortcuts
   - Identify validation commands

4. **Structure Analysis**
   - Map key directories
   - Identify cornerstone files
   - Find auto-generated content
   - Locate configuration files

## Expected Output

**New CLAUDE.md file** containing:

1. **Expert Persona** - Technology-specific expertise definition
2. **Tech Stack** - Actual technologies detected in project
3. **Commands** - Working commands extracted from project files
4. **Structure Map** - Real directory structure with descriptions
5. **Cornerstone Files** - Actual files that define patterns (with @ references)
6. **Critical Rules** - Technology and domain-specific guidelines
7. **Code Patterns** - Examples from existing codebase
8. **Protected Files** - Auto-generated and external files
9. **Validation Loop** - Commands to run after changes

**Creation Report**:
- Technology stack detected
- Key patterns identified
- Commands extracted
- Cornerstone files selected
- Total word count
- Canary verification included

The CLAUDE.md should be immediately usable as a project constitution, providing Claude with expert context and actionable guidance specific to this codebase.
