{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, pytestCheckHook
, hatchling
, hatch-fancy-pypi-readme
, hatch-requirements-txt
, pythonRelaxDepsHook
, swankit
, swanboard
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

# [test]
, python-dotenv  
  
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
    # TODO(breakds): Make swanboard ui work.
    swanboard
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

  pythonRelaxDeps = [ "swanboard" ];

  pythonImportsCheck = [ "swanlab" ];

  # TODO(breakds): Enable tests.
  #
  # nativeCheckInputs = [
  #   pytestCheckHook
  #   python-dotenv
  # ];

  meta = with lib; {
    description = "SwanLab: your ML experiment notebook.";
    homepage = "https://swanlab.cn/";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
