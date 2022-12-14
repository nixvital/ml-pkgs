{ lib
, llvmPackages
, cmake
, fetchFromGitHub
, python3
, cudaPackages
, ispc
}:

llvmPackages.stdenv.mkDerivation rec {
  pname = "libopen3d";
  version = "0.16.1";

  src = fetchFromGitHub {
    owner = "isl-org";
    repo = "Open3D";
    rev = "v${version}";
    hash = "sha256-Tr9t5B1IdTzvc47Me2r9Od6IzB4ctChE9xhi2oxl1iU=";
  };

  buildInputs = [
    python3
    cudaPackages.cudatoolkit
    ispc
  ];

  nativeBuildInputs = [ cmake ];
  cmakeFlags = [
    "-DBUILD_PYTHON_MODULE=ON"
    "-DBUILD_CUDA_MODULE=ON"
    "-DBUILD_COMMON_CUDA_ARCHS=ON"
    "-BUILD_PYTORCH_OPS=ON"
    "-BUILD_TENSORFLOW_OPS=OFF"
  ];

  meta = with lib; {
    description = "Open3D: A Modern Library for 3D Data Processing";
    homepage = "http://www.open3d.org/";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
