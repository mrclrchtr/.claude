#!/bin/bash

# .claude Installation Script
# A comprehensive Claude Code customization framework installer
# Handles git repository detection and provides multiple installation methods

set -e  # Exit on any error

# Color definitions for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Repository information
REPO_URL="https://github.com/mrclrchtr/.claude.git"
REPO_NAME=".claude"

# Utility functions
print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  .claude Installation Script   ${NC}"
    echo -e "${BLUE}================================${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Check if we're inside a git repository
check_git_repo() {
    if git rev-parse --git-dir >/dev/null 2>&1; then
        return 0  # We are in a git repo
    else
        return 1  # We are not in a git repo
    fi
}

# Check prerequisites
check_prerequisites() {
    print_info "Checking prerequisites..."
    
    # Check if git is installed
    if ! command -v git >/dev/null 2>&1; then
        print_error "Git is not installed. Please install git first."
        exit 1
    fi
    
    # Check if we can write to current directory
    if [ ! -w "." ]; then
        print_error "Cannot write to current directory. Please check permissions."
        exit 1
    fi
    
    print_success "Prerequisites check passed"
}

# Get current directory name
get_current_dir_name() {
    basename "$(pwd)"
}

# Direct clone installation (for non-git directories)
install_direct_clone() {
    local target_dir="$1"
    
    print_info "Cloning .claude repository to $target_dir..."
    
    if [ -d "$target_dir" ]; then
        print_error "Directory '$target_dir' already exists."
        echo "Would you like to:"
        echo "1) Remove existing directory and reinstall"
        echo "2) Update existing installation (git pull)"
        echo "3) Cancel installation"
        read -p "Please choose (1-3): " choice
        
        case $choice in
            1)
                print_warning "Removing existing directory..."
                rm -rf "$target_dir"
                ;;
            2)
                print_info "Updating existing installation..."
                cd "$target_dir"
                git pull origin main
                print_success "Update completed"
                return 0
                ;;
            3)
                print_info "Installation cancelled"
                exit 0
                ;;
            *)
                print_error "Invalid choice. Installation cancelled."
                exit 1
                ;;
        esac
    fi
    
    git clone "$REPO_URL" "$target_dir"
    print_success "Repository cloned successfully"
    
    # Set up required directories
    setup_directories "$target_dir"
}

# Add as git submodule
install_as_submodule() {
    local submodule_path="$1"
    
    print_info "Adding .claude as git submodule at $submodule_path..."
    
    # Check if submodule already exists
    if git config --file .gitmodules --get-regexp path | grep -q "$submodule_path"; then
        print_warning "Submodule already exists at $submodule_path"
        read -p "Would you like to update it? (y/N): " update_choice
        if [[ $update_choice =~ ^[Yy]$ ]]; then
            git submodule update --remote "$submodule_path"
            print_success "Submodule updated"
        fi
        return 0
    fi
    
    git submodule add "$REPO_URL" "$submodule_path"
    git submodule update --init --recursive
    print_success "Submodule added successfully"
    
    # Set up required directories in parent repo
    setup_directories "."
}

# Install to separate directory with symlinks
install_with_symlinks() {
    local install_dir="$1"
    
    print_info "Installing .claude to $install_dir with symlinks..."
    
    # Create install directory if it doesn't exist
    mkdir -p "$(dirname "$install_dir")"
    
    # Clone to install directory
    if [ -d "$install_dir" ]; then
        print_info "Updating existing installation..."
        cd "$install_dir"
        git pull origin main
        cd - >/dev/null
    else
        git clone "$REPO_URL" "$install_dir"
    fi
    
    # Create symlink to .claude directory
    if [ -L .claude ]; then
        print_warning "Removing existing .claude symlink"
        rm .claude
    elif [ -d .claude ]; then
        print_warning "Backing up existing .claude directory to .claude.backup"
        mv .claude .claude.backup
    fi
    
    ln -s "$install_dir/.claude" .claude
    print_success "Symlink created: .claude -> $install_dir/.claude"
    
    # Set up required directories
    setup_directories "."
}

# Copy .claude directory to current project
install_copy_claude() {
    local source_dir="$1"
    
    print_info "Copying .claude directory from $source_dir..."
    
    # Backup existing .claude if it exists
    if [ -d .claude ]; then
        print_warning "Backing up existing .claude directory to .claude.backup"
        mv .claude .claude.backup
    fi
    
    # Copy .claude directory
    cp -r "$source_dir/.claude" .
    print_success ".claude directory copied successfully"
    
    # Set up required directories
    setup_directories "."
    
    print_warning "Note: This installation method won't receive automatic updates."
    print_info "To update, you'll need to manually copy the .claude directory again."
}

# Set up required directories and configurations
setup_directories() {
    local base_dir="$1"
    
    print_info "Setting up required directories..."
    
    # Create sessions directory if it doesn't exist
    mkdir -p "$base_dir/sessions"
    
    # Create .claude directory if copying from external source
    if [ "$base_dir" != "." ] && [ ! -d "$base_dir/.claude" ]; then
        mkdir -p "$base_dir/.claude"
    fi
    
    # Initialize milestone structure if script exists
    if [ -f "$base_dir/.claude/scripts/create-milestone-structure.sh" ]; then
        print_info "Initializing milestone structure..."
        cd "$base_dir"
        bash .claude/scripts/create-milestone-structure.sh 2>/dev/null || true
        cd - >/dev/null
    fi
    
    print_success "Directory setup completed"
}

