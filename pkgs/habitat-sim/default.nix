{
  lib,
  buildPythonPackage,
  stdenv,
  fetchFromGitHub,
  cmake,
  config,
  withCuda ? config.cudaSupport,
  ninja,
  pip,
  setuptools,
  wheel,
  pythonRelaxDepsHook,
  attrs,
  gitpython,
  imageio,
  imageio-ffmpeg,
  matplotlib,
  numba,
  numpy,
  quaternion,
  pillow,
  scipy,
  tqdm,
  bullet,
  eigen,
  openexr,
  glfw3,
  pybind11,
  rapidjson,
  rapidjson-for-habitat ? rapidjson.overrideAttrs (oldAttrs: {
    src = fetchFromGitHub {
      inherit (oldAttrs.src) owner repo;
      rev = "73063f5002612c6bf64fe24f851cd5cc0d83eef9"; # 2018
      hash = "sha256-pfplYKp6kkTPcyOjbnFqmbTFt8NXKLjSVC0Wh9UNUIw=";
    };
    patches = lib.flip builtins.filter oldAttrs.patches (
      # "Previously applied"
      p: !(lib.isPath p && lib.hasSuffix "valgrind-failures.patch" p)
    );
  }),
  assimp,
  corrade,
  magnum,
  magnum-bindings,
  magnum-integration,
  magnum-plugins,
  recastnavigation,
  xorg,
}:

buildPythonPackage rec {
  pname = "habitat-sim";
  version = "0.3.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "facebookresearch";
    repo = "habitat-sim";
    rev = "v${version}";
    hash = "sha256-vTXBg3PUmXFn6nyGIGEap+LEW5KftnIXfk4qIp4T9SU=";
  };

  patches = [ ./0001-cmake-recastnavigation-allow-dependency-injection.patch ];
  postPatch = ''
    sed -i 's|option(USE_SYSTEM_\(.*\) OFF)|option(USE_SYSTEM_\1 ON)|' src/CMakeLists.txt
    substituteInPlace src/esp/gfx/CMakeLists.txt \
      --replace-fail \
        "MagnumIntegration REQUIRED Eigen" \
        "MagnumIntegration COMPONENTS Eigen"
    rm src/cmake/FindMagnum*.cmake
  '';

  nativeBuildInputs = [
    cmake
    ninja
    pip
    setuptools
    wheel
    pythonRelaxDepsHook
  ];

  buildInputs = [
    (lib.getDev bullet)
    eigen
    openexr
    glfw3
    pybind11
    rapidjson-for-habitat
    assimp
    corrade
    magnum
    magnum-bindings
    magnum-integration
    magnum-plugins
    recastnavigation
  ] ++ lib.optionals stdenv.hostPlatform.isUnix [ xorg.libX11 ];

  propagatedBuildInputs = [
    attrs
    gitpython
    imageio
    imageio-ffmpeg
    matplotlib
    numba
    numpy
    quaternion
    pillow
    scipy
    tqdm
  ];

  dontUseCmakeConfigure = true;
  preConfigure = ''
    export CMAKE_ARGS=$cmakeFlags
  '';

  cmakeFlags = [
    (lib.cmakeBool "BUILD_WITH_CUDA" withCuda)
  ];

  pythonRelaxDeps = [ "numpy" ];

  pythonImportsCheck = [ "habitat_sim" ];

  meta = with lib; {
    description = "A flexible, high-performance 3D simulator for Embodied AI research";
    homepage = "https://github.com/facebookresearch/habitat-sim";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
