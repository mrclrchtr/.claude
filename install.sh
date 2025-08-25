#!/bin/bash

{ # this ensures the entire script is downloaded #

# Claude Code Customization Framework Installer
# Installs project-specific customizations and tools for Claude Code
# Note: Default installations do NOT modify ~/.claude, but global installation option is available

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

# Exit codes
EXIT_SUCCESS=0
EXIT_GENERAL_ERROR=1
EXIT_MISSING_DEPENDENCY=2
EXIT_PERMISSION_ERROR=3
EXIT_NETWORK_ERROR=4
EXIT_GIT_ERROR=5
EXIT_USER_CANCELLED=6

# Utility functions
print_header() {
    echo -e "${BLUE}===========================================${NC}"
    echo -e "${BLUE}  Claude Code Customization Framework    ${NC}"
    echo -e "${BLUE}===========================================${NC}"
    echo -e "${YELLOW}Note: Default installs are project-specific${NC}"
    echo -e "${YELLOW}Global installation option available for ~/.claude${NC}"
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

# Show help message
show_help() {
    cat << EOF
Claude Code Customization Framework Installer v${SCRIPT_VERSION}

Usage: bash install.sh [OPTIONS]

Options:
  -h, --help     Show this help message and exit

Installation Methods:
  The script will detect if you're in a git repository and show appropriate options:
  
  For Git Repositories:
    1) Git Submodule (recommended) - Keeps framework updatable via git
    2) Copy Framework - Integrates framework directly into your project
    3) Global Install - Installs to ~/.claude (affects ALL projects)
  
  For Non-Git Directories:
    1) Direct Clone - Clones framework with full git tracking
    2) Copy Framework - Creates .claude directory with framework files only
    3) Global Install - Installs to ~/.claude (affects ALL projects)

Examples:
  curl -fsSL https://raw.githubusercontent.com/mrclrchtr/.claude/main/install.sh | bash
  wget -O- https://raw.githubusercontent.com/mrclrchtr/.claude/main/install.sh | bash
  
For more information, visit: https://github.com/mrclrchtr/.claude
EOF
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
        print_info "On macOS: brew install git or install Xcode Command Line Tools"
        print_info "On Ubuntu/Debian: sudo apt-get install git"
        print_info "On CentOS/RHEL: sudo yum install git"
        exit $EXIT_MISSING_DEPENDENCY
    fi
    
    # Check if we can write to current directory
    if [ ! -w "." ]; then
        print_error "Cannot write to current directory. Please check permissions."
        print_info "Try: chmod u+w . or run from a directory you own"
        exit $EXIT_PERMISSION_ERROR
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
                exit $EXIT_USER_CANCELLED
                ;;
            *)
                print_error "Invalid choice. Installation cancelled."
                exit $EXIT_GENERAL_ERROR
                ;;
        esac
    fi
    
    if ! git clone "$REPO_URL" "$target_dir"; then
        print_error "Failed to clone repository. Check your internet connection and try again."
        print_info "Repository URL: $REPO_URL"
        exit $EXIT_NETWORK_ERROR
    fi
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

