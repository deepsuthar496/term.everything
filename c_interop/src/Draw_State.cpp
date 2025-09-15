#include "Draw_State.h"

void Draw_State::resize_chafa_info_if_needed(gint width_cells, gint height_cells,
                                             TermSize &term_size)
{

    if (chafa_info != nullptr && !(chafa_info->width_cells == width_cells &&
                                   chafa_info->height_cells == height_cells &&
                                   static_cast<gint>(chafa_info->width_of_a_cell_in_pixels) == term_size.width_of_a_cell_in_pixels &&
                                   static_cast<gint>(chafa_info->height_of_a_cell_in_pixels) == term_size.height_of_a_cell_in_pixels))
    {
        delete chafa_info;
        chafa_info = nullptr;
    }

    if (chafa_info == nullptr)
    {
        chafa_info = new ChafaInfo(width_cells,
                                   height_cells,
                                   term_size.width_of_a_cell_in_pixels,
                                   term_size.height_of_a_cell_in_pixels,
                                   session_type_is_x11,
                                   enable_optimizations,
                                   enable_preprocessing,
                                   enable_dithering,
                                   work_factor);
    }
}

Draw_State::Draw_State(bool session_type_is_x11) : session_type_is_x11(session_type_is_x11),
                                                    enable_optimizations(true),
                                                    enable_preprocessing(true),
                                                    enable_dithering(true),
                                                    work_factor(1.0)
{
}

Draw_State::Draw_State(bool session_type_is_x11, bool enable_optimizations, bool enable_preprocessing, bool enable_dithering, double work_factor) 
    : session_type_is_x11(session_type_is_x11),
      enable_optimizations(enable_optimizations),
      enable_preprocessing(enable_preprocessing),
      enable_dithering(enable_dithering),
      work_factor(work_factor)
{
}

Draw_State::~Draw_State()
{
    if (chafa_info != nullptr)
    {
        delete chafa_info;
        chafa_info = nullptr;
    }
}