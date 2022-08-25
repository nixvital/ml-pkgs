{ lib
, buildPythonPackage
, fetchFromGitHub
, isPy27
, future
, pytestCheckHook
, pytorch
, pyyaml
, tensorflow-tensorboard
, tqdm
, torchmetrics
, fsspec
, typing-extensions
}:

buildPythonPackage rec {
  pname = "pytorch-lightning";
  version = "1.6.3";

  disabled = isPy27;

  src = fetchFromGitHub {
    owner = "PyTorchLightning";
    repo = pname;
    rev = version;
    hash = "sha256-MEUFrj84y5lQfwbC9s9fJNOKo+Djeh+E/eDc8KeX7V4=";
  };

  propagatedBuildInputs = [
    future
    pytorch
    pyyaml
    tensorflow-tensorboard
    tqdm
    torchmetrics
    fsspec
    typing-extensions
  ];
  checkInputs = [ pytestCheckHook ];
  # Some packages are not in NixPkgs; other tests try to build distributed
  # models, which doesn't work in the sandbox.
  doCheck = false;
  pythonImportsCheck = [ "pytorch_lightning" ];
  meta = with lib; {
    description = "Lightweight PyTorch wrapper for machine learning researchers";
    homepage = "https://pytorch-lightning.readthedocs.io";
    license = licenses.asl20;
    maintainers = with maintainers; [ tbenst ];
  };
}
