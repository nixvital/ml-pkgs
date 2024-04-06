{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, setuptools
, requests
, pandas
, pyarrow
, tqdm
, loguru
, fsspec
, gputil
}:

buildPythonPackage rec {
  pname = "objaverse";
  version = "0.1.7";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "allenai";
    repo = "objaverse-xl";
    rev = version;
    hash = "sha256-Jun1iShXQ4QaQCaWfClIi5CWyMwcSJsEx6CF+08cZ5A=";
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    requests
    pandas
    pyarrow
    tqdm
    loguru
    fsspec
    gputil
  ];

  pythonImportsCheck = [ "objaverse" ];

  meta = with lib; {
    description = ''
      Objaverse-XL is a Universe of 10M+ 3D Objects. Contains API
      Scripts for Downloading and Processing!
    '';
    homepage = "https://objaverse.allenai.org/";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
