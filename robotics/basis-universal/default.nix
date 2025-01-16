{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:

let version = "1.16.4";
    rev = "1.16.4";

in stdenv.mkDerivation {
  pname = "basis-universal";
  inherit version;

  # Breaks magnum-plugins with every update, follow
  # https://github.com/mosra/archlinux/blob/36275b5aea5e1521735b5da7819aea9ce1300976/basis-universal-src/PKGBUILD
  src = fetchFromGitHub {
    owner = "BinomialLLC";
    repo = "basis_universal";
    rev = "${rev}";
    hash = "sha256-pKvfVvdbPIdzdSOklicThS7xwt4i3/21bE6wg9f8kHY=";
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
