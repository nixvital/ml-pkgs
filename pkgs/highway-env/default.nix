{ lib,
  buildPythonPackage,
  fetchPypi,
  gym,
  matplotlib,
  pandas,
  numpy,
  pygame,
  pytestrunner }:

buildPythonPackage rec {
  pname = "highway-env";
  version = "1.4";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-4zzB4LGScYi6shgl9XdH46PXlDfAOUk5gOJyJiTZ/6E=";
  };
  
  format = "pyproject";

  propagatedBuildInputs = [ gym matplotlib pandas numpy pygame ];

  # Testing
  doCheck = true;
  checkInputs = [ pytestrunner ];
  # -- TODO(breakds): Figure why importing it fails on `gym.wrappers`.
  # pythonImportsCheck = [ "highway_env" ];

  meta = with lib; {
    description = ''
      A minimalist environment for decision-making in autonomous driving
    '';
    homepage = "https://github.com/eleurent/highway-env";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
