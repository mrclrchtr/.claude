#!/bin/bash

{ # this ensures the entire script is downloaded #

# Claude Code Customization Framework Installer (Refactored)
set -e

# Configuration
readonly SCRIPT_VERSION="2.0"
readonly SSH_URL="git@github.com:mrclrchtr/.claude.git"
readonly HTTPS_URL="https://github.com/mrclrchtr/.claude.git"
readonly PROJECT_DIR=".claude"
readonly FRAMEWORK_DIRS=(agents commands docs scripts templates hooks)
# Colors (compatible with older bash versions)
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

# Exit codes
readonly EXIT_SUCCESS=0
readonly EXIT_ERROR=1
readonly EXIT_MISSING_DEP=2
readonly EXIT_PERMISSION=3
readonly EXIT_NETWORK=4
readonly EXIT_GIT=5
readonly EXIT_CANCELLED=6

# Globals
REPO_URL=""
VERBOSE=false

# Utility functions
print_msg() {
    local level="$1" msg="$2"
    local color nc prefix
    case $level in
        GREEN) color="$GREEN"; prefix="✓" ;;
        RED) color="$RED"; prefix="✗" ;;
        YELLOW) color="$YELLOW"; prefix="⚠" ;;
        BLUE) color="$BLUE"; prefix="ℹ" ;;
        *) color=""; prefix="•" ;;
    esac
    nc="$NC"
    echo -e "${color}${prefix} ${msg}${nc}"
}

die() { print_msg RED "$1"; exit "${2:-$EXIT_ERROR}"; }

verbose_msg() { [[ "$VERBOSE" == "true" ]] && print_msg BLUE "DEBUG: $1"; }

confirm() { 
    local prompt="$1" default="${2:-N}"
    read -p "$prompt (y/N): " choice
    [[ ${choice:-$default} =~ ^[Yy]$ ]]
}

# Git operations
test_ssh_github() {
    print_msg BLUE "Testing SSH access..." >&2
    git ls-remote "$SSH_URL" HEAD >/dev/null 2>&1
}

select_repo_url() {
    if test_ssh_github; then
        print_msg GREEN "Using SSH for cloning" >&2
        echo "$SSH_URL"
    else
        print_msg YELLOW "SSH failed, using HTTPS" >&2
        echo "$HTTPS_URL"
    fi
}

is_git_repo() { git rev-parse --git-dir >/dev/null 2>&1; }

is_claude_repo() {
    [[ -d .git ]] || return 1
    local origin_url
    origin_url=$(git remote get-url origin 2>/dev/null || echo "")
    [[ "$origin_url" == "$SSH_URL" || "$origin_url" == "$HTTPS_URL" ]]
}

# Installation core
check_prerequisites() {
    print_msg BLUE "Checking prerequisites..."
    command -v git >/dev/null || die "Git not installed" "$EXIT_MISSING_DEP"
    [[ -w . ]] || die "Cannot write to current directory" "$EXIT_PERMISSION"
    REPO_URL=$(select_repo_url)
    print_msg GREEN "Prerequisites OK"
}

setup_directories() {
    local base_dir="$1"
    print_msg BLUE "Setting up directories..."
    
    [[ "$base_dir" == "." ]] && mkdir -p sessions
    
    local claude_dir="${base_dir%/.}/$PROJECT_DIR"
    [[ "$base_dir" == "." ]] && claude_dir="$PROJECT_DIR"
    
    if [[ -f "$claude_dir/scripts/create-milestone-structure.sh" ]]; then
        (cd "${base_dir%/.}" && bash "$claude_dir/scripts/create-milestone-structure.sh" 2>/dev/null) || true
    fi
    
    print_msg GREEN "Directories setup complete"
}

clone_with_retry() {
    local url="$1" target="$2"
    local error_output
    
    verbose_msg "Attempting clone: $url -> $target"
    
    if [[ "$VERBOSE" == "true" ]]; then
        error_output=$(git clone "$url" "$target" 2>&1)
        local exit_code=$?
    else
        error_output=$(git clone "$url" "$target" --quiet 2>&1)
        local exit_code=$?
    fi
    
    if [[ $exit_code -eq 0 ]]; then
        return 0
    fi
    
    verbose_msg "Clone failed with: $error_output"
    
    # Check for specific error patterns that indicate process substitution issues
    if [[ "$error_output" == *"remote username contains invalid characters"* ]] || 
       [[ "$error_output" == *"SSH"* && "$url" == git@* ]]; then
        verbose_msg "Detected SSH/process substitution issue, will retry with HTTPS"
        echo "$error_output"
        return 1
    fi
    
    # For other errors, output and fail immediately
    echo "$error_output"
    return $exit_code
}

