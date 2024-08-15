{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, hatchling
, hatch-fancy-pypi-readme
, hatch-requirements-txt
}:

buildPythonPackage rec {
  pname = "swankit";
  version = "0.1.1b1";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "SwanHubX";
    repo = "SwanLab-Toolkit";
    rev = "v${version}";
    hash = "sha256-+wtGn51C8pw8hJFNB9PYfX8xDQAq5DxB7UHuZLU0spY=";
  };

  build-system = [
    hatchling
    hatch-fancy-pypi-readme
    hatch-requirements-txt
  ];

  pythonImportsCheck = [
    "swankit"
  ];

  meta = with lib; {
    description = "Swanlab包工具箱 (toolkit)";
    homepage = "https://github.com/SwanHubX/SwanLab-Toolkit";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
