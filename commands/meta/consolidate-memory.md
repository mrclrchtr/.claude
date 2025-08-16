---
description: Consolidate and optimize all CLAUDE.md files across the project with intelligent deduplication and cross-referencing
allowed-tools: Bash(find:*), Bash(eza:*), Bash(ls:*), Bash(cat:*), Bash(grep:*)
argument-hint: [optional: specific focus area like 'backend' or 'frontend']
---

# Consolidate CLAUDE.md Files

## Context
- Focus area: $ARGUMENTS (if specified)
- All CLAUDE.md files: !`find . -name "CLAUDE.md" -not -path "./.idea/*" -not -path "./.claude/*"`
- All documentation: !`git ls-files --cached --others --exclude-standard '*.md' | grep -v -E '(\.idea|\.claude|bruno|\.yarn|CLAUDE\.md)'`
- Project structure: !`eza . --tree --all --git-ignore --ignore-glob=".idea|.claude|bruno|.yarn|node_modules"`

## Task

Perform comprehensive consolidation of all CLAUDE.md files using ultrathink analysis to create an optimal information architecture.

### Ultra-Analysis Framework

#### 1. Information Architecture Analysis
- **Scope Mapping**: Identify information that's project-wide vs. area-specific
- **Hierarchy Detection**: Find parent-child relationships between domains
- **Overlap Matrix**: Map content duplication across all CLAUDE.md files
- **Gap Analysis**: Identify missing connections and context
- **Reference Graph**: Map all cross-references and dependencies

#### 2. Content Intelligence
- **Deduplication Strategy**:
  - Common commands → Root CLAUDE.md with area-specific variations
  - Shared concepts → Central definition with area-specific applications
  - Duplicate guidelines → Consolidate with technology-specific notes
  
- **Compression Opportunities**:
  - Verbose explanations → Concise actionable statements
  - Redundant examples → Single authoritative examples with cross-refs
  - Historical information → Remove or archive in separate docs
  
- **Context Enhancement**:
  - Orphaned commands → Add purpose and when-to-use
  - Implicit knowledge → Make explicit with examples
  - Missing workflows → Connect commands into coherent sequences

#### 3. Optimal Placement Strategy

**Root CLAUDE.md** should contain:
- Project overview and architecture
- Cross-cutting commands (git, build, test coordination)
- Tool integrations (MCP, E2E setup)
- Inter-area workflows
- References to specialized CLAUDE.md files

**Area-specific CLAUDE.md** should contain:
- Technology-specific patterns and commands
- Domain-specific guidelines
- Local development workflows
- Area-specific troubleshooting

### Consolidation Process

#### Phase 1: Discovery & Analysis
1. **Content Inventory**
   - Extract all sections from each CLAUDE.md
   - Categorize by scope (project/area/tool/workflow)
   - Identify semantic duplicates and variations
   - Map references and dependencies

2. **Structural Analysis**
   - Analyze current section hierarchies
   - Identify missing organizational patterns
   - Find broken or outdated references
   - Assess the maintenance burden of the current structure

3. **Usage Pattern Detection**
   - Identify frequently referenced sections
   - Find dead or outdated content
   - Detect command sequences and workflows
   - Spot knowledge gaps causing confusion

#### Phase 2: Architecture Design
1. **Information Hierarchy**
   - Design optimal file structure
   - Define clear boundaries between files
   - Plan cross-reference strategy
   - Create navigation pathways

2. **Content Strategy**
   - Decide what stays, moves, merges, or gets removed
   - Plan compression without losing critical details
   - Design enhancement areas needing more context
   - Create consistency standards

#### Phase 3: Implementation
1. **Root CLAUDE.md Optimization**
   - Consolidate project-wide information
   - Create clear navigation to specialized docs
   - Establish consistent command patterns
   - Add missing high-level context

2. **Specialized File Updates**
   - Remove duplicated content now in root
   - Enhance area-specific content
   - Add proper cross-references
   - Improve local navigation

3. **Cross-Reference Integration**
   - Implement @-references to related files
   - Create bidirectional navigation
   - Add contextual links where helpful
   - Ensure reference accuracy

### Quality Criteria

#### Deduplication Success
- [ ] No identical commands across files
- [ ] Shared concepts defined once with clear references
- [ ] Common workflows centralized with area-specific variations noted

#### Compression Success
- [ ] Reduced total word count while maintaining completeness
- [ ] Eliminated verbose explanations in favor of actionable instructions
- [ ] Removed historical/outdated information

#### Context Enhancement Success
- [ ] All commands have clear purpose and usage context
- [ ] Missing workflows documented and connected
- [ ] Implicit knowledge made explicit

#### Architecture Success
- [ ] Clear information hierarchy with logical boundaries
- [ ] Effective cross-referencing between files
- [ ] Easy navigation from any starting point
- [ ] Minimal maintenance burden

### Expected Output

**Consolidated File Structure**:
1. **Enhanced Root CLAUDE.md** - Project constitution with navigation hub
2. **Optimized Area CLAUDE.md files** - Specialized knowledge without duplication
3. **Reference Map** - Documentation of all cross-references and their purposes

**Consolidation Report**:
- Files analyzed and their current roles
- Deduplication matrix (what was merged from where)
- Compression statistics (word count reductions by section)
- Enhancement areas (new context added)
- Reference architecture (navigation pathways created)
- Validation checklist (all workflows still accessible)
- Migration notes (what moved where and why)

**Quality Metrics**:
- Total word count: before → after
- Cross-references added/updated
- Sections merged or relocated
- New context areas added
- Broken references fixed
- Maintenance burden reduction score

The result should be a cohesive, navigable knowledge system that eliminates redundancy while enhancing discoverability and usability of project-specific information.
