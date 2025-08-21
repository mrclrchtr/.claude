---
description: Transform input files into detailed IMPLEMENTATION_PLAN.md
argument-hint: [file1.md file2.md ...]
allowed-tools: Bash(eza:*), Bash(find:*)
---

# Create Implementation Plan from Input Files

## Context

- Current project structure: !`eza . --tree --all --git-ignore --ignore-glob=".idea|.claude|bruno|.yarn"`
- Existing architecture docs: !`find ./docs/architecture`

## Input Files

Space-separated list of files to analyze:
```
$ARGUMENTS
```

## Task

Transform the specified input files into a comprehensive @docs/IMPLEMENTATION_PLAN.md:

### Analysis Process:
1. **Repository Context Scan**: First use a sub agent to understand the project structure, technology stack, and existing architecture from the context above
2. **File Analysis**: Analyze with a sub agent each specified input file for requirements, constraints, and technical details
3. **Clarifying Questions**: Ask targeted questions to resolve:
   - Ambiguous technical choices where multiple valid approaches exist
   - Missing constraints (technology restrictions, performance requirements)
   - Integration unknowns (external systems, APIs, dependencies)  
   - Unclear success criteria and acceptance conditions
4. **Implementation Plan Creation**: Only after questions are answered, create the final structured plan

**CRITICAL WORKFLOW**: 
- MUST complete repository scan and file analysis BEFORE asking questions
- Questions should be specific to discovered gaps and ambiguities from the analysis
- Do NOT create implementation plan until ALL clarifying questions are answered
