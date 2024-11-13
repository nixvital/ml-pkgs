{ lib
, stdenv
, pkgs
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, setuptools
, cmake
, git
, glibc
, musl
, libcxxStdenv
, libcxx
, pybind11
, python3Packages
, libclang
, numpy
, toppra
, transforms3d
, setuptools-git-versioning
, boost
, ompl
, fcl
, pinocchio
, urdfdom
, assimp
, orocos-kdl
}:

buildPythonPackage rec {
  pname = "mplib";
  version = "0.2.1";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "haosulab";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-2p29m+gu0rMcYyB/UdfwweLAYo0HNR/cBovZZra+Puw=";
  };

  build-system = [
    setuptools
    libclang
    git
    setuptools-git-versioning
  ];

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    pybind11
    # pkgs.libclang
    # libcxx
    # glibc
    pkgs.libclang.dev
    libcxx.dev
    # stdenv.cc.cc
    # libcxxStdenv.cc
    # glibc.dev
    # musl.dev
  ];

  # TODO: docstrings not working
  patches = [
    ./docstrings.patch
  ];

  postPatch = ''
    sed -i 's|add_subdirectory("''${CMAKE_CURRENT_SOURCE_DIR}/third_party/pybind11")|find_package(pybind11 REQUIRED)|' CMakeLists.txt

    substituteInPlace pyproject.toml \
      --replace-fail "libclang==11.0.1" "clang"
    
    # TODO: docstrings not working
    # substituteInPlace dev/mkdoc.py \
    #   --replace-fail 'cpp_dirs = []  #' "#" \
    #   --replace-fail '"/usr/include/c++/*"' '"${stdenv.cc.cc}/include/c++/*"' \
    #   --replace-fail '"/usr/include/%s-linux-gnu/c++/*"' '"${stdenv.cc.cc}/include/c++/*/%s-unknown-linux-gnu"' \
    #   --replace-fail '"/usr/include"' 'next(iter(glob("${stdenv.cc.cc}/include/c++/*/parallel")))' \
    #   --replace-fail '"/usr/include/%s-linux-gnu" % platform.machine()' 'next(iter(glob("${stdenv.cc.cc}/include/c++/*/tr1")))'
  '';

  preBuild = ''
    cd ..
    export LLVM_DIR_PATH=${pkgs.libclang.lib}
    export LIBCLANG_PATH=${pkgs.libclang.lib}/lib/libclang.so
    export CLANG_INCLUDE_DIR=${pkgs.libclang.dev}/include
    # export CPP_INCLUDE_DIRS="${pinocchio}/include"
  '';

  propagatedBuildInputs = [
    numpy
    toppra
    transforms3d

    boost
    ompl
    fcl
    pinocchio
    urdfdom
    assimp
    orocos-kdl
  ];

  meta = with lib; {
    description = "a Lightweight Motion Planning Package";
    homepage = "https://motion-planning-lib.readthedocs.io/";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
