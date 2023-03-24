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
  version = "4.27.3";

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-JoymCNmogjDb9aOPBNxTV3nWMawDzwaaY+vn/V8YAx0=";
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
