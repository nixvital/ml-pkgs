{ lib
, fetchFromGitHub
# , cudaPackages_11
# , cudaPackages
, cudatoolkit
, autoAddDriverRunpath
, buildPythonPackage
, python3Packages
, pythonRelaxDepsHook
, python
, stdenv
, gcc12Stdenv
, stdenvAdapters
, physx5
, physx5-gpu
, cmake
, autoPatchelfHook
, numpy
, requests
, opencv4
, transforms3d
, pyperclip
, vulkan-headers
, vulkan-loader
, eigen
, openimagedenoise
, cudaSupport ? true
}:
let
  pybind-smart-holder = python3Packages.pybind11.overrideAttrs {
    src = fetchFromGitHub {
      owner = "pybind";
      repo = "pybind11";
      rev = "smart_holder";
      hash = "";
    };
  };
in
buildPythonPackage rec {
  pname = "sapien";
  version = "dev";

  src = fetchFromGitHub {
    owner = "howird";
    repo = "SAPIEN";
    rev =  "c877626fdefda29b2c33bea64f17830246508f05";
    sha256 = "sha256-8S4GasO+acLYKOQ2l/Ef3B4mecjJwGWaS1zGCR0pTmQ=";
    fetchSubmodules = true;
  };

  stdenv = gcc12Stdenv;

  build-system = with python3Packages; [
    setuptools
  ];

  propagatedBuildInputs = [
    numpy
    requests
    opencv4
    transforms3d
    pyperclip
  ];

  pythonRemoveDeps = [ "opencv-python" ];

  dontUseCmakeConfigure = true;

  nativeBuildInputs = [
    cmake
    pybind-smart-holder
    autoPatchelfHook
    pythonRelaxDepsHook
    autoAddDriverRunpath
  ];

  patches = [
    ./remove_includes.patch
  ];

  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace-fail '$ENV{CUDA_PATH}/include' '"${cudatoolkit}/include"' \
      --replace-fail 'set(CUDA_TOOLKIT_ROOT_DIR $ENV{CUDA_PATH})' 'set(CUDA_TOOLKIT_ROOT_DIR "${cudatoolkit}")' \
      --replace-fail '$ENV{CUDA_PATH}/lib64' '"${cudatoolkit}/lib"'

    substituteInPlace setup.py \
      --replace-fail 'os.environ.get("CUDA_PATH")' '"${cudatoolkit}"'

    substituteInPlace python/py_package/physx/__init__.py \
      --replace-fail 'parent = Path.home() / ".sapien" / "physx" / physx_version' '${physx5-gpu}/lib'
  '';

  preBuild = ''
    export CUDA_PATH=${cudatoolkit}
  '';

  buildInputs = [
    stdenv.cc.cc.lib
    vulkan-headers
    vulkan-loader
    openimagedenoise
    cudatoolkit
    physx5
    physx5-gpu
    eigen
  ];

  cmakeFlags = [
    "-DCUDA_TOOLKIT_ROOT_DIR=${cudatoolkit}"
    "-DSAPIEN_CUDA=ON"
    "-DSAPIEN_PHYSX5_DIR=${physx5}"
  ];

  # # This is important, otherwise it will report ELF load command
  # # address/offset not page-aligned.
  # dontStrip = true;

  meta = with lib; {
    homepage = "https://github.com/haosulab/SAPIEN";
    description = ''
      A SimulAted Part-based Interactive ENvironment
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
