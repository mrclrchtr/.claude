#!/bin/bash

# Claude Code Customization Framework Installer
# Installs project-specific customizations and tools for Claude Code
# Note: This does NOT modify ~/.claude (Claude Code's global config directory)

set -e  # Exit on any error

# Color definitions for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Repository information
REPO_URL="https://github.com/mrclrchtr/.claude.git"
FRAMEWORK_NAME="claude-framework"
PROJECT_DIR_NAME=".claude"

# Utility functions
print_header() {
    echo -e "${BLUE}===========================================${NC}"
    echo -e "${BLUE}  Claude Code Customization Framework    ${NC}"
    echo -e "${BLUE}===========================================${NC}"
    echo -e "${YELLOW}Note: This installs project customizations${NC}"
    echo -e "${YELLOW}It does NOT modify ~/.claude (Claude Code config)${NC}"
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
    
    print_info "Cloning customization framework to $target_dir..."
    
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
    print_success "Framework cloned successfully"
    
    # Set up required directories
    setup_directories "$target_dir"
}

# Add as git submodule
install_as_submodule() {
    local submodule_path="$1"
    
    print_info "Adding customization framework as git submodule at $submodule_path..."
    
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

# This function has been removed - symlink installation was confusing
# and interfered with Claude Code's ~/.claude directory

# Copy framework to current project
install_copy_framework() {
    local source_dir="$1"
    
    print_info "Copying customization framework from $source_dir..."
    
    # Backup existing .claude if it exists
    if [ -d .claude ]; then
        print_warning "Backing up existing .claude directory to .claude.backup"
        mv .claude .claude.backup
    fi
    
    # Create .claude directory and copy framework components
    mkdir -p .claude
    cp -r "$source_dir/agents" .claude/
    cp -r "$source_dir/commands" .claude/
    cp -r "$source_dir/docs" .claude/
    cp -r "$source_dir/scripts" .claude/
    cp -r "$source_dir/templates" .claude/
    
    print_success "Framework copied successfully"
    
    # Set up required directories
    setup_directories "."
    
    print_warning "Note: This installation method won't receive automatic updates."
    print_info "To update, you'll need to manually copy the framework again."
}

# Set up required directories and configurations
setup_directories() {
    local base_dir="$1"
    
    print_info "Setting up project directories..."
    
    # Create sessions directory in the project root
    if [ "$base_dir" = "." ]; then
        mkdir -p "sessions"
    fi
    
    # Initialize milestone structure if script exists
    local claude_dir
    if [ "$base_dir" = "." ]; then
        claude_dir=".claude"
    else
        claude_dir="$base_dir/.claude"
    fi
    
    if [ -f "$claude_dir/scripts/create-milestone-structure.sh" ]; then
        print_info "Initializing milestone structure..."
        if [ "$base_dir" != "." ]; then
            cd "$base_dir"
        fi
        bash "$claude_dir/scripts/create-milestone-structure.sh" 2>/dev/null || true
        if [ "$base_dir" != "." ]; then
            cd - >/dev/null
        fi
    fi
    
    print_success "Project setup completed"
}

# Show post-installation instructions
show_post_install_instructions() {
    local install_method="$1"
    local install_path="$2"
    
    echo ""
    print_success "Claude Code customization framework installed!"
    echo ""
    print_info "Installation Summary:"
    echo "  Method: $install_method"
    echo "  Framework Path: $install_path"
    echo "  Project Configuration: .claude/"
    echo ""
    print_info "Next Steps:"
    echo "  1. Start Claude Code in this directory"
    echo "  2. Create project-specific CLAUDE.md:"
    echo "     /meta:create-memory ."
    echo "  3. Begin with implementation planning:"
    echo "     /plan your-vision.md your-requirements.md"
    echo "  4. Start milestone-driven development:"
    echo "     /milestone:create M1"
    echo "     /milestone:next M1"
    echo ""
    print_info "Available Custom Commands:"
    echo "  Planning: /plan, /milestone:create, /milestone:next"
    echo "  Session: /session:start, /session:update, /session:end"
    echo "  Memory: /meta:create-memory, /meta:optimize-memory"
    echo "  Quality: /uncommitted:review, /docs:audit"
    echo "  Commit: /commit:changed, /commit:main"
    echo ""
    print_info "Documentation: Check .claude/docs/ for guides and templates"
    print_warning "Note: Your global Claude Code config remains at ~/.claude"
}

# Main installation menu
show_installation_menu() {
    local current_dir=$(get_current_dir_name)
    
    echo "Current directory: $(pwd)"
    echo "Directory name: $current_dir"
    echo ""
    
    if check_git_repo; then
        print_info "You are currently inside a git repository."
        echo "Choose an installation method:"
        echo ""
        echo "1) Add as git submodule (recommended)"
        echo "   - Adds framework as a submodule at './$PROJECT_DIR_NAME'"
        echo "   - Keeps framework updatable via git"
        echo "   - Maintains separation from your codebase"
        echo ""
        echo "2) Copy framework directory only"
        echo "   - Copies just the .claude directory to current project"
        echo "   - No git tracking, manual updates required"
        echo "   - Fully integrated with your project"
        echo ""
        read -p "Please choose installation method (1-2): " method
        
        case $method in
            1)
                install_as_submodule "$PROJECT_DIR_NAME"
                show_post_install_instructions "Git Submodule" "./$PROJECT_DIR_NAME"
                ;;
            2)
                # First clone to temp directory
                local temp_dir="/tmp/.claude-temp-$$"
                git clone "$REPO_URL" "$temp_dir"
                install_copy_framework "$temp_dir"
                rm -rf "$temp_dir"
                show_post_install_instructions "Copy Framework Directory" "."
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
        echo "1) Clone framework to current directory (recommended)"
        echo "   - Clones framework repository to ./$PROJECT_DIR_NAME"
        echo "   - Full git tracking and easy updates"
        echo ""
        echo "2) Copy framework directory only"
        echo "   - Copies just the .claude directory to current location"
        echo "   - No git tracking, manual updates required"
        echo ""
        read -p "Please choose installation method (1-2): " method
        
        case $method in
            1)
                install_direct_clone "$PROJECT_DIR_NAME"
                show_post_install_instructions "Direct Clone" "./$PROJECT_DIR_NAME"
                ;;
            2)
                # Clone to temp directory and copy
                local temp_dir="/tmp/.claude-temp-$$"
                git clone "$REPO_URL" "$temp_dir"
                install_copy_framework "$temp_dir"
                rm -rf "$temp_dir"
                show_post_install_instructions "Copy Framework Directory" "."
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