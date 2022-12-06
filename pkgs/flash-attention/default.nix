{ lib
, buildPythonPackage
, symlinkJoin
, fetchFromGitHub
, which
, ninja
, python
, torch
}:

let inherit (torch.cudaPackages) cudatoolkit cudnn;

    cudatoolkit_joined = symlinkJoin {
      name = "${cudatoolkit.name}-unsplit";
      paths = [ cudatoolkit.out cudatoolkit.lib ];
    };
    
    cudaArchStr = lib.strings.concatStringsSep ";" torch.cudaArchList;

in buildPythonPackage rec {
  pname = "flash-attention";
  version = "0.2.2";

  # src = fetchFromGitHub {
  #   owner = "HazyResearch";
  #   repo = "flash-attention";
  #   rev = "v${version}";
  #   sha256 = "sha256-X6eAHbpdk1dAeS9awS8xMZ7eTlpQeKS6iKdCPyEGcHU=";
  # };

  src = /home/breakds/projects/other/flash-attention;

  # NOTE: here we need `which` because in order to access
  # torch.utils.cpp_extensions.CUDA_HOME, it requires this to perform the path
  # deduction. Learned this trick from how torchvision is packaged.
  nativeBuildInputs = [
    ninja which cudatoolkit_joined
  ];

  buildInputs = [
    cudnn
  ];

  propagatedBuildInputs = [
    torch
  ];

  preConfigure = ''
    export TORCH_CUDA_ARCH_LIST="${cudaArchStr}"
    export FORCE_CUDA=1
    export CC=${cudatoolkit.cc}/bin/gcc CXX=${cudatoolkit.cc}/bin/g++
  '';

  meta = with lib; {
    homepage = "https://github.com/HazyResearch/flash-attention";
    description = ''
      Fast and memory-efficient exact attention
    '';
    license = licenses.bsd3;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