clone_or_update() {
    local target="$1" update_prompt="$2"
    
    if [[ -d "$target" ]]; then
        if [[ -d "$target/.git" ]]; then
            if [[ "$update_prompt" == "true" ]] && confirm "Update existing repository?"; then
                (cd "$target" && git pull origin main) || die "Update failed" "$EXIT_GIT"
            fi
            return 0
        else
            die "Directory exists but isn't a git repo: $target"
        fi
    fi
    
    print_msg BLUE "Cloning to $target..."
    
    # First attempt with selected URL
    if clone_with_retry "$REPO_URL" "$target"; then
        print_msg GREEN "Clone successful"
        return 0
    fi
    
    # If SSH failed and we have HTTPS fallback, try it
    if [[ "$REPO_URL" == "$SSH_URL" ]]; then
        print_msg YELLOW "SSH clone failed, retrying with HTTPS..."
        if clone_with_retry "$HTTPS_URL" "$target"; then
            print_msg GREEN "Clone successful via HTTPS"
            return 0
        fi
    fi
    
    die "Clone failed after retry" "$EXIT_NETWORK"
}

copy_framework_dirs() {
    local source="$1" target="$2"
    
    [[ -d "$target" ]] && { print_msg YELLOW "Backing up existing $target"; mv "$target" "$target.backup"; }
    
    mkdir -p "$target"
    for dir in "${FRAMEWORK_DIRS[@]}"; do
        [[ -d "$source/$dir" ]] && cp -r "$source/$dir" "$target/"
    done
    
    print_msg GREEN "Framework copied"
    print_msg YELLOW "Manual updates required for copy installations"
}

