{ lib
, buildPythonPackage
, fetchFromGitHub
, jieba
, regex
, requests
, sacremoses
, huggingface-hub
, pyyaml
, tokenizers
, packaging
, pytorch
}:

buildPythonPackage rec {
  pname = "transformers";
  version = "2023.03.24-llama";  # Use main branch since we need llama

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = pname;
    rev = "cae78c46d658a8e496a815c2ee49b9b178fb9c9a";
    hash = "sha256-djcfdGASk3gsUjpfKO5mxFKVLPj9FRzSvEw3B2uec+0=";
  };
  
  format = "pyproject";

  propagatedBuildInputs = [
    jieba
    regex
    requests
    sacremoses
    huggingface-hub
    pyyaml
    tokenizers
    packaging
    pytorch
  ];

  doCheck = false;

  pythonImportsCheck = [ "transformers" ];

  meta = with lib; {
    description = ''
      Transformers: State-of-the-art Machine Learning for Pytorch, TensorFlow, and JAX.
    '';
    homepage = "https://huggingface.co/transformers";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
