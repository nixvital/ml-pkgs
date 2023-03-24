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
  version = "0.18.0";

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-fCIvVbMaWAWzRfPc5/1CZq3gZ8kruuk9wBt8mzLHmyw=";
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
