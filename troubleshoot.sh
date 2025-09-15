#!/bin/bash

# Troubleshooting script for term.everything native setup
# Helps diagnose common issues

echo "🔧 term.everything Troubleshooting"
echo "=================================="
echo ""

# Check Linux distribution
echo "📋 System Information:"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "  Distribution: $PRETTY_NAME"
    echo "  ID: $ID"
    echo "  Version: $VERSION_ID"
else
    echo "  ❌ Cannot detect Linux distribution"
fi

# Check architecture
echo "  Architecture: $(uname -m)"
echo "  Kernel: $(uname -r)"
echo ""

# Check required system packages
echo "🔍 System Dependencies:"
deps=(
    "curl"
    "wget" 
    "git"
    "pkg-config"
    "gcc"
    "g++"
    "cmake"
    "ninja-build"
)

for dep in "${deps[@]}"; do
    if command -v "$dep" >/dev/null 2>&1; then
        echo "  ✅ $dep is installed"
    else
        echo "  ❌ $dep is missing"
    fi
done

# Check for development libraries
echo ""
echo "📚 Development Libraries:"
# Check pkg-config for libraries
libs=(
    "glib-2.0"
)

for lib in "${libs[@]}"; do
    if pkg-config --exists "$lib" 2>/dev/null; then
        version=$(pkg-config --modversion "$lib" 2>/dev/null)
        echo "  ✅ $lib is installed (version: $version)"
    else
        echo "  ❌ $lib is missing or not found"
    fi
done

# Check for chafa
if command -v chafa >/dev/null 2>&1; then
    echo "  ✅ chafa is installed"
else
    echo "  ❌ chafa is missing"
fi

# Check user-installed tools
echo ""
echo "🛠️ Build Tools:"
tools=(
    "bun"
    "task"
    "meson"
    "ninja"
    "uv"
)

for tool in "${tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        version=$("$tool" --version 2>/dev/null | head -1 || echo "unknown")
        echo "  ✅ $tool is installed ($version)"
    else
        echo "  ❌ $tool is missing"
    fi
done

# Check environment variables
echo ""
echo "🌍 Environment:"
if [ -n "$BUN_INSTALL" ]; then
    echo "  ✅ BUN_INSTALL is set: $BUN_INSTALL"
else
    echo "  ⚠️  BUN_INSTALL is not set"
fi

echo "  PATH includes:"
echo "$PATH" | tr ':' '\n' | grep -E "(bun|local)" | sed 's/^/    /'

# Check project files
echo ""
echo "📁 Project Structure:"
files=(
    "package.json"
    "tsconfig.json"
    "Taskfile.dist.yml"
    "src/index.ts"
    "c_interop/meson.build"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file exists"
    else
        echo "  ❌ $file is missing"
    fi
done

# Check if submodules are initialized
echo ""
echo "📦 Git Submodules:"
if [ -f .gitmodules ]; then
    if git submodule status | grep -q "^-"; then
        echo "  ⚠️  Some submodules are not initialized"
        echo "     Run: git submodule update --init --recursive"
    else
        echo "  ✅ All submodules are initialized"
    fi
else
    echo "  ⚠️  No .gitmodules file found"
fi

# Check node_modules
echo ""
echo "📦 Dependencies:"
if [ -d "node_modules" ]; then
    if [ -f "node_modules/.bin/bun" ] || [ -d "node_modules/canvas" ]; then
        echo "  ✅ Node.js dependencies are installed"
    else
        echo "  ⚠️  Dependencies may be incomplete"
    fi
else
    echo "  ❌ node_modules directory missing"
    echo "     Run: bun install"
fi

# Check for common issues
echo ""
echo "🚨 Common Issues Check:"

# Check for permission issues
if [ ! -w . ]; then
    echo "  ❌ No write permission in current directory"
else
    echo "  ✅ Directory permissions OK"
fi

# Check for space
available_space=$(df . | tail -1 | awk '{print $4}')
if [ "$available_space" -lt 1000000 ]; then  # Less than 1GB
    echo "  ⚠️  Low disk space: $(df -h . | tail -1 | awk '{print $4}') available"
else
    echo "  ✅ Sufficient disk space"
fi

# Check memory
if [ -r /proc/meminfo ]; then
    mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    mem_gb=$((mem_total / 1024 / 1024))
    if [ "$mem_gb" -lt 2 ]; then
        echo "  ⚠️  Low memory: ${mem_gb}GB (build may fail)"
    else
        echo "  ✅ Sufficient memory: ${mem_gb}GB"
    fi
fi

echo ""
echo "=================================="
echo "🎯 Recommendations:"
echo ""

# Generate recommendations based on findings
missing_system=()
missing_tools=()

for dep in curl wget git pkg-config gcc g++ cmake; do
    if ! command -v "$dep" >/dev/null 2>&1; then
        missing_system+=("$dep")
    fi
done

for tool in bun task meson ninja uv; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        missing_tools+=("$tool")
    fi
done

if [ ${#missing_system[@]} -ne 0 ]; then
    echo "📥 Install missing system dependencies:"
    case $(. /etc/os-release; echo $ID) in
        ubuntu|debian|kali)
            echo "  sudo apt update && sudo apt install -y ${missing_system[*]} ninja-build libglib2.0-dev chafa"
            ;;
        fedora|rhel|centos)
            echo "  sudo dnf install -y ${missing_system[*]} ninja-build glib2-devel chafa"
            ;;
        arch|manjaro)
            echo "  sudo pacman -S --needed ${missing_system[*]} ninja glib2 chafa"
            ;;
        *)
            echo "  Install these packages: ${missing_system[*]} ninja-build libglib2.0-dev chafa"
            ;;
    esac
    echo ""
fi

if [ ${#missing_tools[@]} -ne 0 ]; then
    echo "🔧 Install missing build tools:"
    echo "  Run: ./install.sh"
    echo "  Or manually follow SETUP.md instructions"
    echo ""
fi

if [ ! -d node_modules ]; then
    echo "📦 Install Node.js dependencies:"
    echo "  bun install"
    echo ""
fi

if git submodule status 2>/dev/null | grep -q "^-"; then
    echo "📁 Initialize git submodules:"
    echo "  git submodule update --init --recursive"
    echo ""
fi

echo "🚀 Once everything is set up, try:"
echo "  ./build-native.sh"
echo "  ./term.everything firefox"
echo ""