#!/bin/bash

# term.everything Native Linux Installation Script
# Works on Linux, Debian, Kali and other Debian-based distributions
# No Docker required!

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to detect distribution
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
        VERSION=$VERSION_ID
    else
        print_error "Cannot detect Linux distribution"
        exit 1
    fi
    print_status "Detected distribution: $DISTRO $VERSION"
}

# Function to install system dependencies
install_system_deps() {
    print_status "Installing system dependencies..."
    
    case $DISTRO in
        ubuntu|debian|kali)
            sudo apt update
            sudo apt install -y \
                curl \
                wget \
                pkg-config \
                build-essential \
                cmake \
                ninja-build \
                libglib2.0-dev \
                chafa \
                libchafa-dev \
                software-properties-common \
                file \
                unzip \
                autoconf \
                automake \
                libtool \
                libfreetype-dev \
                git
            ;;
        fedora|rhel|centos)
            sudo dnf install -y \
                curl \
                wget \
                pkgconfig \
                gcc \
                gcc-c++ \
                cmake \
                ninja-build \
                glib2-devel \
                chafa \
                chafa-devel \
                file \
                unzip \
                autoconf \
                automake \
                libtool \
                freetype-devel \
                git
            ;;
        arch|manjaro)
            sudo pacman -S --needed \
                curl \
                wget \
                pkgconf \
                base-devel \
                cmake \
                ninja \
                glib2 \
                chafa \
                file \
                unzip \
                autoconf \
                automake \
                libtool \
                freetype2 \
                git
            ;;
        *)
            print_error "Unsupported distribution: $DISTRO"
            print_warning "Please install the following packages manually:"
            print_warning "curl, wget, pkg-config, build-essential, cmake, ninja-build, libglib2.0-dev, chafa, libchafa-dev"
            ;;
    esac
    
    print_success "System dependencies installed"
}

# Function to install UV (Python package manager)
install_uv() {
    if ! command_exists uv; then
        print_status "Installing UV (Python package manager)..."
        curl -LsSf https://astral.sh/uv/0.8.4/install.sh | sh
        export PATH="$HOME/.local/bin:$PATH"
        print_success "UV installed"
    else
        print_status "UV already installed"
    fi
}

# Function to install Meson
install_meson() {
    if ! command_exists meson; then
        print_status "Installing Meson build system..."
        uv tool install "meson==1.9.0"
        export PATH="$HOME/.local/bin:$PATH"
        print_success "Meson installed"
    else
        print_status "Meson already installed"
    fi
}

# Function to install Task
install_task() {
    if ! command_exists task; then
        print_status "Installing Task runner..."
        uv tool install "go-task-bin==3.44.1"
        export PATH="$HOME/.local/bin:$PATH"
        print_success "Task installed"
    else
        print_status "Task already installed"
    fi
}

# Function to install Bun
install_bun() {
    if ! command_exists bun; then
        print_status "Installing Bun JavaScript runtime..."
        curl -fsSL https://bun.sh/install | bash -s "bun-v1.2.21"
        export BUN_INSTALL="$HOME/.bun"
        export PATH="$BUN_INSTALL/bin:$PATH"
        print_success "Bun installed"
    else
        print_status "Bun already installed"
    fi
}

# Function to setup environment
setup_environment() {
    print_status "Setting up environment..."
    
    # Add to bashrc if not already present
    if ! grep -q "# term.everything environment" ~/.bashrc; then
        cat >> ~/.bashrc << 'EOF'

# term.everything environment
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$HOME/.local/bin:$PATH"
EOF
        print_success "Environment variables added to ~/.bashrc"
    fi
    
    # Source the updated environment
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$HOME/.local/bin:$PATH"
}

# Function to initialize git submodules
init_submodules() {
    print_status "Initializing git submodules..."
    git submodule update --init --recursive
    print_success "Git submodules initialized"
}

# Function to install Node.js dependencies
install_node_deps() {
    print_status "Installing Node.js dependencies with Bun..."
    bun install
    print_success "Node.js dependencies installed"
}

# Function to build the project
build_project() {
    print_status "Building term.everything..."
    task build
    print_success "Build completed successfully"
}

# Function to create desktop entry
create_desktop_entry() {
    print_status "Creating desktop entry..."
    
    local app_path="$(pwd)/term.everything"
    local desktop_file="$HOME/.local/share/applications/term-everything.desktop"
    
    mkdir -p "$HOME/.local/share/applications"
    
    cat > "$desktop_file" << EOF
[Desktop Entry]
Name=term.everything
Comment=Run GUI apps in your terminal
Exec=$app_path %F
Icon=$(pwd)/resources/icon.png
Terminal=true
Type=Application
Categories=Utility;System;
StartupNotify=false
EOF
    
    print_success "Desktop entry created at $desktop_file"
}

# Function to create launcher script
create_launcher() {
    print_status "Creating launcher script..."
    
    cat > "./term.everything" << 'EOF'
#!/bin/bash

# term.everything launcher script
# Sets up environment and runs the application

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$HOME/.local/bin:$PATH"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Run the application
bun run src/index.ts "$@"
EOF
    
    chmod +x "./term.everything"
    print_success "Launcher script created: ./term.everything"
}

# Main installation function
main() {
    echo "==============================================="
    echo "term.everything Native Linux Installation"
    echo "==============================================="
    echo ""
    
    # Check if running as root
    if [ "$EUID" -eq 0 ]; then
        print_error "Please do not run this script as root (don't use sudo)"
        print_warning "The script will ask for sudo permission when needed"
        exit 1
    fi
    
    # Check if git is available
    if ! command_exists git; then
        print_error "Git is required but not installed. Please install git first."
        exit 1
    fi
    
    # Detect distribution
    detect_distro
    
    # Install dependencies
    install_system_deps
    install_uv
    install_meson
    install_task
    install_bun
    
    # Setup environment
    setup_environment
    
    # Initialize project
    init_submodules
    install_node_deps
    
    # Build project
    build_project
    
    # Create launcher and desktop entry
    create_launcher
    create_desktop_entry
    
    echo ""
    echo "==============================================="
    print_success "Installation completed successfully!"
    echo "==============================================="
    echo ""
    print_status "How to use term.everything:"
    echo "  1. Run: ./term.everything firefox"
    echo "  2. Or: ./term.everything --help for more options"
    echo ""
    print_status "For older X11 applications, use:"
    echo "  ./term.everything --support-old-apps -- your-app"
    echo ""
    print_warning "Note: You may need to restart your terminal or run 'source ~/.bashrc' for environment changes to take effect."
    echo ""
}

# Run main function
main "$@"