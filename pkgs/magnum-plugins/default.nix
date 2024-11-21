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
  version = "unstable-2024-03-05";

  src = fetchFromGitHub {
    owner = "mosra";
    repo = "magnum-plugins";
    rev = "7dfbea3ed2e24273fde71ccb7cf26b8a48c99cd6";
    hash = "sha256-/sVZXYx4qqbdLk86miVIjv1RqaMTTy14jq7sMP20CIA=";
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
