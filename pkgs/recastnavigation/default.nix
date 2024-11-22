{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchpatch,
  cmake,
  SDL2,
  libGLU,
}:

stdenv.mkDerivation rec {
  pname = "recastnavigation";
  version = "1.6.0";

  src = fetchFromGitHub {
    owner = "recastnavigation";
    repo = "recastnavigation";
    rev = "v${version}";
    hash = "sha256-SNaGXm50n+7ZM6c4lgUnQYZDoEBdCajkDyYtcisev2U=";
  };

  patches = [
    ./0001-CMake-fix-write-correct-install-paths-in-the-.pc.patch

    # "Adds multi start shortest path ..."
    (fetchpatch {
      url = "https://github.com/recastnavigation/recastnavigation/commit/71db2688f2909e920aa95f806676a4983c9e0f2a.patch";
      hash = "sha256-F2p18hvBycyVqp5C6kw52V9N2NVmffM7wwT845ZO8wE=";
    })

    # "Hacky fix for ESP hot fix"
    (fetchpatch {
      url = "https://github.com/recastnavigation/recastnavigation/commit/c1a0c3282e4ac7475257cfa208f200e064477884.patch";
      hash = "sha256-JLU39Cgss3nWXy6L/8x02tz4+pM9vjap6RW4XiRdvx8=";
    })

    # "No sliding try step"
    (fetchpatch {
      url = "https://github.com/recastnavigation/recastnavigation/commit/43d050d0326c8d47c1de615103d2fb9ac01f426b.patch";
      hash = "sha256-o/+vcve2aSJYFa5nMeeRICotKXpidTIBTfHhE+32wDM=";
    })

    # "habitat: unbreak signature mismatch"
    (fetchpatch {
      url = "https://github.com/recastnavigation/recastnavigation/commit/8e634a30b7c001b61f2bf718452aa1dff056a417.patch";
      hash = "sha256-cqF0E9enKGNr/vq8gZlUMqHS/cQpjzkZXthzc8OJtqo=";
    })
  ];

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    # "Dependency-Free - building Recast & Detour only requires a C++98-compliant compiler"
    SDL2
    libGLU
  ];

  cmakeFlags = [
    # They vendor a broken copy of catch2
    (lib.cmakeBool "RECASTNAVIGATION_TESTS" false)

    # habitat-sim wants to see private symbols:
    (lib.cmakeFeature "CMAKE_CXX_FLAGS" "-DDT_VIRTUAL_QUERYFILTER=1")
  ];

  meta = with lib; {
    description = "Navigation-mesh Toolset for Games";
    homepage = "https://github.com/erikwijmans/recastnavigation";
    license = licenses.zlib;
    maintainers = with maintainers; [ ];
    mainProgram = "recastnavigation";
    platforms = platforms.all;
  };
}
