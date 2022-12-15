{ lib
, buildPythonPackage
, fetchFromGitHub
, GitPython
, tqdm
, flit-core
}:

buildPythonPackage rec {
  pname = "robot_descriptions";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "robot-descriptions";
    repo = "robot_descriptions.py";
    rev = "v${version}";
    hash = "sha256-XjPikd+iDtiy8fvVy5k69XgMZrTtkN+bcrvaXekYJyo=";
  };

  format = "pyproject";

  buildInputs = [
    flit-core
  ];

  propagatedBuildInputs = [
    GitPython
    tqdm
  ];

  pythonImportsCheck = [
    "robot_descriptions"
  ];

  meta = with lib; {
    description = ''
      Import robot descriptions as Python modules
    '';
    homepage = "https://github.com/robot-descriptions/robot_descriptions.py";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
