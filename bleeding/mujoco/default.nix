{ cmake
, fetchFromGitHub
, fetchFromGitLab
, lib
, libGL
, stdenv
, xorg
, glm
, spdlog
, cereal
, assimp
}:

let
  # See https://github.com/deepmind/mujoco/blob/36641cdb2c0cf21360a42ddad54f0c460aa94398/cmake/MujocoDependencies.cmake#L21-L59
  abseil-cpp = fetchFromGitHub {
    owner = "abseil";
    repo = "abseil-cpp";
    rev = "fb3621f4f897824c0dbe0615fa94543df6192f30"; # LTS 20230802.1
    hash = "sha256-uNGrTNg5G5xFGtc+BSWE389x0tQ/KxJQLHfebNWas/k=";
  };
  benchmark = fetchFromGitHub {
    owner = "google";
    repo = "benchmark";
    rev = "refs/tags/v1.8.3";
    hash = "sha256-gztnxui9Fe/FTieMjdvfJjWHjkImtlsHn6fM1FruyME=";
  };
  ccd = fetchFromGitHub {
    owner = "danfis";
    repo = "libccd";
    rev = "refs/tags/v2.1";
    hash = "sha256-TIZkmqQXa0+bSWpqffIgaBela0/INNsX9LPM026x1Wk=";
  };
  eigen3 = fetchFromGitLab {
    owner = "libeigen";
    repo = "eigen";
    rev = "e8515f78ac098329ab9f8cab21c87caede090a3f";
    hash = "sha256-HXKtFJsKGpug+wNPjYynTuyaG0igo3oG4rFQktveh1g=";
  };
  googletest = fetchFromGitHub {
    owner = "google";
    repo = "googletest";
    rev = "v1.14.0";
    hash = "sha256-t0RchAHTJbuI5YW4uyBPykTvcjy90JW9AOPNjIhwh6U=";
  };
  lodepng = fetchFromGitHub {
    owner = "lvandeve";
    repo = "lodepng";
    rev = "b4ed2cd7ecf61d29076169b49199371456d4f90b";
    hash = "sha256-5cCkdj/izP4e99BKfs/Mnwu9aatYXjlyxzzYiMD/y1M=";
  };
  qhull = fetchFromGitHub {
    owner = "qhull";
    repo = "qhull";
    rev = "0c8fc90d2037588024d9964515c1e684f6007ecc";
    sha256 = "sha256-Ptzxad3ewmKJbbcmrBT+os4b4SR976zlCG9F0nq0x94=";
  };
  tinyobjloader = fetchFromGitHub {
    owner = "tinyobjloader";
    repo = "tinyobjloader";
    rev = "1421a10d6ed9742f5b2c1766d22faa6cfbc56248";
    hash = "sha256-9z2Ne/WPCiXkQpT8Cun/pSGUwgClYH+kQ6Dx1JvW6w0=";
  };
  tinyxml2 = fetchFromGitHub {
    owner = "leethomason";
    repo = "tinyxml2";
    rev = "9a89766acc42ddfa9e7133c7d81a5bda108a0ade";
    hash = "sha256-YGAe4+Ttv/xeou+9FoJjmQCKgzupTYdDhd+gzvtz/88=";
  };
  marchingcubecpp = fetchFromGitHub {
    owner = "aparis69";
    repo = "MarchingCubeCpp";
    rev = "5b79e5d6bded086a0abe276a4b5a69fc17ae9bf1";
    hash = "sha256-L0DH1GJZ/3vatQAU/KZj/2xTKE6Fwcw9eQYzLdqX2N4=";
  };
  sdflib = fetchFromGitHub {
    owner = "UPC-ViRVIG";
    repo = "SdfLib";
    rev = "7c49cfba9bbec763b5d0f7b90b26555f3dde8088";
    hash = "sha256-5bnQ3rHH9Pw1jRVpZpamFnhIJHWnGm6krgZgIBqNtVg=";
  };

  # See https://github.com/deepmind/mujoco/blob/573d331b69845c5d651b70f5d1b0f3a0d2a3a233/simulate/cmake/SimulateDependencies.cmake#L32-L35
  glfw = fetchFromGitHub {
    owner = "glfw";
    repo = "glfw";
    rev = "refs/tags/3.3.8";
    hash = "sha256-4+H0IXjAwbL5mAWfsIVhW0BSJhcWjkQx4j2TrzZ3aIo=";
  };
in
stdenv.mkDerivation rec {
  pname = "mujoco";
  version = "3.1.3";

  src = fetchFromGitHub {
    owner = "deepmind";
    repo = pname;
    rev = version;
    hash = "sha256-22yH3zAD479TRNS3XSqy6PuuLqyWmjvwScUTVfKumzY=";
  };

  patches = [ ./dependencies.patch ];

  nativeBuildInputs = [ cmake ];

  buildInputs = [
    libGL
    xorg.libX11
    xorg.libXcursor
    xorg.libXext
    xorg.libXi
    xorg.libXinerama
    xorg.libXrandr
    glm
    spdlog
    cereal
    assimp
  ];

  # Move things into place so that cmake doesn't try downloading dependencies.
  preConfigure = ''
    mkdir -p build/_deps
    ln -s ${abseil-cpp} build/_deps/abseil-cpp-src
    ln -s ${benchmark} build/_deps/benchmark-src
    ln -s ${ccd} build/_deps/ccd-src
    ln -s ${eigen3} build/_deps/eigen3-src
    # The target directory should be named glfw3 because of the following commit
    # https://github.com/deepmind/mujoco/commit/ca70d8bfaf2a088b94b382528aa14ebb54792739
    ln -s ${glfw} build/_deps/glfw3-src
    ln -s ${googletest} build/_deps/googletest-src
    ln -s ${lodepng} build/_deps/lodepng-src
    ln -s ${qhull} build/_deps/qhull-src
    ln -s ${tinyobjloader} build/_deps/tinyobjloader-src
    ln -s ${tinyxml2} build/_deps/tinyxml2-src
    ln -s ${marchingcubecpp} build/_deps/marchingcubecpp-src
    ln -s ${sdflib} build/_deps/sdflib-src
  '';

  cmakeFlags = [
    "-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE"
    "-DSDFLIB_USE_SYSTEM_GLM=ON"
    "-DSDFLIB_USE_SYSTEM_SPDLOG=ON"
    "-DSDFLIB_USE_SYSTEM_CEREAL=ON"
    "-DSDFLIB_USE_SYSTEM_ASSIMP=ON"
  ];

  meta = with lib; {
    description = "Multi-Joint dynamics with Contact. A general purpose physics simulator.";
    homepage = "https://mujoco.org/";
    license = licenses.asl20;
    maintainers = with maintainers; [ samuela ];
  };
}
