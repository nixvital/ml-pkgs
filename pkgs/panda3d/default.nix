{ lib
, stdenv
, buildPythonPackage
, fetchurl
, python
, isPy37
, isPy38
, isPy39
, autoPatchelfHook
, libXext
, libGL }:

let pyVerNoDot = builtins.replaceStrings [ "." ] [ "" ] python.pythonVersion;
    version = "1.10.10";
    srcs = import ./binary-hashes.nix version;
    unsupported = throw "Unsupported system";
in buildPythonPackage rec {
  pname = "panda3d";

  inherit version;

  format = "wheel";

  src = fetchurl srcs."${stdenv.system}-${pyVerNoDot}" or unsupported;

  disabled = !(isPy37 || isPy38 || isPy39);

  # NOTE(breakds): autoPatchelfHook fails to patch the tool binaries and we
  # probably do not need them to use panda3d as a python library.
  postInstall = ''
   rm -r $out/lib/python3.8/site-packages/panda3d_tools/*
  '';

  propagatedBuildInputs = [];

  buildInputs = [
    stdenv.cc.cc.lib
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
