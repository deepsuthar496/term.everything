export interface QualityConfig {
  workFactor: number;
  enableDithering: boolean;
  enablePreprocessing: boolean;
  enableOptimizations: boolean;
  frameRate: number;
}

export const QUALITY_PRESETS: Record<string, QualityConfig> = {
  "low": {
    workFactor: 0.2,
    enableDithering: false,
    enablePreprocessing: false,
    enableOptimizations: false,
    frameRate: 60,
  },
  "medium": {
    workFactor: 0.5,
    enableDithering: true,
    enablePreprocessing: false,
    enableOptimizations: true,
    frameRate: 45,
  },
  "high": {
    workFactor: 1.0,
    enableDithering: true,
    enablePreprocessing: true,
    enableOptimizations: true,
    frameRate: 30,
  },
  "ultra": {
    workFactor: 1.0,
    enableDithering: true,
    enablePreprocessing: true,
    enableOptimizations: true,
    frameRate: 24,
  },
};

export const parseQualityConfig = (
  qualityPreset?: string,
  workFactor?: string,
  enableDithering?: boolean,
  fps?: string
): QualityConfig => {
  // Start with preset or default to high
  const preset = QUALITY_PRESETS[qualityPreset || "high"] || QUALITY_PRESETS["high"];
  
  const config: QualityConfig = { ...preset };
  
  // Override with specific options if provided
  if (workFactor !== undefined) {
    const factor = parseFloat(workFactor);
    if (!isNaN(factor) && factor >= 0 && factor <= 1) {
      config.workFactor = factor;
    }
  }
  
  if (enableDithering !== undefined) {
    config.enableDithering = enableDithering;
  }
  
  if (fps !== undefined) {
    const fpsValue = parseInt(fps, 10);
    if (!isNaN(fpsValue) && fpsValue > 0 && fpsValue <= 120) {
      config.frameRate = fpsValue;
    }
  }
  
  return config;
};

export const getFrameTimeFromFPS = (fps: number): number => {
  return 1.0 / fps;
};