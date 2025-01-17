{ lib, stdenv, fetchFromGitHub, cmake, corrade, libGL, xorg, }:

stdenv.mkDerivation rec {
  pname = "magnum";
  version = "unstable-2025-01-08";

  src = fetchFromGitHub {
    owner = "mosra";
    repo = "magnum";
    rev = "e43eba68dbba3797a6fb477f30efa1f3788f139b";
    hash = "sha256-C60QeSBk5q3mCZWGBOkEt0kx4ftjAGw4DZIKVSqza9w=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    corrade
    libGL # A shim that resolves into libglvnd on Linux
  ] ++ lib.optionals stdenv.hostPlatform.isUnix [ xorg.libX11 ];

  cmakeFlags = [
    (lib.cmakeBool "MAGNUM_WITH_ANYIMAGEIMPORTER" true)
    (lib.cmakeBool "MAGNUM_WITH_ANYSCENEIMPORTER" true)
    (lib.cmakeBool "MAGNUM_WITH_ANYIMAGECONVERTER" true)
    (lib.cmakeBool "MAGNUM_WITH_WINDOWLESSGLXAPPLICATION" true)
  ];

  meta = with lib; {
    description =
      "Lightweight and modular C++11 graphics middleware for games and data visualization";
    homepage = "https://github.com/mosra/magnum";
    license = licenses.mit;
    maintainers = with maintainers; [ SomeoneSerge ];
    mainProgram = "magnum";
    platforms = platforms.all;
  };
}
