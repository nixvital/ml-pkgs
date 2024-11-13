{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, python3Packages
, setuptools
, cython
, numpy
, scipy
, matplotlib
, pyyaml
, oldest-supported-numpy
}:

buildPythonPackage rec {
  pname = "toppra";
  version = "0.6.2";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "hungpham2511";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-QakM8HizcPSdTMrMCnynGBkd9HF1H/r2+Xt4Y9RH9ck=";
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    numpy
    cython
    pyyaml
    python3Packages.msgpack
    oldest-supported-numpy
    scipy
    matplotlib
  ];

  pythonImportsCheck = [ "toppra" ];

  meta = with lib; {
    description = "robotic motion planning library";
    homepage = "https://hungpham2511.github.io/toppra/index.html";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
