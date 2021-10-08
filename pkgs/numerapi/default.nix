{ lib
, buildPythonPackage
, fetchPypi
, requests
, python-dateutil
, pytz
, tqdm
, click
, pandas
}:

buildPythonPackage rec {
  pname = "numerapi";
  version = "2.9.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-7j93Zptp6UjTkxLKvFUHk5ZrPvoW8l3fHDYp65M1o+Y=";
  };
  
  propagatedBuildInputs = [
    requests
    python-dateutil
    pytz
    tqdm
    click
    pandas
  ];

  doCheck = false;

  pythonImportsCheck = [ "numerapi" ];

  meta = with lib; {
    description = ''
      Python API and command line interface for the numer.ai machine 
      learning competition
    '';
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ breakds ];
  };
}
