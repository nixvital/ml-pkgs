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
, gputils
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
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    
  ];

  meta = with lib; {
    description = ''
      Scaling Embodied AI by Procedurally Generating Interactive 3D Houses
    '';
    homepage = "https://procthor.allenai.org/";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
