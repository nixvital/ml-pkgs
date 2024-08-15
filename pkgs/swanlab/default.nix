{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, pythonRelaxDepsHook
, pytestCheckHook
, hatchling
, hatch-fancy-pypi-readme
, hatch-requirements-txt
, swankit
# , swanboard
, cos-python-sdk-v5
, urllib3
, requests
, click
, pyyaml
, psutil
, pynvml
, rich

# [media]
, soundfile
, pillow
, matplotlib
, numpy
}:

buildPythonPackage rec {
  pname = "swanlab";
  version = "0.3.16";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "SwanHubX";
    repo = "SwanLab";
    rev = "v${version}";
    hash = "sha256-thYUgAOakqK9YHqZDeRl9uFFxb2yptC+9nCv7Q3yBvk=";
  };

  build-system = [
    hatchling
    hatch-fancy-pypi-readme
    hatch-requirements-txt
    pythonRelaxDepsHook
  ];

  dependencies = [
    swankit
    # swanboard
    cos-python-sdk-v5
    urllib3
    requests
    click
    pyyaml
    psutil
    pynvml
    rich

    # [media]
    soundfile
    pillow
    matplotlib
    numpy
  ];

  pythonRemoveDeps = [
    "swanboard"
  ];

  pythonImportsCheck = [ "swanlab" ];

  # nativeCheckInputs = [
  #   pytestCheckHook
  #   nanoid
  # ];
  # disabledTests = [
  #   "test_default"  # requires home directory
  # ];

  meta = with lib; {
    description = "Swanlab包工具箱 (toolkit)";
    homepage = "https://github.com/SwanHubX/SwanLab-Toolkit";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
