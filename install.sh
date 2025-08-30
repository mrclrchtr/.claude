#!/bin/bash

# Claude Code Customization Framework Installer
set -e

# Configuration
readonly SSH_URL="git@github.com:mrclrchtr/.claude.git"
readonly HTTPS_URL="https://github.com/mrclrchtr/.claude.git"
readonly PROJECT_DIR=".claude"

# Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

# Utility functions
log() {
    local level="$1" msg="$2"
    case $level in
        SUCCESS) echo -e "${GREEN}✓ ${msg}${NC}" ;;
        ERROR) echo -e "${RED}✗ ${msg}${NC}" ;;
        WARN) echo -e "${YELLOW}⚠ ${msg}${NC}" ;;
        INFO) echo -e "${BLUE}ℹ ${msg}${NC}" ;;
    esac
}

die() { log ERROR "$1"; exit 1; }

confirm() { 
    read -p "$1 (y/N): " choice
    [[ ${choice:-N} =~ ^[Yy]$ ]]
}

# Clone with SSH/HTTPS fallback
clone_repo() {
    local target="$1"
    local temp_mode="${2:-false}"
    
    if [[ "$temp_mode" == "true" ]]; then
        log INFO "Cloning to $target..."
    else
        [[ -d "$target" ]] && die "Directory '$target' already exists. Remove it first."
        log INFO "Cloning to $target..."
    fi
    
    # Try SSH first
    if git clone "$SSH_URL" "$target" --quiet 2>/dev/null; then
        log SUCCESS "Clone successful"
        return 0
    fi
    
    # Fallback to HTTPS
    log WARN "SSH failed, trying HTTPS..."
    if git clone "$HTTPS_URL" "$target" --quiet 2>/dev/null; then
        log SUCCESS "Clone successful via HTTPS"
        return 0
    fi
    
    die "Clone failed with both SSH and HTTPS"
}

# Setup framework directories and run initialization
setup_framework() {
    local base_dir="$1"
    log INFO "Setting up directories..."
    
    # Run milestone structure creation if available
    local claude_dir="${base_dir}/$PROJECT_DIR"
    if [[ -f "$claude_dir/scripts/create-milestone-structure.sh" ]]; then
        (cd "$base_dir" && bash "$claude_dir/scripts/create-milestone-structure.sh" 2>/dev/null) || true
    fi
    
    log SUCCESS "Directories setup complete"
}

# Installation methods
install_submodule() {
    log INFO "Installing as submodule..."
    
    # Check git repo has commits
    if ! git rev-list --count HEAD >/dev/null 2>&1; then
        die "Repository has no commits. Please make an initial commit first"
    fi
    
    # Check for uncommitted changes
    if [[ -n "$(git status --porcelain)" ]]; then
        log WARN "Warning: You have uncommitted changes."
        confirm "Continue with submodule installation? (recommended: commit changes first)" || die "Installation cancelled"
    fi
    
    # Check if submodule already exists
    if [[ -f .gitmodules ]] && git config --file .gitmodules --get-regexp path | grep -q "$PROJECT_DIR"; then
        if confirm "Submodule exists. Update it?"; then
            git submodule update --remote "$PROJECT_DIR" || die "Submodule update failed"
            log SUCCESS "Submodule updated"
            return 0
        else
            log WARN "Skipping submodule installation"
            return 0
        fi
    fi
    
    [[ -d "$PROJECT_DIR" ]] && die "Directory '$PROJECT_DIR' already exists"
    
    # Add submodule
    if git ls-remote "$SSH_URL" HEAD >/dev/null 2>&1; then
        git submodule add --quiet "$SSH_URL" "$PROJECT_DIR" || die "Submodule add failed"
    else
        git submodule add --quiet "$HTTPS_URL" "$PROJECT_DIR" || die "Submodule add failed"
    fi
    
    git submodule update --init --recursive --quiet || die "Submodule update failed"
    setup_framework "."
    log SUCCESS "Installation complete: submodule"
    echo "Update: git submodule update --remote $PROJECT_DIR"
}

install_direct() {
    clone_repo "$PROJECT_DIR"
    setup_framework "."
    log SUCCESS "Installation complete: direct"
    echo "Update: cd $PROJECT_DIR && git pull"
}

install_copy() {
    local temp_dir="/tmp/.claude-temp-$$"
    clone_repo "$temp_dir" "true"
    
    # Backup existing directory if present
    if [[ -d "$PROJECT_DIR" ]]; then
        log WARN "Backing up existing $PROJECT_DIR"
        mv "$PROJECT_DIR" "$PROJECT_DIR.backup"
    fi
    
    # Copy framework directories
    mkdir -p "$PROJECT_DIR"
    local framework_dirs=(agents commands docs scripts templates hooks)
    for dir in "${framework_dirs[@]}"; do
        [[ -d "$temp_dir/$dir" ]] && cp -r "$temp_dir/$dir" "$PROJECT_DIR/"
    done
    
    rm -rf "$temp_dir"
    log SUCCESS "Framework copied"
    log WARN "Manual updates required for copy installations"
    setup_framework "."
    log SUCCESS "Installation complete: copy"
    echo "Update: Manual - reinstall framework to get updates"
}

# Main menu
show_menu() {
    echo "Current: $(pwd)"
    echo
    
    if git rev-parse --git-dir >/dev/null 2>&1; then
        # Git repository
        echo "Installation methods:"
        echo "1) Submodule (recommended)"
        echo "   Adds as git submodule, updatable"
        echo
        echo "2) Copy framework"
        echo "   Copies files only, no git tracking"
        echo
        
        read -p "Choose method (1-2): " choice
        case $choice in
            1) install_submodule ;;
            2) install_copy ;;
            *) die "Invalid choice" ;;
        esac
    else
        # Not a git repository
        echo "Installation methods:"
        echo "1) Direct clone (recommended)"
        echo "   Clones to .claude/ with git updates"
        echo
        echo "2) Copy framework" 
        echo "   Files only, no git tracking"
        echo
        
        read -p "Choose method (1-2): " choice
        case $choice in
            1) install_direct ;;
            2) install_copy ;;
            *) die "Invalid choice" ;;
        esac
    fi
}

show_help() {
    cat << EOF
Claude Code Customization Framework Installer

Usage: bash install.sh [OPTIONS]

Options:
  -h, --help     Show this help

Installation Methods:
  • Submodule: Git submodule (for git repos) - updatable
  • Direct: Clone to .claude/ directory - updatable  
  • Copy: Framework files only - manual updates

Examples:
  curl -fsSL https://raw.githubusercontent.com/mrclrchtr/.claude/main/install.sh | bash
  bash install.sh

More: https://github.com/mrclrchtr/.claude
EOF
}

# Main execution
main() {
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help) show_help; exit 0 ;;
            -*) die "Unknown option: $1" ;;
            *) break ;;
        esac
    done
    
    echo -e "${BLUE}=======================================${NC}"
    echo -e "${BLUE} Claude Code Customization Framework ${NC}"
    echo -e "${BLUE}=======================================${NC}"
    echo
    
    # Prerequisites
    log INFO "Checking prerequisites..."
    command -v git >/dev/null || die "Git not installed"
    [[ -w . ]] || die "Cannot write to current directory"
    log SUCCESS "Prerequisites OK"
    
    show_menu
    echo
    log SUCCESS "Installation complete!"
}

main "$@"