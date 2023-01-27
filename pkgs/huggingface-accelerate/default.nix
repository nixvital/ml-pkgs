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
  version = "v0.15.0";

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = pname;
    rev = "v0.15.0";
    hash = "sha256-agfbOaa+Nm10HZkd2Y7zR3R37n+vLNsxCyxZax6O3Lo=";
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

  pythonImportsCheck = [ "transformers" ];

  meta = with lib; {
    description = ''
      A simple way to train and use PyTorch models with multi-GPU, TPU, mixed-precision
    '';
    homepage = "https://huggingface.co/docs/accelerate/index";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
