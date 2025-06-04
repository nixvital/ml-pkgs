{ lib
  , callPackage
  , buildPythonPackage
  , scikit-build-core
  , cmake
  , ninja
  , torch
  , cudaPackages
}:

let
  pname = "sgl-kernel";
  version = "0.1.4";
  bundle = callPackage ./src.nix {};

in buildPythonPackage {
  inherit pname version;
  pyproject = true;

  # src = bundle.sglang;
  # sourceRoot = "${bundle.sglang.name}/${pname}";
  src = /home/breakds/projects/other/sglang;
  sourceRoot = "sglang/sgl-kernel";


  build-system = [
    scikit-build-core
  ];

  nativeBuildInputs = [
    cmake
    ninja
    (lib.getBin cudaPackages.cuda_nvcc)
  ];

  buildInputs = [
    cudaPackages.cuda_cudart
    cudaPackages.cudatoolkit
  ];

  dependencies = [
    torch
  ];

  dontUseCmakeConfigure = true;

  # cmakeFlags = [
  #   (lib.cmakeFeature "FETCHCONTENT_SOURCE_DIR_REPO-CUTLASS" "${bundle.cutlass}")
  # ];

  pypaBuildFlags = [
    "--config-setting=cmake.define.FETCHCONTENT_SOURCE_DIR_REPO-CUTLASS=${bundle.cutlass}"
    "--config-setting=cmake.define.FETCHCONTENT_SOURCE_DIR_REPO-DEEPGEMM=${bundle.deepgemm}"
    "--config-setting=cmake.define.FETCHCONTENT_SOURCE_DIR_REPO-FLASHINFER=${bundle.flashinfer}"
    "--config-setting=cmake.define.FETCHCONTENT_SOURCE_DIR_REPO-FLASH-ATTENTION=${bundle.flash-attention}"
  ];

  pythonImportsCheck = [ "sgl_kernel" ];

  meta = with lib; {
    homepage = "https://github.com/sgl-project/sglang/tree/main/sgl-kernel";
    description = "Kernel Library for SGLang";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
