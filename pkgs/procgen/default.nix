# This packages the atari-py together with the Atari 2600 roms.

{ lib
, buildPythonPackage
, autoPatchelfHook
, isPy37
, isPy38
, stdenv
, glib
, numpy
, gym
, gym3
, filelock
}:

assert (isPy37 || isPy38);

buildPythonPackage rec {
  pname = "procgen";
  version = "0.10.4";
  format = "wheel";

  src = builtins.fetchurl (import ./wheel-urls.nix {
    inherit version isPy37 isPy38; });

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
