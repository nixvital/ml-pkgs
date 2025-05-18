{ lib,
  buildPythonPackage,
  symlinkJoin,
  fetchFromGitHub,
  setuptools,
  cmake,
  ninja,
  numpy,
  torch
}:

assert torch.cudaSupport;

let
  pname = "flashinfer";
  version = "0.2.5";

  inherit (torch) cudaPackages;
  inherit (cudaPackages) cudaMajorMinorVersion;

  cudaMajorMinorVersionString = lib.replaceStrings [ "." ] [ "" ] cudaMajorMinorVersion;

  # cuda-native-redist = symlinkJoin {
  #   name = "cuda-native-redist-${cudaMajorMinorVersion}";
  #   paths = with cudaPackages; [
  #     cuda_nvcc
  #     cudatoolkit
  #   ];
  # };

in buildPythonPackage {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "flashinfer-ai";
    repo = "flashinfer";
    rev = "v${version}";
    hash = "sha256-YrYfatkI9DQkFEEGiF8CK/bTafaNga4Ufyt+882C0bQ=";
  };

  build-system = [ setuptools ];

  nativeBuildInputs = [
    cmake
    ninja
    cudaPackages.cudatoolkit
  ];
  dontUseCmakeConfigure = true;

    # FlashInfer offers two installation modes:
  #
  # JIT mode: CUDA kernels are compiled at runtime using PyTorch’s JIT, with
  # compiled kernels cached for future use. JIT mode allows fast installation,
  # as no CUDA kernels are pre-compiled, making it ideal for development and
  # testing. JIT version is also available as a sdist in PyPI.
  # 
  # AOT mode: Core CUDA kernels are pre-compiled and included in the library,
  # reducing runtime compilation overhead. If a required kernel is not
  # pre-compiled, it will be compiled at runtime using JIT. AOT mode is
  # recommended for production environments.
  #
  # Here we use opt for the AOT version.
  preConfigure = ''
    export FLASHINFER_ENABLE_AOT=1
    export TORCH_NVCC_FLAGS="--maxrregcount=64"
  '';

  CUDA_HOME = "${cuda-native-redist}";
  TORCH_CUDA_ARCH_LIST = "${lib.concatStringsSep ";" torch.cudaCapabilities}";

  dependencies = [
    numpy
    torch
  ];

  meta = with lib; {
    homepage = "https://flashinfer.ai/";
    description = '';
      FlashInfer is a library and kernel generator for Large Language Models
      that provides high-performance implementation of LLM GPU kernels such as
      FlashAttention, PageAttention and LoRA. FlashInfer focus on LLM serving
      and inference, and delivers state-of-the-art performance across diverse
      scenarios.
    '';
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
