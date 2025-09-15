#!/bin/bash

# Quick start script for term.everything
# This script does a minimal setup to get you running quickly

set -e

echo "🚀 term.everything Quick Start"
echo "=============================="
echo ""

# Check if this is the first run
if [ ! -f ".setup_complete" ]; then
    echo "First time setup detected. Running installation..."
    echo ""
    
    # Run the full installation
    ./install.sh
    
    # Mark setup as complete
    touch .setup_complete
    
    echo ""
    echo "✅ Setup complete!"
else
    echo "Setup already completed. Building project..."
    echo ""
    
    # Just build if already set up
    ./build-native.sh
fi

echo ""
echo "🎉 Ready to use!"
echo ""
echo "Try these commands:"
echo "  ./term.everything firefox      # Run Firefox in terminal"
echo "  ./term.everything gedit        # Run text editor"
echo "  ./term.everything --help       # Show help"
echo ""
echo "For older X11 apps:"
echo "  ./term.everything --support-old-apps -- xterm"
echo ""