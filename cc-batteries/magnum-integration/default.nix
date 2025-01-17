{ lib, stdenv, fetchFromGitHub, cmake, bullet, corrade, eigen, magnum, libGL, }:

stdenv.mkDerivation rec {
  pname = "magnum-integration";
  version = "unstable-2025-01-05";

  src = fetchFromGitHub {
    owner = "mosra";
    repo = "magnum-integration";
    rev = "ed2730d95836fdcbdbb659c5c070bcde2eb07175";
    hash = "sha256-f+NHhqVR0ByDzmfuVPnYllnEqGH14hUSMTeRzE+uhTE=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ (lib.getDev bullet) corrade eigen magnum libGL ];

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
