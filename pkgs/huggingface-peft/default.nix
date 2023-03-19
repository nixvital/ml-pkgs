{ lib
, buildPythonPackage
, fetchFromGitHub
, numpy
, packaging
, psutil
, pyyaml
, pytorch
, huggingface-transformers
, huggingface-accelerate
}:

buildPythonPackage rec {
  pname = "peft";
  version = "v0.2.0-plus";

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = pname;
    rev = "64f63a7df2a02cfd144592d9aa9c871b59258c55";
    sha256 = "sha256-OossddKVUD8N+3/68Dz17cVvbZ7d60ZdS95d4Odaoc4=";
  };

  format = "pyproject";

  propagatedBuildInputs = [
    numpy
    packaging
    psutil
    pyyaml
    pytorch
    huggingface-transformers
    huggingface-accelerate
  ];

  # TODO(breakds): It requires torch 1.13. This should be properly fixed by just
  # using torch 1.13.
  patches = [ ./torch-version.patch ];

  doCheck = false;

  pythonImportsCheck = [ "peft" ];

  meta = with lib; {
    description = ''
      Huggingface's State-of-the-art Parameter-Efficient Fine-Tuning
    '';
    homepage = "https://github.com/huggingface/peft";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
