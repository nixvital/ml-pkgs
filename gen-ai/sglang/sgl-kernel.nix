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

  src = bundle.sglang;
  sourceRoot = "${bundle.sglang.name}/${pname}";

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
  ];

  dependencies = [
    torch
  ];
  
  dontUseCmakeConfigure = true;

  pythonImportsCheck = [ "sgl_kernel" ];

  meta = with lib; {
    homepage = "https://github.com/sgl-project/sglang/tree/main/sgl-kernel";
    description = "Kernel Library for SGLang";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}

