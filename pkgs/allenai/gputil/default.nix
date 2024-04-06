{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
}:

buildPythonPackage rec {
  pname = "gputil";
  version = "2019.08.16";

  src = fetchFromGitHub {
    owner = "anderskm";
    repo = "gputil";
    rev = "42ef071dfcb6469b7ab5ab824bde6ca9f6d0ab8a";
    hash = "sha256-uzdo8fnaV0YftJe/+rnLz635mI8Buj6DIkB4iSNyIRo=";
  };

  buildInputs = [ setuptools ];

  propagatedBuildInputs = [];

  doCheck = false;
  pythonImportsCheck = [ "GPUtil" ];

  meta = with lib; {
    description = ''
      A Python module for getting the GPU status from NVIDA GPUs using
      nvidia-smi programmically in Python
    '';
    homepage = "https://github.com/anderskm/gputil/";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
