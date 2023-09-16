{ lib
, buildPythonPackage
, fetchFromGitHub
, pyjulia
, sympy
, pandas
, numpy
, scikit-learn
, click
}:

buildPythonPackage rec {
  pname = "PySR";
  version = "0.16.3";

  src = fetchFromGitHub {
    owner = "MilesCranmer";
    repo = "PySR";
    rev = "v${version}";
    hash = "sha256-yPXAW9dFi+V8DWRbynBJ+QzMIV94AEADlsd4G0xxRrc=";
  };

  propagatedBuildInputs = [
    pyjulia
    sympy
    pandas
    numpy
    scikit-learn
    click
  ];

  doCheck = false;

  pythonImportsCheck = [
    "pysr"
  ];

  meta = with lib; {
    homepage = "https://github.com/MilesCranmer/PySR/";
    description = ''
      High-Performance Symbolic Regression in Python and Julia
    '';
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; (linux ++ darwin);
  };
}
