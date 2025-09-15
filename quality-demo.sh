#!/bin/bash

# Quality Demo Script for term.everything
# This script demonstrates the different quality levels available

echo "=== term.everything Quality Demo ==="
echo "This script will show you the different quality options available."
echo ""

if [ ! -x "./term.everything" ]; then
    echo "Error: term.everything binary not found."
    echo "Please build the project first with 'task build' or './build-native.sh'"
    exit 1
fi

echo "Available quality presets:"
echo "1. Low    - Fast rendering, 60fps, minimal quality"
echo "2. Medium - Balanced quality and performance, 45fps"  
echo "3. High   - High quality rendering, 30fps (default)"
echo "4. Ultra  - Maximum quality, 24fps"
echo "5. Custom - Show custom options"
echo ""

read -p "Select quality level (1-5): " choice

case $choice in
    1)
        echo "Running with LOW quality (fast performance)..."
        ./term.everything --quality low --virtual-monitor-size 1280x720 $@
        ;;
    2)
        echo "Running with MEDIUM quality (balanced)..."
        ./term.everything --quality medium --virtual-monitor-size 1600x900 $@
        ;;
    3)
        echo "Running with HIGH quality (default)..."
        ./term.everything --quality high $@
        ;;
    4)
        echo "Running with ULTRA quality (maximum quality)..."
        ./term.everything --quality ultra --virtual-monitor-size 2560x1440 $@
        ;;
    5)
        echo ""
        echo "Custom options available:"
        echo "  --quality <low|medium|high|ultra>"
        echo "  --work-factor <0.0-1.0>           # 0.0=fastest, 1.0=highest quality"
        echo "  --fps <number>                    # Target frame rate (1-120)"
        echo "  --virtual-monitor-size <W>x<H>    # Virtual display resolution"
        echo "  --enable-dithering / --no-enable-dithering"
        echo ""
        echo "Example custom command:"
        echo "  ./term.everything --work-factor 0.8 --fps 45 --virtual-monitor-size 1920x1080 firefox"
        ;;
    *)
        echo "Invalid choice. Using default HIGH quality."
        ./term.everything --quality high $@
        ;;
esac