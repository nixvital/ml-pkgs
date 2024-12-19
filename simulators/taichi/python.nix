{ lib,
  buildPythonPackage,
  cmake,
  setuptools,
  llvmPackages,
  colorama,
  pybind11,
  scikit-build,
  numpy,
  ninja,
  glad2,
}:

let pname = "taichi";
    version = "1.7.2";

in buildPythonPackage {
  inherit pname version;
  pyproject = true;

  src = /home/breakds/projects/other/taichi;

  build-system = [ cmake setuptools llvmPackages.clang scikit-build ninja ];
  dontUseCmakeConfigure = true;

  cmakeFlags = [
    "-DTI_WITH_METAL=OFF"
  ];

  buildInputs = [
    llvmPackages.llvm 
  ];

  dependencies = [
    pybind11
    colorama
    numpy
    glad2
  ];

  meta = with lib; {
    description = "Productive & portable high-performance programming in Python";
    homepage = "https://github.com/taichi-dev/taichi";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
    platforms = platforms.all;
  };
}
