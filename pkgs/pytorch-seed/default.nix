{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, setuptools
, numpy
, torch
}:

buildPythonPackage rec {
  pname = "pytorch_seed";
  version = "0.2.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "UM-ARM-Lab";
    repo = pname;
    rev = "96a99e62482212821a848c36115387de2bfaa921";
    hash = "sha256-r8Yux+qnCKYnEjNibvYQaJ6K3KZXqKD22XiRV41eBsg=";
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    numpy
    torch
  ];

  pythonImportsCheck = [ "pytorch_seed" ];

  meta = with lib; {
    description = "RNG seeding and context management for pytorch";
    homepage = "https://github.com/UM-ARM-Lab/pytorch_seed";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
