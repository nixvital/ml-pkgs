{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:

stdenv.mkDerivation rec {
  pname = "basis-universal";
  version = "1_15_update2";

  # Breaks magnum-plugins with every update, follow
  # https://github.com/mosra/archlinux/blob/36275b5aea5e1521735b5da7819aea9ce1300976/basis-universal-src/PKGBUILD
  src = fetchFromGitHub {
    owner = "BinomialLLC";
    repo = "basis_universal";
    rev = "v${version}";
    hash = "sha256-2snzq/SnhWHIgSbUUgh24B6tka7EfkGO+nwKEObRkU4=";
  };

  nativeBuildInputs = [ cmake ];

  meta = with lib; {
    description = "Basis Universal GPU Texture Codec";
    homepage = "https://github.com/BinomialLLC/basis_universal";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
    mainProgram = "basis-universal";
    platforms = platforms.all;
  };
}
