{ lib,
  llvmPackages,
  fetchFromGitHub,
  cmake,
  spirv-tools,
}:

let pname = "taichi";
    version = "1.7.2";
    stdenv = llvmPackages.stdenv;

in stdenv.mkDerivation {
  inherit pname version;

  # src = fetchFromGitHub {
  #   owner = "taichi-dev";
  #   repo = "taichi";
  #   rev = "v${version}";
  #   hash = "sha256-2mZYYlfPwaO8t3uShbGSq1GhND9TAkO+9wN4tYcm6/E=";
  # };

  src = /home/breakds/projects/other/taichi;

  nativeBuildInputs = [ cmake llvmPackages.llvm ];

  buildInputs = [
    spirv-tools
  ];

  cmakeFlags = [
    # TODO(breakds): Enable those
    "-DTI_WITH_PYTHON=OFF"
    "-DTI_WITH_CUDA=OFF"
  ];

  meta = with lib; {
    description = "Productive & portable high-performance programming in Python";
    homepage = "https://github.com/taichi-dev/taichi";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
    platforms = platforms.all;
  };
}