setup_sparse_checkout() {
    local claude_dir="$1"
    
    print_msg BLUE "Setting up sparse checkout..."
    
    cat > "$claude_dir/.gitignore" << 'EOF'
/*
.gitignore
!/agents/
!/commands/
!/docs/
!/scripts/
!/templates/
!/hooks/
.claude-sessions/
temp/
logs/
*.log
*.tmp
!/agents/**
!/commands/**
!/docs/**
!/scripts/**
!/templates/**
!/hooks/**
EOF
    
    git config core.sparseCheckout true
    git config core.sparseCheckoutCone false
    
    mkdir -p .git/info
    printf '%s/\n' "${FRAMEWORK_DIRS[@]}" > .git/info/sparse-checkout
}

manage_existing_files() {
    [[ $(git status --porcelain | wc -l) -eq 0 ]] && return 0
    
    local backup_dir="claude-backup-$(date +%Y%m%d-%H%M%S)"
    print_msg YELLOW "Backing up existing files to $backup_dir/"
    mkdir -p "$backup_dir"
    
    for dir in "${FRAMEWORK_DIRS[@]}"; do
        [[ -d "$dir" && ! -L "$dir" ]] && mv "$dir" "$backup_dir/" 2>/dev/null || true
    done
    
    [[ -z $(ls -A "$backup_dir" 2>/dev/null) ]] && rmdir "$backup_dir"
}

install_framework() {
    local method="$1" target="${2:-.}"
    
    case $method in
        submodule)
            print_msg BLUE "Installing as submodule..."
            if git config --file .gitmodules --get-regexp path | grep -q "$PROJECT_DIR"; then
                confirm "Submodule exists. Update?" && git submodule update --remote "$PROJECT_DIR"
                return 0
            fi
            git submodule add "$REPO_URL" "$PROJECT_DIR" --quiet || die "Submodule add failed" "$EXIT_GIT"
            git submodule update --init --recursive --quiet || die "Submodule update failed" "$EXIT_GIT"
            setup_directories "."
            ;;
            
        direct)
            clone_or_update "$target" true
            setup_directories "$target"
            ;;
            
        copy)
            local temp_dir="/tmp/.claude-temp-$$"
            clone_or_update "$temp_dir" false
            copy_framework_dirs "$temp_dir" "$PROJECT_DIR"
            rm -rf "$temp_dir"
            setup_directories "."
            ;;
            
        global)
            local claude_dir="$HOME/.claude"
            print_msg BLUE "Installing globally..."
            
            mkdir -p "$claude_dir"
            [[ ! -w "$claude_dir" ]] && die "Cannot write to ~/.claude"
            
            cd "$claude_dir"
            
            if [[ -d .git ]]; then
                if git remote get-url claude-framework >/dev/null 2>&1; then
                    git fetch claude-framework --quiet
                    git pull claude-framework main --allow-unrelated-histories --quiet
                    return 0
                fi
            else
                git init --quiet
            fi
            
            setup_sparse_checkout "$claude_dir"
            git remote add claude-framework "$REPO_URL" 2>/dev/null || true
            git fetch claude-framework --quiet || die "Fetch failed" "$EXIT_NETWORK"
            
            manage_existing_files
            git merge claude-framework/main --allow-unrelated-histories --no-edit --quiet || 
                die "Merge failed" "$EXIT_GIT"
            ;;
            
        contributor)
            if is_claude_repo; then
                print_msg GREEN "Detected .claude repo, setting up symlinks..."
                setup_contributor_symlinks "$(pwd)"
                return 0
            fi
            
            echo "Clone location:"
            echo "1) Current directory (./.claude)"
            echo "2) Custom path"
            read -p "Choose (1-2): " choice
            
            case $choice in
                1) target="./.claude" ;;
                2) read -p "Enter path: " target; [[ -z "$target" ]] && die "No path specified" ;;
                *) die "Invalid choice" ;;
            esac
            
            clone_or_update "$target" true
            setup_contributor_symlinks "$(cd "$target" && pwd)"
            ;;
    esac
    
    print_msg GREEN "Installation complete: $method"
}

setup_contributor_symlinks() {
    local abs_source="$1"
    local claude_dir="$HOME/.claude"
    
    mkdir -p "$claude_dir"
    print_msg BLUE "Creating symlinks..."
    
    for dir in "${FRAMEWORK_DIRS[@]}"; do
        local source_path="$abs_source/$dir"
        local target_path="$claude_dir/$dir"
        
        if [[ -d "$source_path" ]]; then
            [[ -e "$target_path" ]] && rm -rf "$target_path"
            ln -s "$source_path" "$target_path"
            print_msg GREEN "Linked $dir"
        fi
    done
}

# Menu system
show_installation_menu() {
    local is_git_repo=false
    local in_claude_home=false
    
    is_git_repo && is_git_repo=true
    [[ "$(pwd)" == "$HOME/.claude" ]] && in_claude_home=true
    
    echo "Current: $(pwd)"
    echo
    
    if [[ "$in_claude_home" == "true" ]]; then
        confirm "Install in global ~/.claude directory?" || die "Installation cancelled" "$EXIT_CANCELLED"
    fi
    
    local -a options methods descriptions
    
    if [[ "$is_git_repo" == "true" ]]; then
        options=("Submodule (recommended)" "Copy framework" "Global install" "Contributor setup")
        methods=(submodule copy global contributor)
        descriptions=(
            "Adds as git submodule, updatable"
            "Copies files only, no git tracking"  
            "⚠️  Modifies ~/.claude globally"
            "For framework development"
        )
    else
        options=("Direct clone (recommended)" "Copy framework" "Global install" "Contributor setup")
        methods=(direct copy global contributor)
        descriptions=(
            "Full git repo with updates"
            "Files only, no git tracking"
            "⚠️  Modifies ~/.claude globally" 
            "For framework development"
        )
    fi
    
    echo "Installation methods:"
    for i in "${!options[@]}"; do
        printf "%d) %s\n   %s\n\n" $((i+1)) "${options[$i]}" "${descriptions[$i]}"
    done
    
    read -p "Choose method (1-${#options[@]}): " choice
    
    if [[ "$choice" -ge 1 && "$choice" -le "${#options[@]}" ]]; then
        local method="${methods[$((choice-1))]}"
        
        if [[ "$method" == "global" ]]; then
            confirm "⚠️  This modifies ~/.claude globally. Continue?" || 
                die "Installation cancelled" "$EXIT_CANCELLED"
        fi
        
        install_framework "$method"
        show_completion_info "$method"
    else
        die "Invalid choice"
    fi
}

show_completion_info() {
    local method="$1"
    echo
    print_msg GREEN "Installation complete!"
    echo "Method: $method"
    
    case $method in
        global)
            echo "Update: cd ~/.claude && git pull claude-framework main"
            echo "Status: cd ~/.claude && git status"
            ;;
        submodule)
            echo "Update: git submodule update --remote $PROJECT_DIR"
            ;;
        direct)
            echo "Update: cd $PROJECT_DIR && git pull"
            ;;
        contributor)
            echo "Development: Edit in cloned directory"
            echo "Contribute: git add . && git commit && git push"
            ;;
    esac
}

show_help() {
    cat << EOF
Claude Code Customization Framework Installer v$SCRIPT_VERSION

Usage: bash install.sh [OPTIONS]

Options:
  -h, --help     Show this help
  -v, --verbose  Enable verbose/debug output

Installation Methods:
  • Submodule: Git submodule (projects) - updatable
  • Copy: Framework files only - manual updates  
  • Global: ~/.claude modification - affects all projects
  • Contributor: Development setup with symlinks

Examples:
  curl -fsSL https://raw.githubusercontent.com/mrclrchtr/.claude/main/install.sh | bash
  wget -O- https://raw.githubusercontent.com/mrclrchtr/.claude/main/install.sh | bash
  bash install.sh -v  # with verbose output

More: https://github.com/mrclrchtr/.claude
EOF
}

# Main execution
main() {
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help) show_help; exit "$EXIT_SUCCESS" ;;
            -v|--verbose) VERBOSE=true; shift ;;
            -*) die "Unknown option: $1" ;;
            *) break ;;
        esac
    done
    
    echo -e "${BLUE}=======================================${NC}"
    echo -e "${BLUE} Claude Code Customization Framework ${NC}"
    echo -e "${BLUE}=======================================${NC}"
    echo
    
    check_prerequisites
    show_installation_menu
}

main "$@"

} # this ensures the entire script is downloaded #