# This packages the atari-py together with the Atari 2600 roms.

{ lib
, fetchurl
, buildPythonPackage
, autoPatchelfHook
, python
, stdenv
, glib
, numpy
, gym
, gym3
, filelock
}:

let pyVerNoDot = builtins.replaceStrings [ "." ] [ "" ] python.pythonVersion;

in buildPythonPackage rec {
  pname = "procgen";
  version = "0.10.7";
  format = "wheel";

  src = fetchurl (import ./wheel-urls.nix {
    inherit version pyVerNoDot; });

  propagatedBuildInputs = [
    numpy
    gym
    gym3
    filelock
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    glib
  ];

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  pythonImportsCheck = [ "procgen" ];  
}