# Install framework globally to ~/.claude using git with sparse checkout
install_global_git() {
    local claude_dir="$HOME/.claude"
    
    print_info "Installing customization framework globally to ~/.claude..."
    
    # Check if ~/.claude exists
    if [ ! -d "$claude_dir" ]; then
        print_warning "~/.claude directory doesn't exist. Creating it..."
        mkdir -p "$claude_dir"
    fi
    
    # Check if we can write to ~/.claude
    if [ ! -w "$claude_dir" ]; then
        print_error "Cannot write to ~/.claude directory. Please check permissions."
        exit 1
    fi
    
    cd "$claude_dir"
    
    # Check if already a git repository
    local is_git_repo=false
    if [ -d ".git" ]; then
        is_git_repo=true
        print_warning "~/.claude is already a git repository"
        
        # Check if our remote already exists
        if git remote get-url claude-framework >/dev/null 2>&1; then
            print_info "Framework remote already exists. Updating..."
            git fetch claude-framework
            git pull claude-framework main --allow-unrelated-histories
            print_success "Framework updated successfully"
            return 0
        else
            print_info "Adding framework remote to existing repository..."
        fi
    else
        print_info "Initializing ~/.claude as git repository..."
        git init
        is_git_repo=true
    fi
    
    # Create .gitignore to exclude Claude Code files
    print_info "Creating .gitignore to protect Claude Code files..."
    cat > .gitignore << 'EOF'
# Ignore all files by default (to protect Claude Code files)
/*

# But track framework directories
!/agents/
!/commands/
!/docs/
!/scripts/
!/templates/
!/hooks/
!/.gitignore

# Ignore common Claude Code files/directories
.claude-sessions/
temp/
logs/
*.log
*.tmp

# Allow tracking of framework-specific files
!/agents/**
!/commands/**
!/docs/**
!/scripts/**
!/templates/**
!/hooks/**
EOF
    
    # Add framework remote if not exists
    if ! git remote get-url claude-framework >/dev/null 2>&1; then
        print_info "Adding framework remote..."
        if ! git remote add claude-framework "$REPO_URL"; then
            print_error "Failed to add remote repository."
            exit $EXIT_GIT_ERROR
        fi
    fi
    
    # Set up sparse checkout
    print_info "Configuring sparse checkout for framework directories..."
    git config core.sparseCheckout true
    
    # Use modern sparse-checkout if available, fallback to legacy method
    if git sparse-checkout init --cone 2>/dev/null; then
        git sparse-checkout set agents commands docs scripts templates hooks 2>/dev/null || {
            # Fallback to manual sparse-checkout file
            echo "agents/" > .git/info/sparse-checkout
            echo "commands/" >> .git/info/sparse-checkout
            echo "docs/" >> .git/info/sparse-checkout
            echo "scripts/" >> .git/info/sparse-checkout
            echo "templates/" >> .git/info/sparse-checkout
            echo "hooks/" >> .git/info/sparse-checkout
        }
    else
        # Fallback for older git versions
        echo "agents/" > .git/info/sparse-checkout
        echo "commands/" >> .git/info/sparse-checkout
        echo "docs/" >> .git/info/sparse-checkout
        echo "scripts/" >> .git/info/sparse-checkout
        echo "templates/" >> .git/info/sparse-checkout
        echo "hooks/" >> .git/info/sparse-checkout
    fi
    
    # Fetch and pull framework files
    print_info "Fetching framework files..."
    if ! git fetch claude-framework; then
        print_error "Failed to fetch from remote repository. Check your internet connection."
        exit $EXIT_NETWORK_ERROR
    fi
    
    # Handle potential conflicts with existing files
    if [ "$(git status --porcelain | wc -l)" -gt 0 ]; then
        print_warning "Found existing files that might conflict. Backing them up..."
        local backup_dir="claude-backup-$(date +%Y%m%d-%H%M%S)"
        mkdir -p "$backup_dir"
        
        # Backup existing framework directories
        for dir in agents commands docs scripts templates hooks; do
            if [ -d "$dir" ] && [ ! -L "$dir" ]; then
                mv "$dir" "$backup_dir/" 2>/dev/null || true
            fi
        done
        
        if [ "$(ls -A $backup_dir 2>/dev/null | wc -l)" -gt 0 ]; then
            print_success "Backed up existing files to $backup_dir/"
        else
            rmdir "$backup_dir"
        fi
    fi
    
    # Install framework files using sparse-checkout
    print_info "Installing framework files..."
    if git fetch claude-framework main; then
        if git merge claude-framework/main --allow-unrelated-histories --no-edit; then
            print_success "Global framework installation completed!"
            print_info "Framework installed to: $claude_dir"
            print_info "To update in the future, run: cd ~/.claude && git pull claude-framework main"
        else
            print_error "Failed to merge framework files. Installation may be incomplete."
            print_info "You can try manually resolving conflicts and running:"
            print_info "  cd ~/.claude && git merge claude-framework/main"
            exit $EXIT_GIT_ERROR
        fi
    else
        print_error "Failed to fetch framework files. Check your internet connection."
        exit $EXIT_NETWORK_ERROR
    fi
}

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
    
    # Copy hooks directory if it exists
    if [ -d "$source_dir/hooks" ]; then
        cp -r "$source_dir/hooks" .claude/
    fi
    
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
    
    if [[ "$install_method" == "Global Git Installation" ]]; then
        print_info "Global Installation Management:"
        echo "  Update framework: cd ~/.claude && git pull claude-framework main"
        echo "  Check status: cd ~/.claude && git status"
        echo "  Framework files are tracked with sparse checkout"
        echo "  Your Claude Code files are protected by .gitignore"
        echo ""
    fi
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
        echo "1) Add as git submodule (recommended for projects)"
        echo "   - Adds framework as a submodule at './$PROJECT_DIR_NAME'"
        echo "   - Keeps framework updatable via git"
        echo "   - Maintains separation from your codebase"
        echo ""
        echo "2) Copy framework directory only"
        echo "   - Copies just the .claude directory to current project"
        echo "   - No git tracking, manual updates required"
        echo "   - Fully integrated with your project"
        echo ""
        echo "3) Install globally to ~/.claude (affects ALL projects)"
        echo "   - Makes ~/.claude a git repository with sparse checkout"
        echo "   - Framework available in all Claude Code sessions"
        echo "   - Easy updates with git pull"
        echo "   - ⚠️  WARNING: This modifies your global Claude Code directory"
        echo ""
        read -p "Please choose installation method (1-3): " method
        
        case $method in
            1)
                install_as_submodule "$PROJECT_DIR_NAME"
                show_post_install_instructions "Git Submodule" "./$PROJECT_DIR_NAME"
                ;;
            2)
                # First clone to temp directory
                local temp_dir="/tmp/.claude-temp-$$"
                if ! git clone "$REPO_URL" "$temp_dir"; then
                    print_error "Failed to clone repository. Check your internet connection."
                    exit $EXIT_NETWORK_ERROR
                fi
                install_copy_framework "$temp_dir"
                rm -rf "$temp_dir"
                show_post_install_instructions "Copy Framework Directory" "."
                ;;
            3)
                print_warning "This will modify your global ~/.claude directory!"
                read -p "Are you sure you want to continue? (y/N): " confirm
                if [[ $confirm =~ ^[Yy]$ ]]; then
                    install_global_git
                    show_post_install_instructions "Global Git Installation" "~/.claude"
                else
                    print_info "Installation cancelled"
                    exit $EXIT_USER_CANCELLED
                fi
                ;;
            *)
                print_error "Invalid choice. Installation cancelled."
                exit $EXIT_GENERAL_ERROR
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
        echo "3) Install globally to ~/.claude (affects ALL projects)"
        echo "   - Makes ~/.claude a git repository with sparse checkout"
        echo "   - Framework available in all Claude Code sessions"
        echo "   - Easy updates with git pull"
        echo "   - ⚠️  WARNING: This modifies your global Claude Code directory"
        echo ""
        read -p "Please choose installation method (1-3): " method
        
        case $method in
            1)
                install_direct_clone "$PROJECT_DIR_NAME"
                show_post_install_instructions "Direct Clone" "./$PROJECT_DIR_NAME"
                ;;
            2)
                # Clone to temp directory and copy
                local temp_dir="/tmp/.claude-temp-$$"
                if ! git clone "$REPO_URL" "$temp_dir"; then
                    print_error "Failed to clone repository. Check your internet connection."
                    exit $EXIT_NETWORK_ERROR
                fi
                install_copy_framework "$temp_dir"
                rm -rf "$temp_dir"
                show_post_install_instructions "Copy Framework Directory" "."
                ;;
            3)
                print_warning "This will modify your global ~/.claude directory!"
                read -p "Are you sure you want to continue? (y/N): " confirm
                if [[ $confirm =~ ^[Yy]$ ]]; then
                    install_global_git
                    show_post_install_instructions "Global Git Installation" "~/.claude"
                else
                    print_info "Installation cancelled"
                    exit $EXIT_USER_CANCELLED
                fi
                ;;
            *)
                print_error "Invalid choice. Installation cancelled."
                exit $EXIT_GENERAL_ERROR
                ;;
        esac
    fi
}

# Parse command line arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit $EXIT_SUCCESS
                ;;
            *)
                print_error "Unknown option: $1"
                print_info "Use --help to see available options."
                exit $EXIT_GENERAL_ERROR
                ;;
        esac
        shift
    done
}

# Main execution
main() {
    parse_args "$@"
    print_header
    check_prerequisites
    echo ""
    show_installation_menu
}

# Run main function
main "$@"

} # this ensures the entire script is downloaded #
