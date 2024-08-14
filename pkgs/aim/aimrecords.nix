{ stdenv
, lib
, buildPythonPackage
, fetchFromGitHub

# python packages
, base58

# build-system
, setuptools
, pytest
}:

buildPythonPackage rec {
  pname = "aimrecords";
  version = "2021.01.21";

  src = fetchFromGitHub {
    owner = "aimhubio";
    repo = "aimrecords";
    rev = "ed0ca6d0ea2e5b498b9cd8f4e9c3f704cd4f9073";
    hash = "sha256-6WF1iG/U5zK05yZ6m35c90xNE1k7MKRMkiowcIx2zdU=";
  };

  # setuptoolsBuildPhase needs dependencies to be passed through nativeBuildInputs
  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    base58
  ];

  checkInputs = [
    pytest
  ];

  # Seems that tests requires pip install which is fixable but why do I bother.
  doCheck = false;

  pythonImportsCheck = [
    "aimrecords"
  ];

  meta = with lib; {
    description = "ecord-oriented data storage";
    homepage = "https://github.com/aimhubio/aimrecords";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
