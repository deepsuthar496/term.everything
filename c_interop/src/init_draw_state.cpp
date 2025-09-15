#include "init_draw_state.h"

#include "Draw_State.h"

Value init_draw_state_js(const CallbackInfo &info)
{
  auto env = info.Env();

  auto session_type_is_x11 = info[0].As<Boolean>().Value();
  
  // Default quality config
  bool enable_optimizations = true;
  bool enable_preprocessing = true; 
  bool enable_dithering = true;
  double work_factor = 1.0;
  
  // Parse quality config if provided
  if (info.Length() > 1 && info[1].IsObject()) {
    auto quality_config = info[1].As<Object>();
    
    if (quality_config.Has("enableOptimizations")) {
      enable_optimizations = quality_config.Get("enableOptimizations").As<Boolean>().Value();
    }
    if (quality_config.Has("enablePreprocessing")) {
      enable_preprocessing = quality_config.Get("enablePreprocessing").As<Boolean>().Value();
    }
    if (quality_config.Has("enableDithering")) {
      enable_dithering = quality_config.Get("enableDithering").As<Boolean>().Value();
    }
    if (quality_config.Has("workFactor")) {
      work_factor = quality_config.Get("workFactor").As<Number>().DoubleValue();
    }
  }

  auto draw_state = External<Draw_State>::New(
      env, new Draw_State(session_type_is_x11, enable_optimizations, enable_preprocessing, enable_dithering, work_factor),
      [](Napi::Env env, Draw_State *data)
      { delete data; });
  return draw_state;
}
