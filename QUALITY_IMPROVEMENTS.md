# Quality Improvements for term.everything

This document describes the quality improvements implemented to address the issue of poor output quality.

## Changes Made

### 1. Increased Default Resolution
- **Before**: 640x480 pixels (low quality)
- **After**: 1920x1080 pixels (4x higher resolution)
- **Impact**: Much more detailed rendering of GUI applications

### 2. Enhanced Chafa Rendering Engine
- **Work Factor**: Increased from 0.0 (fastest) to 1.0 (highest quality)
- **Symbol Sets**: Added comprehensive character sets for better rendering:
  - Block characters for solid areas
  - Border characters for edges
  - Stipple and diagonal patterns for textures
  - Half-characters for fine detail
  - Extra symbols for maximum fidelity
- **Optimizations**: Enabled Chafa optimizations for better quality
- **Preprocessing**: Added image preprocessing for quality enhancement
- **Dithering**: Enabled diffusion dithering for better color reproduction

### 3. Canvas Quality Improvements
- **Image Smoothing**: Enabled high-quality image smoothing
- **Anti-aliasing**: Better rendering of scaled graphics
- **Color Management**: Improved color reproduction

### 4. Configurable Quality System
Added command-line options for users to control quality vs performance:

```bash
# Quality presets
--quality low      # Fast rendering, 60fps
--quality medium   # Balanced, 45fps  
--quality high     # High quality, 30fps (default)
--quality ultra    # Maximum quality, 24fps

# Fine-grained controls
--work-factor 0.8          # Custom quality level (0.0-1.0)
--fps 60                   # Custom frame rate
--enable-dithering         # Enable/disable dithering
--virtual-monitor-size 2560x1440  # Custom resolution
```

### 5. Performance Optimization
- **Frame Rate**: Adjusted default from 60fps to 30fps for balanced quality/performance
- **Adaptive Settings**: Quality presets automatically adjust all parameters
- **User Control**: Users can fine-tune for their specific needs

## Usage Examples

### Maximum Quality (for high-end terminals)
```bash
./term.everything --quality ultra --virtual-monitor-size 2560x1440 firefox
```

### Performance Mode (for older systems)
```bash
./term.everything --quality low --fps 60 --virtual-monitor-size 1280x720 firefox
```

### Custom Configuration
```bash
./term.everything --work-factor 0.8 --fps 45 --enable-dithering firefox
```

## Quality Comparison

### Before
- 640x480 resolution
- Basic character set
- No dithering
- Minimal Chafa optimization
- Result: Blocky, low-detail output

### After
- 1920x1080 resolution (default)
- Comprehensive character sets
- Diffusion dithering
- Full Chafa optimization
- Result: High-detail, smooth output with much better text and graphics rendering

## Technical Details

The improvements target all levels of the rendering pipeline:

1. **Virtual Monitor**: Higher resolution provides more pixel data
2. **Canvas Rendering**: Better image processing and smoothing
3. **Chafa Engine**: Enhanced symbol mapping and quality settings
4. **Terminal Output**: Optimized character selection and color reproduction

These changes should result in significantly better visual quality for all GUI applications rendered in the terminal.