{ lib
, stdenv
, buildPythonPackage
, fetchurl
, python
, autoPatchelfHook
, numpy
, importlib-metadata
, importlib-resources
}:

let pyVerNoDot = builtins.replaceStrings [ "." ] [ "" ] python.pythonVersion;
    version = "0.7.5";
    srcs = import ./binary-hashes.nix version;
    unsupported = throw "Unsupported system";
in buildPythonPackage rec {
  pname = "ale-py";
  inherit version;
  format = "wheel";

  src = fetchurl srcs."${stdenv.system}-${pyVerNoDot}" or unsupported;

  propagatedBuildInputs = [
    numpy
    importlib-metadata
    importlib-resources    
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  pythonImportsCheck = [ "ale_py" ];

  meta = with lib; {
    description = ''
      The Arcade Learning Environment (ALE) -- a platform for AI research.
    '';
    homepage = "https://github.com/mgbellemare/Arcade-Learning-Environment";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ breakds ];
  };
}