# Show post-installation instructions
show_post_install_instructions() {
    local install_method="$1"
    local install_path="$2"
    
    echo ""
    print_success ".claude installation completed!"
    echo ""
    print_info "Installation Summary:"
    echo "  Method: $install_method"
    echo "  Path: $install_path"
    echo ""
    print_info "Next Steps:"
    echo "  1. Start Claude Code in this directory"
    echo "  2. Create project-specific CLAUDE.md:"
    echo "     /meta/create-memory ."
    echo "  3. Begin with implementation planning:"
    echo "     /plan your-vision.md your-requirements.md"
    echo "  4. Start milestone-driven development:"
    echo "     /milestone/create M1"
    echo "     /milestone/next M1"
    echo ""
    print_info "Available Commands:"
    echo "  Planning: /plan, /milestone/create, /milestone/next"
    echo "  Session: /session/start, /session/update, /session/end"
    echo "  Memory: /meta/create-memory, /meta/optimize-memory"
    echo "  Quality: /uncommitted/review, /docs/audit"
    echo "  Commit: /commit/changed, /commit/main"
    echo ""
    print_info "Documentation: Check .claude/docs/ for guides and templates"
}

# Main installation menu
show_installation_menu() {
    local current_dir=$(get_current_dir_name)
    
    echo "Current directory: $(pwd)"
    echo "Directory name: $current_dir"
    echo ""
    
    if check_git_repo; then
        print_warning "You are currently inside a git repository."
        echo "Choose an installation method:"
        echo ""
        echo "1) Add as git submodule (recommended for git repos)"
        echo "   - Adds .claude as a submodule at './$REPO_NAME'"
        echo "   - Keeps .claude updatable via git"
        echo "   - Maintains separation from your codebase"
        echo ""
        echo "2) Install to separate directory with symlinks"
        echo "   - Installs to ~/.config/.claude"
        echo "   - Creates symlink .claude -> ~/.config/.claude/.claude"
        echo "   - Shared installation across projects"
        echo ""
        echo "3) Copy .claude directory only"
        echo "   - Copies just the .claude directory to current project"
        echo "   - No git tracking, manual updates required"
        echo "   - Fully integrated with your project"
        echo ""
        echo "4) Install adjacent to current repository"
        echo "   - Clones .claude to ../$REPO_NAME"
        echo "   - Symlinks .claude directory"
        echo "   - Keeps repositories separate"
        echo ""
        read -p "Please choose installation method (1-4): " method
        
        case $method in
            1)
                install_as_submodule "$REPO_NAME"
                show_post_install_instructions "Git Submodule" "./$REPO_NAME"
                ;;
            2)
                local config_dir="$HOME/.config/.claude"
                install_with_symlinks "$config_dir"
                show_post_install_instructions "Separate Directory with Symlinks" "$config_dir"
                ;;
            3)
                # First clone to temp directory
                local temp_dir="/tmp/.claude-temp-$$"
                git clone "$REPO_URL" "$temp_dir"
                install_copy_claude "$temp_dir"
                rm -rf "$temp_dir"
                show_post_install_instructions "Copy .claude Directory" "."
                ;;
            4)
                local adjacent_dir="../$REPO_NAME"
                install_direct_clone "$adjacent_dir"
                # Create symlink to .claude
                if [ -L .claude ]; then
                    rm .claude
                elif [ -d .claude ]; then
                    mv .claude .claude.backup
                fi
                ln -s "$adjacent_dir/.claude" .claude
                print_success "Symlink created: .claude -> $adjacent_dir/.claude"
                show_post_install_instructions "Adjacent Installation with Symlink" "$adjacent_dir"
                ;;
            *)
                print_error "Invalid choice. Installation cancelled."
                exit 1
                ;;
        esac
    else
        print_info "You are not in a git repository."
        echo "Choose an installation method:"
        echo ""
        echo "1) Clone to current directory (recommended)"
        echo "   - Clones .claude repository to ./$REPO_NAME"
        echo "   - Full git tracking and easy updates"
        echo ""
        echo "2) Clone and copy .claude directory only"
        echo "   - Copies just the .claude directory to current location"
        echo "   - No git tracking, manual updates required"
        echo ""
        echo "3) Install to separate directory with symlinks"
        echo "   - Installs to ~/.config/.claude"
        echo "   - Creates symlink .claude -> ~/.config/.claude/.claude"
        echo ""
        read -p "Please choose installation method (1-3): " method
        
        case $method in
            1)
                install_direct_clone "$REPO_NAME"
                show_post_install_instructions "Direct Clone" "./$REPO_NAME"
                ;;
            2)
                # Clone to temp directory and copy
                local temp_dir="/tmp/.claude-temp-$$"
                git clone "$REPO_URL" "$temp_dir"
                install_copy_claude "$temp_dir"
                rm -rf "$temp_dir"
                show_post_install_instructions "Copy .claude Directory" "."
                ;;
            3)
                local config_dir="$HOME/.config/.claude"
                install_with_symlinks "$config_dir"
                show_post_install_instructions "Separate Directory with Symlinks" "$config_dir"
                ;;
            *)
                print_error "Invalid choice. Installation cancelled."
                exit 1
                ;;
        esac
    fi
}

# Main execution
main() {
    print_header
    check_prerequisites
    echo ""
    show_installation_menu
}

# Run main function
main "$@"