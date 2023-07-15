{ cmake
, fetchFromGitHub
, fetchFromGitLab
, lib
, libGL
, stdenv
, xorg
}:

let
  # See https://github.com/deepmind/mujoco/blob/36641cdb2c0cf21360a42ddad54f0c460aa94398/cmake/MujocoDependencies.cmake#L21-L59
  abseil-cpp = fetchFromGitHub {
    owner = "abseil";
    repo = "abseil-cpp";
    rev = "c8a2f92586fe9b4e1aff049108f5db8064924d8e";  # LTS 20230125.1
    sha256 = "sha256-/OdFqE0gKl5gyeXeVdvpN6OlKqbyfBszwbp/gf1FtOs=";
  };
  benchmark = fetchFromGitHub {
    owner = "google";
    repo = "benchmark";
    rev = "refs/tags/v1.7.1";
    hash = "sha256-gg3g/0Ki29FnGqKv9lDTs5oA9NjH23qQ+hTdVtSU+zo=";
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
    rev = "3460f3558e7b469efb8a225894e21929c8c77629";
    hash = "sha256-0qX7JjkroQkxJ5K442R7y1RDVoxvjWmGceqZz+8CB6A=";
  };
  googletest = fetchFromGitHub {
    owner = "google";
    repo = "googletest";
    rev = "v1.13.0";
    hash = "sha256-LVLEn+e7c8013pwiLzJiiIObyrlbBHYaioO/SWbItPQ=";
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
  version = "2.3.6";

  src = fetchFromGitHub {
    owner = "deepmind";
    repo = pname;
    rev = version;
    hash = "sha256-BhEiaYeGtkN9me5D0h6IPMykOtH7FOV7tI0R67YMpSI=";
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
  '';

  cmakeFlags = [
    "-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE"
  ];

  meta = with lib; {
    description = "Multi-Joint dynamics with Contact. A general purpose physics simulator.";
    homepage = "https://mujoco.org/";
    license = licenses.asl20;
    maintainers = with maintainers; [ samuela ];
  };
}
