{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  assimp,
  basis-universal,
  corrade,
  magnum,
  libGL,
}:

stdenv.mkDerivation rec {
  pname = "magnum-plugins";
  version = "unstable-2024-01-07";

  src = fetchFromGitHub {
    owner = "mosra";
    repo = "magnum-plugins";
    rev = "d46a241db0a7313f88f6703ff7ab1246c2135c50";
    hash = "sha256-Lgu2bRKKjQ/K2c1sBK1grTM93ZQ+Q9Sd4Kv67gUQQaY=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    assimp
    corrade
    magnum
    libGL

    # Not using because lacks exports. Only ships an executable in $out/bin
    # basis-universal
  ];

  cmakeFlags = [
    (lib.cmakeBool "MAGNUM_WITH_GLTFIMPORTER" true)
    (lib.cmakeBool "MAGNUM_WITH_STBIMAGEIMPORTER" true)
    (lib.cmakeBool "MAGNUM_WITH_STBIMAGECONVERTER" true)
    (lib.cmakeBool "MAGNUM_WITH_PRIMITIVEIMPORTER" true)
    (lib.cmakeBool "MAGNUM_WITH_STANFORDIMPORTER" true)

    (lib.cmakeBool "MAGNUM_WITH_BASISIMPORTER" true)
    (lib.cmakeFeature "BASIS_UNIVERSAL_DIR" "${basis-universal.src}")

    (lib.cmakeBool "MAGNUM_WITH_ASSIMPIMPORTER" true)
    (lib.cmakeBool "MAGNUM_WITH_KTXIMPORTER" true)
  ];

  meta = with lib; {
    description = "Plugins for the Magnum C++11 graphics engine";
    homepage = "https://github.com/mosra/magnum-plugins";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "magnum-plugins";
    platforms = platforms.all;
  };
}
