{ lib
, buildPythonPackage
, isPy37
, isPy38
, isPy39
, isPy310 ? false
, autoPatchelfHook
, llvmPackages_11
, libXext
, libGL }:

buildPythonPackage rec {
  pname = "panda3d";
  version = "1.10.10";
  format = "wheel";

  src = builtins.fetchurl (import ./wheel-urls.nix {
    inherit version isPy37 isPy38 isPy39 isPy310;
  });

  disabled = !(isPy37 || isPy38 || isPy39 || isPy310);

  # NOTE(breakds): autoPatchelfHook fails to patch the tool binaries and we
  # probably do not need them to use panda3d as a python library.
  postInstall = ''
   rm -r $out/lib/python3.8/site-packages/panda3d_tools/*
  '';

  propagatedBuildInputs = [];

  buildInputs = [
    llvmPackages_11.stdenv.cc.cc.lib
    libXext
    libGL
  ];

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  pythonImportsCheck = [ "panda3d" "panda3d.core" ];

  meta = with lib; {
    homepage = "https://www.panda3d.org";
    description = ''
      Powerful, mature open-source cross-platform game engine for 
      Python and C++, developed by Disney and CMU
    '';
    license = licenses.bsd3;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
