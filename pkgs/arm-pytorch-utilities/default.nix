{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, setuptools
, numpy
, torch
, matplotlib
, pytorch-seed
, scipy
}:

buildPythonPackage rec {
  pname = "arm_pytorch_utilities";
  version = "0.4.3";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "UM-ARM-Lab";
    repo = pname;
    rev = "6312d5094f71a646041fa2994663a19f052ee857";
    hash = "";
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    numpy
    torch
    matplotlib
    pytorch-seed
    scipy
  ];

  meta = with lib; {
    description = "University of Michigan ARM Lab PyTorch utilities";
    homepage = "https://github.com/UM-ARM-Lab/arm_pytorch_utilities";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
