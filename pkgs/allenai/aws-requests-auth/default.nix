{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, setuptools
, requests
, botocore
}:

buildPythonPackage rec {
  pname = "aws-requests-auth";
  version = "2021.05.31";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "DavidMuller";
    repo = "aws-requests-auth";
    rev = "2e1dd0f37e3815c417c3b0630215a77aab5af617";
    hash = "sha256-Q6WL1zoCt/rCjPxiAtgHpQBJizDcZxxnG8ccAG+B7yA=";
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    requests
    botocore
  ];

  pythonImportsCheck = [ "aws_requests_auth" ];

  meta = with lib; {
    description = ''
      AWS signature version 4 signing process for the python requests module
    '';
    homepage = "https://github.com/DavidMuller/aws-requests-auth";
    license = licenses.bsd3;
    maintainers = with maintainers; [ breakds ];
  };
}
