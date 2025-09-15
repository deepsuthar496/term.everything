# Native Linux Setup Guide for term.everything

Welcome! This guide will help you set up `term.everything` to run natively on Linux, Debian, Kali, and other Linux distributions **without Docker**.

## 🚀 Quick Setup (Recommended)

The easiest way to get started is using our automated installation script:

### 1. Clone the Repository
```bash
git clone https://github.com/deepsuthar496/term.everything.git
cd term.everything
```

### 2. Run the Installation Script
```bash
./install.sh
```

The script will automatically:
- Detect your Linux distribution
- Install all required system dependencies
- Install Bun, Meson, Task, and other build tools
- Build the project
- Create a convenient launcher script

### 3. Start Using term.everything
```bash
# Run Firefox in terminal
./term.everything firefox

# Run any GUI application
./term.everything your-app-name

# For older X11 applications
./term.everything --support-old-apps -- your-x11-app

# Show help
./term.everything --help
```

## 🔧 Manual Installation

If you prefer to install dependencies manually or the automatic script doesn't work for your distribution:

### System Dependencies

#### Ubuntu/Debian/Kali:
```bash
sudo apt update
sudo apt install -y \
    curl wget git \
    pkg-config build-essential cmake ninja-build \
    libglib2.0-dev chafa libchafa-dev \
    software-properties-common file unzip \
    autoconf automake libtool libfreetype-dev
```

#### Fedora/RHEL/CentOS:
```bash
sudo dnf install -y \
    curl wget git \
    pkgconfig gcc gcc-c++ cmake ninja-build \
    glib2-devel chafa chafa-devel \
    file unzip autoconf automake libtool freetype-devel
```

#### Arch/Manjaro:
```bash
sudo pacman -S --needed \
    curl wget git \
    pkgconf base-devel cmake ninja \
    glib2 chafa file unzip \
    autoconf automake libtool freetype2
```

### Build Tools

#### 1. Install UV (Python package manager):
```bash
curl -LsSf https://astral.sh/uv/0.8.4/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"
```

#### 2. Install Meson:
```bash
uv tool install "meson==1.9.0"
```

#### 3. Install Task runner:
```bash
uv tool install "go-task-bin==3.44.1"
```

#### 4. Install Bun:
```bash
curl -fsSL https://bun.sh/install | bash -s "bun-v1.2.21"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
```

#### 5. Add to your shell profile:
```bash
echo 'export BUN_INSTALL="$HOME/.bun"' >> ~/.bashrc
echo 'export PATH="$BUN_INSTALL/bin:$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Build Process

#### 1. Initialize submodules:
```bash
git submodule update --init --recursive
```

#### 2. Install Node.js dependencies:
```bash
bun install
```

#### 3. Build the project:
```bash
task build
```

#### 4. Create launcher script:
```bash
cat > ./term.everything << 'EOF'
#!/bin/bash
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$HOME/.local/bin:$PATH"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
bun run src/index.ts "$@"
EOF
chmod +x ./term.everything
```

## 📱 Usage Examples

### Basic Usage
```bash
# Run Firefox
./term.everything firefox

# Run file manager
./term.everything nautilus

# Run text editor
./term.everything gedit
```

### Advanced Usage
```bash
# Set custom virtual monitor size
./term.everything --virtual-monitor-size 800x600 -- firefox

# Hide status bar
./term.everything --hide-status-bar -- your-app

# Custom Wayland display name
./term.everything --wayland-display-name my-display -- firefox

# Support for older X11 applications
./term.everything --support-old-apps -- xterm
```

### SSH Usage
You can even run GUI apps over SSH! 
```bash
# On remote machine
./term.everything firefox

# The GUI will render in your terminal over SSH
```

## 🐛 Troubleshooting

### App doesn't open in terminal?
- Try closing existing windows of that application
- Use `--support-old-apps` flag for older applications

### Build errors?
- Make sure all dependencies are installed
- Try running `task clean-all && task build`
- Check that you have sufficient RAM (building can be memory-intensive)

### Permission errors?
- Don't run the install script as root
- Make sure your user has sudo privileges
- Check file permissions: `chmod +x ./term.everything`

### Missing libraries?
Some applications might need additional libraries:
```bash
# For multimedia applications
sudo apt install libavcodec-dev libavformat-dev

# For OpenGL applications  
sudo apt install libgl1-mesa-dev libglu1-mesa-dev

# For Wayland applications
sudo apt install libwayland-dev
```

## 🎯 Performance Tips

1. **Adjust terminal size**: Increase terminal columns/rows for better quality
2. **Virtual monitor size**: Use smaller sizes (640x480) for better performance
3. **Terminal with image support**: Use terminals like Kitty or iTerm2 for full resolution
4. **Hardware acceleration**: Ensure your graphics drivers are properly installed

## 🔍 Development

If you want to contribute or modify the code:

```bash
# Type check
task check

# Clean build artifacts
task clean-all

# Run in development mode
task run -- your-app

# Hide/show development files in VS Code
task hide-etc  # Hide clutter
task show-etc  # Show all files
```

## 📖 More Information

- **How it works**: Check [HowIDidIt.md](./resources/HowIDidIt.md)
- **Contributing**: See [Contributing.md](./Contributing.md)
- **Help**: Run `./term.everything --help`
- **Issues**: Report bugs at [GitHub Issues](https://github.com/deepsuthar496/term.everything/issues)

## 🎉 Enjoy!

You can now run any GUI application in your terminal without Docker. Have fun exploring!

```bash
# Try some fun examples:
./term.everything firefox
./term.everything --support-old-apps -- xeyes
./term.everything gedit
./term.everything file-manager
```

**Note**: term.everything works best with Wayland applications but also supports X11 apps through Xwayland.