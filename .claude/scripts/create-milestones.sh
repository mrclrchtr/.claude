#!/bin/bash

# Create milestone directory structure if it doesn't exist

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOCS_DIR="$BASE_DIR/docs"
MILESTONES_DIR="$DOCS_DIR/milestones"

# Create directories if they don't exist
mkdir -p "$MILESTONES_DIR"

# Create MILESTONE_MANAGER.md if it doesn't exist
MILESTONE_MANAGER="$DOCS_DIR/MILESTONE_MANAGER.md"
if [ ! -f "$MILESTONE_MANAGER" ]; then
    cat > "$MILESTONE_MANAGER" << 'EOF'
# Milestone Manager

## Overview
This document tracks all project milestones and their completion status.

## Active Milestones

### Phase 1 - MVP
_Milestones to be added here_

### Phase 2 - _Phase 2 Name_
_To be defined after Phase 1 completion_

## Milestone Dependencies
_Dependencies between milestones will be documented here_

## Progress Summary
- **Total Milestones**: 0
- **Completed**: 0
- **In Progress**: 0
- **Pending**: 0

## Notes
- Milestones are extracted from the [Implementation Plan](IMPLEMENTATION_PLAN.md)
- Each milestone follows the template in `.claude/templates/milestone-template.md`

EOF
    echo "Created $MILESTONE_MANAGER"
fi

echo "Milestone structure created successfully:"
echo "- $MILESTONES_DIR"
echo "- $MILESTONE_MANAGER"