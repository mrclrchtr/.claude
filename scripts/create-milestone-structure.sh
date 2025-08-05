#!/bin/bash

# Create milestone directory structure if it doesn't exist
# Usage: ./create-milestone-structure.sh [--help]
# Strict error handling
set -euo pipefail

# Show usage information
show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

Create milestone directory structure and initialize template files.

OPTIONS:
    -h, --help    Show this help message and exit

DESCRIPTION:
    This script creates the following structure:
    - docs/milestones/ directory
    - docs/MILESTONE_MANAGER.md (from template)
    - docs/IMPLEMENTATION_LOG.md (from template)
    
    Files are only created if they don't already exist.
    
REQUIREMENTS:
    - Must be run from within a git repository
    - Template files must exist in .claude/templates/

EXIT CODES:
    0    Success
    1    General error (missing templates, not in git repo, etc.)

EXAMPLES:
    $0              # Create milestone structure
    $0 --help       # Show this help
EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            echo "Use --help for usage information" >&2
            exit 1
            ;;
    esac
done

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Directory setup
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Validate we're in a git repository
if [[ ! -d "$BASE_DIR/.git" ]]; then
    log_error "Not in a git repository. Expected .git directory at $BASE_DIR/.git"
    exit 1
fi

readonly DOCS_DIR="$BASE_DIR/docs"
readonly MILESTONES_DIR="$DOCS_DIR/milestones"
readonly TEMPLATES_DIR="$BASE_DIR/.claude/templates"

# Template copying function with validation
copy_template() {
    local -r template_name="$1"
    local -r target_file="$2"
    local -r template_file="$TEMPLATES_DIR/$template_name"
    
    # Validate template exists
    if [[ ! -f "$template_file" ]]; then
        log_error "Template not found: $template_file"
        exit 1
    fi
    
    # Check if target already exists
    if [[ -f "$target_file" ]]; then
        log_warning "File already exists: $target_file (skipping)"
        return 0
    fi
    
    # Ensure target directory exists
    local -r target_dir="$(dirname "$target_file")"
    if ! mkdir -p "$target_dir"; then
        log_error "Failed to create target directory: $target_dir"
        exit 1
    fi
    
    # Copy template with validation
    if cp "$template_file" "$target_file"; then
        # Verify copy was successful
        if [[ -f "$target_file" ]] && [[ -s "$target_file" ]]; then
            log_success "Created $target_file from template"
        else
            log_error "Copy appeared successful but target file is empty or missing"
            exit 1
        fi
    else
        log_error "Failed to create $target_file from template"
        exit 1
    fi
}

# Validate templates directory exists
if [[ ! -d "$TEMPLATES_DIR" ]]; then
    log_error "Templates directory not found: $TEMPLATES_DIR"
    exit 1
fi

# Create directories if they don't exist
log_info "Creating milestone directory structure..."
if mkdir -p "$MILESTONES_DIR"; then
    log_success "Created directory: $MILESTONES_DIR"
else
    log_error "Failed to create directory: $MILESTONES_DIR"
    exit 1
fi

# Create files from templates
readonly MILESTONE_MANAGER_FILE="$DOCS_DIR/MILESTONE_MANAGER.md"
readonly IMPLEMENTATION_LOG_FILE="$DOCS_DIR/IMPLEMENTATION_LOG.md"

copy_template "milestone-manager-template.md" "$MILESTONE_MANAGER_FILE"
copy_template "implementation-log-template.md" "$IMPLEMENTATION_LOG_FILE"

log_success "Milestone structure setup completed successfully!"
log_info "Created structure:"
log_info "  • Directory: $MILESTONES_DIR"
log_info "  • Manager: $MILESTONE_MANAGER_FILE"
log_info "  • Log: $IMPLEMENTATION_LOG_FILE"