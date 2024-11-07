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
, patchelf
, stdenv
, pkg-config
, gcc12Stdenv
, stdenvAdapters
, sapien-vulkan-2
, physx5
, physx5-gpu
, cmake
, glm
, assimp
, spdlog
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
      rev = "3b35ce475fa359abc31d979972f650c601d6158b";
      hash = "sha256-zgWTcgO0BvCOjFrNPrLTi0JXedhW2Oai1qwf5DA7e6A=";
    };
    postPatch = "";
  };
  glm-sapien = glm.overrideAttrs {
    src = fetchFromGitHub {
      owner = "g-truc";
      repo = "glm";
      rev = "0.9.9.8";
      hash = "sha256-F//+3L5Ozrw6s7t4LrcUmO7sN30ZSESdrPAYX57zgr8=";
    };
  };
  assimp-sapien = assimp.overrideAttrs {
    src = fetchFromGitHub {
      owner = "fbxiang";
      repo = "assimp";
      rev = "0ea31aa6734336dc1e62c6d9bde3e49b6d71b811";
      sha256 = "sha256-IqF46UQNGQ/EZJ/D0SsOqp+Tyn5oSNtunNx0lxaTRGE=";
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
    cudatoolkit
    pkg-config

    pybind-smart-holder
    autoPatchelfHook
    pythonRelaxDepsHook
    autoAddDriverRunpath

    patchelf
  ];

  patches = [
    ./remove_includes.patch
    ./logger_fixes.patch
    ./setup.patch
  ];

  postPatch = ''
    rm -rf 3rd_party/sapien-vulkan-2

    substituteInPlace CMakeLists.txt \
      --replace-fail '$ENV{CUDA_PATH}/include' '"${cudatoolkit}/include"' \
      --replace-fail 'set(CUDA_TOOLKIT_ROOT_DIR $ENV{CUDA_PATH})' \
                     'set(CUDA_TOOLKIT_ROOT_DIR "${cudatoolkit}")' \
      --replace-fail 'NIX_PATH_TO_SVULKAN2' '${sapien-vulkan-2}' \
      --replace-fail 'libPhysX' '${physx5}/bin/linux.clang/release/libPhysX' \
      --replace-fail 'NIX_PATH_TO_PHYSX5' '${physx5}'

    substituteInPlace setup.py \
      --replace-fail 'os.environ.get("CUDA_PATH")' '"${cudatoolkit}"' \
      --replace-fail 'version = generate_version()' 'version = "3.0.0"'

    # skip pinnochio build TODO: build it
    substituteInPlace setup.py \
      --replace-fail 'self.build_pinocchio(ext)' 'pass'

    # substituteInPlace python/py_package/__init__.pyi --replace-fail '3.0.0.dev20240521+6b6d61d2' '3.0.0'

    substituteInPlace python/py_package/physx/__init__.py \
      --replace-fail 'parent = Path.home() / ".sapien" / "physx" / physx_version' '"${physx5-gpu}/lib"'
  '';

  preBuild = ''
    export CUDA_PATH=${cudatoolkit}
  '';

  buildInputs = [
    stdenv.cc.cc.lib
    vulkan-headers
    vulkan-loader

    sapien-vulkan-2
    glm-sapien
    assimp-sapien.dev
    spdlog.dev

    openimagedenoise
    cudatoolkit

    physx5
    physx5-gpu
    eigen
  ];

  doCheck = false;
  # does not work since setup.py sets the cmake flags
  # cmakeFlags = [
  #   "-DCUDA_TOOLKIT_ROOT_DIR=${cudatoolkit}"
  #   "-DSAPIEN_CUDA=ON"
  #   # "-DSAPIEN_PHYSX5_DIR=${physx5}"
  #   "-Dphysx_SOURCE_DIR=${physx5}"
  # ];

  meta = with lib; {
    homepage = "https://github.com/haosulab/SAPIEN";
    description = "A SimulAted Part-based Interactive ENvironment";
    # license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
