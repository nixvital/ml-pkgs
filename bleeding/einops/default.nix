{ lib
, buildPythonPackage
, chainer
, fetchFromGitHub
, hatchling
, jupyter
, keras
  #, mxnet
, nbconvert
, nbformat
, nose
, numpy
, parameterized
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "einops";
  version = "0.6.1";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "arogozhnikov";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-+TaxaxOc5jAm79tIK0NHZ58HgcgdCANrSo/602YaF8E=";
  };

  nativeBuildInputs = [ hatchling ];

  nativeCheckInputs = [
    chainer
    jupyter
    keras
    # mxnet (has issues with some CPUs, segfault)
    nbconvert
    nbformat
    nose
    numpy
    parameterized
    pytestCheckHook
  ];

  # No CUDA in sandbox
  EINOPS_SKIP_CUPY = 1;

  preCheck = ''
    export HOME=$(mktemp -d);
  '';

  pythonImportsCheck = [
    "einops"
  ];

  doCheck = false;

  meta = with lib; {
    description = "Flexible and powerful tensor operations for readable and reliable code";
    homepage = "https://github.com/arogozhnikov/einops";
    license = licenses.mit;
    maintainers = with maintainers; [ yl3dy ];
  };
}
