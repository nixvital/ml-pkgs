{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, setuptools
, flask
, numpy
, requests
, progressbar2
, botocore
,aws-requests-auth
, msgpack
, pillow
, xlib
, opencv4
, werkzeug
# ,compress_pickle
, objathor
, pytest-runner
}:

buildPythonPackage rec {
  pname = "ai2thor";
  version = "2024.04.05";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "allenai";
    repo = pname;
    rev = "d115b3823b12192806e050f8f042e05c7e083b8f";
    hash = "sha256-Rg2kp+7Dr19JGozRv5VHGg6O3bW0Oh732i9ECuSalcc=";
  };

  buildInputs = [
    setuptools
    pytest-runner
  ];

  propagatedBuildInputs = [
    flask
    numpy
    requests
    progressbar2
    botocore
    aws-requests-auth
    msgpack
    pillow
    xlib
    opencv4
    werkzeug
    # compress_pickle
    objathor
  ];

  doCheck = false;
  
  # pythonImportsCheck = [ "" ];

  meta = with lib; {
    description = ''
      An open-source platform for Visual AI
    '';
    homepage = "https://ai2thor.allenai.org/";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
