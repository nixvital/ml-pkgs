{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, pytestCheckHook
, hatchling
, hatch-fancy-pypi-readme
, hatch-requirements-txt
, swankit
, fastapi
, uvicorn
, peewee
, ujson
, psutil
, pyyaml
, setuptools
, nanoid
, numpy
}:

buildPythonPackage rec {
  pname = "swanboard";
  version = "0.1.3-beta.5";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "SwanHubX";
    repo = "SwanLab-Dashboard";
    rev = "v${version}";
    hash = "sha256-HkaJ8gAC5sGRsnG9gX0RzcNC0WHeJ1oHzv6oK7l1Tho=";
  };

  build-system = [
    hatchling
    hatch-fancy-pypi-readme
    hatch-requirements-txt
    setuptools
  ];

  dependencies = [
    swankit
    fastapi
    uvicorn
    peewee
    ujson
    psutil
    pyyaml
  ];

  pythonImportsCheck = [ "swanboard" ];

  nativeCheckInputs = [
    pytestCheckHook
    nanoid
    numpy
  ];
  disabledTests = [
    "test_get_package_version_installed"
    "test_get_package_version_not_installed"    
  ];

  meta = with lib; {
    description = "Swanlab's Dashboard";
    homepage = "https://github.com/SwanHubX/SwanLab-Dashboard";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
