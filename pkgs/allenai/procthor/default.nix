{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, setuptools
, numpy
, matplotlib
, trimesh
, python-sat
, python-fcl
, canonicaljson
}:

buildPythonPackage rec {
  pname = "procthor";
  version = "0.0.1";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "allenai";
    repo = pname;
    rev = version;
    hash = "sha256-5/mDyRZijDWCSSMzL/ZDoCNlaoHKL6Z8sX7O9kjiLio=";
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    numpy
    matplotlib
    trimesh
    python-sat
    python-fcl
    canonicaljson
  ];

  meta = with lib; {
    description = ''
      Scaling Embodied AI by Procedurally Generating Interactive 3D Houses
    '';
    homepage = "https://procthor.allenai.org/";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
