{
  buildPythonPackage,
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  ninja,
  corrade,
  magnum,
  libGL,
  xorg,
  pybind11,
  setuptools,
}:

buildPythonPackage rec {
  pname = "magnum-bindings";
  version = "unstable-2024-03-08";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "mosra";
    repo = "magnum-bindings";
    rev = "a775640b027b1b541bd682300c1fe69d7f816a61";
    hash = "sha256-yIjVpphDDroEWK+M8MyhqVD/14fVaQvynwkQfqKuHys=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    setuptools
  ];

  buildInputs = [
    corrade
    magnum
    libGL
    pybind11
  ] ++ lib.optionals stdenv.hostPlatform.isLinux [ xorg.libX11 ];

  cmakeFlags = [ "-GNinja" (lib.cmakeBool "MAGNUM_WITH_PYTHON" true) ];

  patches = [
    ./imports.patch
  ];

  # Runs pre/postBuild hooks twice...
  buildPhase = ''
    runPhase ninjaBuildPhase

    # "$sourceRoot/build/src/python"
    cd src/python
    runPhase pypaBuildPhase
  '';

  installPhase = ''
    runPhase pypaInstallPhase

    (cd ../.. ; runPhase ninjaInstallPhase)
  '';

  pythonImportsCheck = [
    "magnum"
  ];

  meta = with lib; {
    description = "Bindings of the Magnum C++11 graphics engine into other languages";
    homepage = "https://github.com/mosra/magnum-bindings";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "magnum-bindings";
    platforms = platforms.all;
  };
}
