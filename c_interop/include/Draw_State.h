#pragma once
#include "ChafaInfo.h"
#include "TermSize.h"

class Draw_State
{
public:
    bool session_type_is_x11;
    bool enable_optimizations;
    bool enable_preprocessing;
    bool enable_dithering;
    double work_factor;
    ChafaInfo *chafa_info = nullptr;

    void resize_chafa_info_if_needed(gint width_cells,
                                     gint height_cells,
                                     TermSize &term_size);


    Draw_State(bool session_type_is_x11);
    Draw_State(bool session_type_is_x11, bool enable_optimizations, bool enable_preprocessing, bool enable_dithering, double work_factor);
    ~Draw_State();
};
