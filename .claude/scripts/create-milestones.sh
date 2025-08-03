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

## Active Milestones

## Milestone Status Legend

- [ ] -> Not started
- [WIP] -> In progress
- [DONE] -> Completed
- [BLOCKED] -> Blocked/Waiting
- [CANCELLED] -> Cancelled

EOF
    echo "Created $MILESTONE_MANAGER"
fi

echo "Milestone structure created successfully:"
echo "- $MILESTONES_DIR"
echo "- $MILESTONE_MANAGER"