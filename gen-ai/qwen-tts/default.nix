{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  wheel,
  # dependencies (for 12Hz model inference)
  transformers,
  accelerate,
  librosa,
  torchaudio,
  soundfile,
  onnxruntime,
  einops,
  # optional
  gradio,
}:

buildPythonPackage rec {
  pname = "qwen-tts";
  version = "2025.01.25";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "QwenLM";
    repo = "Qwen3-TTS";
    rev = "1ab0dd75353392f28a0d05d9ca960c9954b13c83";
    hash = "sha256-7I75us9OdIsqgH2Nj3v1M/e7autR2OStjTb+xx4+/Pw=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    transformers
    accelerate
    librosa
    torchaudio
    soundfile
    onnxruntime
    einops
  ];

  optional-dependencies = {
    demo = [ gradio ];
    # 25hz-tokenizer requires sox (pysox), which is not in nixpkgs yet
  };

  pythonRelaxDeps = [
    "transformers"
    "accelerate"
  ];

  # gradio: only needed for the web demo (qwen_tts/cli/demo.py)
  # sox: only needed for the 25Hz tokenizer (not the 12Hz models)
  pythonRemoveDeps = [
    "gradio"
    "sox"
  ];

  pythonImportsCheck = [ "qwen_tts" ];

  meta = {
    description = "Qwen3-TTS: Open-source text-to-speech system with voice cloning and voice design";
    homepage = "https://github.com/QwenLM/Qwen3-TTS";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
