# Watch https://www.youtube.com/watch?v=WZGNCPBMInI

{ lib, stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "eve";
  version = "2024.11.28";

  src = fetchFromGitHub {
    owner = "jfalcou";
    repo = "eve";
    rev = "d56b7d66d2c7772be0b59d8ad6567680916c6ce4";
    hash = "sha256-qp9TCaXvvZVrrgdU1I2SRASOVXLjmGLZqKMZ/Ls1ti8=";
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags = [
    "-DEVE_BUILD_TEST=OFF"
    "-DEVE_BUILD_BENCHMARKS=OFF"
    "-DEVE_BUILD_DOCUMENTATION=OFF"
  ];

  meta = with lib; {
    description = "EVE - the Expressive Vector Engine in C++20.";
    homepage = "https://github.com/jfalcou/eve";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
