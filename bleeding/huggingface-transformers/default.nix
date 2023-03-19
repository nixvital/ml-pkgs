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
  version = "4.27.1-llama";

  # TODO(breakds): This is a non-release version that has Meta's LLAMA
  # specific commits on master. This should be replaced by a proper
  # release later.
  src = fetchFromGitHub {
    owner = "huggingface";
    repo = pname;
    rev = "60d51ef5123d949fd8c59cd4d3254e711541d278";
    hash = "sha256-e3E7ggw0dKKzk1/NvYjoccx7HZJFnP/yOhOKrOrF76k=";
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
