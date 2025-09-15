#pragma once

#include <stdint.h>
#include "chafa.h"
class ChafaInfo
{
private:
    void init_chafa(bool enable_optimizations, bool enable_preprocessing, bool enable_dithering, double work_factor);
    
public:
    ChafaTermInfo *term_info;
    ChafaCanvasMode mode;
    ChafaPixelMode pixel_mode;
    ChafaSymbolMap *symbol_map;
    ChafaCanvasConfig *config;
    ChafaCanvas *canvas;

    gint width_cells, height_cells;
    gint width_of_a_cell_in_pixels, height_of_a_cell_in_pixels; /* Size of each character cell, in pixels */
    bool session_type_is_x11;

    ChafaInfo(gint width_cells,
              gint height_cells,
              gint width_of_a_cell_in_pixels,
              gint height_of_a_cell_in_pixels,
              bool session_type_is_x11);
              
    ChafaInfo(gint width_cells,
              gint height_cells,
              gint width_of_a_cell_in_pixels,
              gint height_of_a_cell_in_pixels,
              bool session_type_is_x11,
              bool enable_optimizations,
              bool enable_preprocessing,
              bool enable_dithering,
              double work_factor);

    GString *convert_image(uint8_t *texture_pixels,
                           uint32_t texture_width,
                           uint32_t texture_height,
                           uint32_t texture_stride);
    ~ChafaInfo();
};