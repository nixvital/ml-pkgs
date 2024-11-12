{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, setuptools
, absl-py
, lxml
, numpy
, pyyaml
, torch
, matplotlib
, pytorch-seed
, arm-pytorch-utilities
}:

buildPythonPackage rec {
  pname = "pytorch_kinematics";
  version = "0.7.4";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "UM-ARM-Lab";
    repo = pname;
    rev = "v${version}";
    hash = "";
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    absl-py
    lxml
    numpy
    pyyaml
    torch
    matplotlib
    pytorch-seed
    arm-pytorch-utilities
  ];

  meta = with lib; {
    description = "Robot kinematics implemented in pytorch";
    homepage = "https://github.com/UM-ARM-Lab/pytorch_kinematics";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
