{ lib, fetchFromGitHub, buildPythonPackage, setuptools, graphviz, distutils, torch }:

buildPythonPackage rec {
  pname = "pytorchviz";
  version = "2021.06.15";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "szagoruyko";
    repo = pname;
    rev = "0adcd83af8aa7ab36d6afd139cabbd9df598edb7";
    sha256 = "sha256-oNKvheam/qpgPMsG32XN78VuOQcQNDskqqvpnAnjuWs=";
  };

  propagatedBuildInputs = [ graphviz distutils torch ];

  build-system = [ setuptools ];

  pythonImportsCheck = [ "torchviz" ];

  meta = with lib; {
    description =
      "A small package to create visualizations of PyTorch execution graphs";
    homepage = "https://github.com/szagoruyko/pytorchviz";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
