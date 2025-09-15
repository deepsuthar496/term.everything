#!/bin/bash

# Native build script for term.everything
# Alternative to Docker-based building

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[BUILD]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if all required tools are available
check_dependencies() {
    print_status "Checking dependencies..."
    
    local missing_deps=()
    
    if ! command -v bun >/dev/null 2>&1; then
        missing_deps+=("bun")
    fi
    
    if ! command -v task >/dev/null 2>&1; then
        missing_deps+=("task")
    fi
    
    if ! command -v meson >/dev/null 2>&1; then
        missing_deps+=("meson")
    fi
    
    if ! command -v ninja >/dev/null 2>&1; then
        missing_deps+=("ninja")
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_error "Missing dependencies: ${missing_deps[*]}"
        print_error "Please run ./install.sh first to install all dependencies"
        exit 1
    fi
    
    print_success "All dependencies found"
}

# Setup environment
setup_environment() {
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$HOME/.local/bin:$PATH"
}

# Initialize git submodules
init_submodules() {
    print_status "Initializing git submodules..."
    git submodule update --init --recursive
    print_success "Git submodules initialized"
}

# Install Node.js dependencies
install_deps() {
    print_status "Installing Node.js dependencies..."
    bun install
    print_success "Dependencies installed"
}

# Build the project
build_project() {
    print_status "Building project..."
    task build
    print_success "Build completed"
}

# Create AppImage (optional)
create_appimage() {
    if [ "$1" = "--appimage" ]; then
        print_status "Creating AppImage..."
        task publish-local
        print_success "AppImage created in ./dist/"
    fi
}

# Create simple launcher
create_launcher() {
    print_status "Creating launcher script..."
    
    cat > "./term.everything" << 'EOF'
#!/bin/bash

# term.everything launcher script
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$HOME/.local/bin:$PATH"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Run with development environment
DEV=1 WAYLAND_DEBUG_HIDE_SURFACE_AND_BUFFER_MESSAGES=1 bun run src/index.ts "$@"
EOF
    
    chmod +x "./term.everything"
    print_success "Launcher created: ./term.everything"
}

# Main build function
main() {
    echo "==============================================="
    echo "term.everything Native Build Script"
    echo "==============================================="
    echo ""
    
    setup_environment
    check_dependencies
    init_submodules
    install_deps
    build_project
    create_launcher
    create_appimage "$1"
    
    echo ""
    print_success "Build completed successfully!"
    echo ""
    print_status "Usage:"
    echo "  ./term.everything firefox"
    echo "  ./term.everything --help"
    echo ""
    
    if [ "$1" = "--appimage" ]; then
        print_status "AppImage available in ./dist/ directory"
    fi
}

# Show help
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "Native build script for term.everything"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --appimage    Also create an AppImage for distribution"
    echo "  --help, -h    Show this help message"
    echo ""
    echo "This script builds term.everything natively without Docker."
    echo "Run ./install.sh first to install all required dependencies."
    exit 0
fi

# Run main function
main "$@"