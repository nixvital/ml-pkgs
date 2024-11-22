{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  bullet,
  corrade,
  eigen,
  magnum,
  libGL,
}:

stdenv.mkDerivation rec {
  pname = "magnum-integration";
  version = "unstable-2024-03-07";

  src = fetchFromGitHub {
    owner = "mosra";
    repo = "magnum-integration";
    rev = "d0aab18311083a35a2372d71c3760d652d2e4849";
    hash = "sha256-eRmMFg5YUr4GPrv2y6O4Q0hT/1xgJk8p7ATR0rsE0X0=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    (lib.getDev bullet)
    corrade
    eigen
    magnum
    libGL
  ];

  cmakeFlags = [
    (lib.cmakeBool "MAGNUM_WITH_EIGEN" true)
    (lib.cmakeBool "MAGNUM_WITH_BULLET" true)
  ];

  meta = with lib; {
    description = "Integration libraries for the Magnum C++11 graphics engine";
    homepage = "https://github.com/mosra/magnum-integration";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "magnum-integration";
    platforms = platforms.all;
  };
}
