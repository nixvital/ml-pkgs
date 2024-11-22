{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, setuptools
, gymnasium
, numpy
, torch
, cloudpickle
, pandas
, matplotlib
, pytest
, pytest-cov
, pytest-env
, pytest-xdist
}:

buildPythonPackage rec {
  pname = "stable-baselines3";
  version = "2.3.2";

  src = fetchFromGitHub {
    owner = "DLR-RM";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-024kQVmuIs7jCt1m2a6cXKORAkpPK59XK3fVWDrO4ts=";
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    gymnasium
    numpy
    torch
    cloudpickle
    pandas
    matplotlib
  ];

  checkInputs = [
    pytest
    pytest-cov
    pytest-env
    pytest-xdist
  ];

  pythonImportsCheck = [ "stable_baselines3" ];

  meta = with lib; {
    description = "Reliable PyTorch implementations of reinforcement learning algorithms.";
    homepage = "https://stable-baselines3.readthedocs.io/";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
