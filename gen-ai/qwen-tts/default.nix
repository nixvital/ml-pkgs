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
  einops,
  # optional
  gradio,
}:

buildPythonPackage rec {
  pname = "qwen-tts";
  version = "2025.01.25";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "breakds";
    repo = "Qwen3-TTS";
    rev = "e86eca5d62740a964eef05d29316f1f173c75590";
    hash = "sha256-fH4LLEXkajFFARSuFIk3KtPe8CLdztSydgLG6Craltk=";
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
    "onnxruntime"
  ];

  pythonImportsCheck = [ "qwen_tts" ];

  meta = {
    description = "Qwen3-TTS: Open-source text-to-speech system with voice cloning and voice design";
    homepage = "https://github.com/QwenLM/Qwen3-TTS";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
