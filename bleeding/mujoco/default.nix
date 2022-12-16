{ cmake
, fetchFromGitHub
, fetchFromGitLab
, git
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
    rev = "8c0b94e793a66495e0b1f34a5eb26bd7dc672db0";
    hash = "sha256-Od1FZOOWEXVQsnZBwGjDIExi6LdYtomyL0STR44SsG8=";
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
    rev = "3bb6a48d8c171cf20b5f8e48bfb4e424fbd4f79e";
    hash = "sha256-k71DoEsx8JpC9AlQ0cCRI0fWMIWFBFL/Yscx+2iBtNM=";
  };
  googletest = fetchFromGitHub {
    owner = "google";
    repo = "googletest";
    rev = "refs/tags/release-1.12.1";
    hash = "sha256-W+OxRTVtemt2esw4P7IyGWXOonUN5ZuscjvzqkYvZbM=";
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
    rev = "refs/tags/9.0.0";
    hash = "sha256-AQQOctXi7sWIH/VOeSUClX6hlm1raEQUOp+VoPjLM14=";
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
  version = "2.3.1";

  src = fetchFromGitHub {
    owner = "deepmind";
    repo = pname;
    rev = version;
    hash = "sha256-Bh+08AZWVocv+F3jpJ6ckZS4AQRB/+LNFr+p74BlJoA=";
  };

  patches = [ ./dependencies.patch ];

  nativeBuildInputs = [ cmake git ];

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
    ln -s ${glfw} build/_deps/glfw-src
    ln -s ${googletest} build/_deps/googletest-src
    ln -s ${lodepng} build/_deps/lodepng-src
    ln -s ${qhull} build/_deps/qhull-src
    ln -s ${tinyobjloader} build/_deps/tinyobjloader-src
    ln -s ${tinyxml2} build/_deps/tinyxml2-src
  '';

  meta = with lib; {
    description = "Multi-Joint dynamics with Contact. A general purpose physics simulator.";
    homepage = "https://mujoco.org/";
    license = licenses.asl20;
    maintainers = with maintainers; [ samuela ];
  };
}
