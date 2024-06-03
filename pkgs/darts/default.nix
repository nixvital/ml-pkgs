{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonRelaxDepsHook
, setuptools
, holidays
, joblib
, matplotlib
, nfoursid
, numpy
, pandas
, pmdarima
, pyod
, requests
, scikit-learn
, scipy
, shap
# , statsforecast
, statsmodels
, tbats
, tqdm
, typing-extensions
, xarray
, xgboost
, pytorch-lightning
}:

buildPythonPackage rec {
  pname = "darts";
  version = "0.29.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "unit8co";
    repo = pname;
    rev = version;
    hash = "sha256-JMrT1NBTn68on4RU0RbAmSVJOooOXR7ieASM9sQ8ttA=";
  };

  nativeBuildInputs = [
    pythonRelaxDepsHook
  ];

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    holidays
    joblib
    matplotlib
    nfoursid
    numpy
    pandas
    pmdarima
    pyod
    requests
    scikit-learn
    scipy
    shap
    # statsforecast
    statsmodels
    tbats
    tqdm
    typing-extensions
    xarray
    xgboost
    pytorch-lightning
  ];

  pythonRelaxDeps = [
    "pmdarima"
  ];

  pythonRemoveDeps = [
    "statsforecast"
  ];

  pythonImportsCheck = [
    "darts"
  ];
  
  meta = with lib; {
    description = ''
      A python library for user-friendly forecasting and anomaly detection on time series
    '';
    homepage = "https://unit8co.github.io/darts/";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
