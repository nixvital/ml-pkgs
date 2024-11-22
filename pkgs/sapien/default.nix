{ lib
, fetchFromGitHub
, cudatoolkit
, autoAddDriverRunpath
, buildPythonPackage
, python3Packages
, pythonRelaxDepsHook
, python
, stdenv
, pkg-config
, gcc12Stdenv
, stdenvAdapters
, cmake
, autoPatchelfHook
, sapien-vulkan-2
, physx5
, physx5-gpu
, glm-sapien
, assimp-sapien
, spdlog
, pinocchio
, openimagedenoise
, vulkan-headers
, vulkan-loader
, pybind-smart-holder
, numpy
, requests
, opencv4
, transforms3d
, pyperclip
, eigen
, cudaSupport ? true
}:
buildPythonPackage rec {
  pname = "sapien";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "haosulab";
    repo = "SAPIEN";
    rev =  "c877626fdefda29b2c33bea64f17830246508f05";
    sha256 = "sha256-8S4GasO+acLYKOQ2l/Ef3B4mecjJwGWaS1zGCR0pTmQ=";
    fetchSubmodules = true;
  };

  stdenv = gcc12Stdenv;

  build-system = with python3Packages; [
    setuptools
  ];

  dontUseCmakeConfigure = true;

  nativeBuildInputs = [
    cmake
    cudatoolkit
    pkg-config

    autoPatchelfHook
    autoAddDriverRunpath
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    vulkan-headers
    vulkan-loader

    pybind-smart-holder
    sapien-vulkan-2
    glm-sapien
    assimp-sapien.dev
    spdlog.dev
    pinocchio

    openimagedenoise
    cudatoolkit

    physx5
    physx5-gpu
    eigen
  ];

  propagatedBuildInputs = [
    numpy
    requests
    opencv4
    transforms3d
    pyperclip
  ];

  patches = [
    ./cmake.patch
    ./py_cmake.patch
    ./pinocchio_cmake.patch
    ./logger.patch
    ./setup.patch
    ./remove_tricks.patch
  ];

  postPatch = ''
    rm -rf 3rd_party/sapien-vulkan-2

    substituteInPlace CMakeLists.txt \
      --replace-fail '$ENV{CUDA_PATH}/include' '"${cudatoolkit}/include"' \
      --replace-fail 'set(CUDA_TOOLKIT_ROOT_DIR $ENV{CUDA_PATH})' 'set(CUDA_TOOLKIT_ROOT_DIR "${cudatoolkit}")' \
      --replace-fail 'libPhysX' '${physx5}/bin/linux.clang/release/libPhysX' \
      --replace-fail 'NIX_PATH_TO_PHYSX5' '${physx5}'

    substituteInPlace setup.py \
      --replace-fail 'os.environ.get("CUDA_PATH")' '"${cudatoolkit}"' \
      --replace-fail 'version = generate_version()' 'version = "3.0.0"'

    substituteInPlace python/py_package/physx/__init__.py \
      --replace-fail 'parent = Path.home() / ".sapien" / "physx" / physx_version' \
        'parent = Path("${physx5-gpu}/lib")' \
      --replace-fail '"libcuda.so"' '"/run/opengl-driver/lib/libcuda.so"'
  '';

  preBuild = ''
    export CUDA_PATH=${cudatoolkit}
  '';

  pythonImportsCheck = [ "sapien" ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/haosulab/SAPIEN";
    description = "A SimulAted Part-based Interactive ENvironment";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
