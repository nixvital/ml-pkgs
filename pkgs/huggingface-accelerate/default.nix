{ lib
, buildPythonPackage
, fetchFromGitHub
, numpy
, packaging
, psutil
, pyyaml
, pytorch
, huggingface-transformers
}:

buildPythonPackage rec {
  pname = "accelerate";
  version = "v0.17.1";

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = pname;
    rev = version;
    hash = "sha256-+8wTxZRwZDCQZrhXa80zqah/jjxQd9sFjXcEFpD+r7k=";
  };

  format = "pyproject";

  propagatedBuildInputs = [
    numpy
    packaging
    psutil
    pyyaml
    pytorch
    huggingface-transformers
  ];

  doCheck = false;

  pythonImportsCheck = [ "accelerate" ];

  meta = with lib; {
    description = ''
      A simple way to train and use PyTorch models with multi-GPU, TPU, mixed-precision
    '';
    homepage = "https://huggingface.co/docs/accelerate/index";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
