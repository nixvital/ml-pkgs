{ lib
, symlinkJoin
, buildPythonPackage
, fetchFromGitHub
, torch
, einops
, ninja
, packaging
}:

let cudaPackages = torch.cudaPackages;

    cudaVersion = cudaPackages.cudaVersion;
    
    cuda-native-redist = symlinkJoin {
      name = "cuda-native-redist-${cudaVersion}";
      paths = with cudaPackages; [
        cuda_cudart
        cuda_nvcc
      ];
    };

in buildPythonPackage {
  pname = "flash-attn";
  version = "2.0.0.post1";

  src = fetchFromGitHub {
    owner = "Dao-AILab";
    repo = "flash-attention";
    rev = "9ee0ff1d9b6a99630e2a6868b9291dfa32d35abd";
    hash = "sha256-lVFtn04ekMcP7LDH82/UGvOvLBabwZTGbt4eLLaLkmM=";
  };

  nativeBuildInputs = [
    ninja
    cuda-native-redist
  ];

  buildInputs = [
    packaging
  ];

  propagatedBuildInputs = [
    torch einops
  ];

  pythonImportsCheck = [ "flash_attn" ];
}
