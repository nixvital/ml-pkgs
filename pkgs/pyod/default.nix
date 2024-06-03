{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, joblib
, matplotlib
, numpy
, numba
, scipy
, scikit-learn
}:

buildPythonPackage rec {
  pname = "pyod";
  version = "1.1.3";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "yzhao062";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-KDtJ+V+ROMzhsk++i58ReVm+r+6FdHkmWH0vSmCoqrg=";
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    joblib
    matplotlib
    numpy
    numba
    scipy
    scikit-learn
  ];

  pythonImportsCheck = [
    "pyod"
    "pyod.models"
    "pyod.models.ecod"
  ];

  meta = with lib; {
    description = ''
      A Comprehensive and Scalable Python Library for Outlier Detection (Anomaly Detection)
    '';
    homepage = "https://pyod.readthedocs.io/";
    license = licenses.bsd2;
    maintainers = with maintainers; [ breakds ];
  };
}
