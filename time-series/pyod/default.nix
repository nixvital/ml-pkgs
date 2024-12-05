{ lib, buildPythonPackage, fetchFromGitHub, setuptools, joblib, matplotlib
, numpy, numba, scipy, scikit-learn }:

buildPythonPackage rec {
  pname = "pyod";
  version = "2.0.2";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "yzhao062";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-thEuXyL/ncDeeXTDxPbOoxeY5pI1IqvwFrvZpg8Yqdg=";
  };

  buildInputs = [ setuptools ];

  propagatedBuildInputs = [ joblib matplotlib numpy numba scipy scikit-learn ];

  pythonImportsCheck = [ "pyod" "pyod.models" "pyod.models.ecod" ];

  meta = with lib; {
    description = ''
      A Comprehensive and Scalable Python Library for Outlier Detection (Anomaly Detection)
    '';
    homepage = "https://pyod.readthedocs.io/";
    license = licenses.bsd2;
    maintainers = with maintainers; [ breakds ];
  };
}
