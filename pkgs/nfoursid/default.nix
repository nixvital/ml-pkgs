{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, matplotlib
, numpy
, pandas
}:

buildPythonPackage rec {
  pname = "nfoursid";
  version = "2022.06.07";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "spmvg";
    repo = pname;
    rev = "91c7b341ab7acac9bfe2e8ea0ee0f094a73fc826";
    hash = "sha256-tboQlUoeidvNUZpZjhnBvzQ0/Xb2vYBNccPDXA7Xeew=";
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    matplotlib
    numpy
    pandas
  ];

  pythonImportsCheck = [
    "nfoursid"
    "nfoursid.kalman"
    "nfoursid.nfoursid"
    "nfoursid.state_space"
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
