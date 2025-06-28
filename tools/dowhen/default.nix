{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
}:

let
  pname = "dowhen";
  version = "0.1.0";

in buildPythonPackage {
  inherit pname version;
  pyproject = true;

  src = fetchFromGitHub {
    owner = "gaogaotiantian";
    repo = "dowhen";
    tag = version;
    hash = "sha256-7eoNe9SvE39J4mwIOxvbU1oh/L7tr/QM1uuBDqWtQu0=";
  };

  build-system = [
    setuptools
  ];

  pythonImportsCheck = [ "dowhen" ];

  meta = with lib; {
    homepage = "https://github.com/gaogaotiantian/dowhen";
    description = "An instrumentation tool for Python";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
