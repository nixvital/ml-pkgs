{ lib
, buildPythonPackage
, fetchPypi
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
  version = "4.19.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-4ZpP8HRY7aFDxzjlJZyvSESfzweKY9axvRqoBlQ0QKM=";
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
