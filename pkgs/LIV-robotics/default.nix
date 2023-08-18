{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonRelaxDepsHook
, pytorch
, torchvision
, clip
, omegaconf
, hydra-core
, pillow
, opencv4
, matplotlib
, flatten-dict
, gdown
, huggingface-hub
, tabulate
, pandas
, transforms3d
, moviepy
, termcolor
, wandb
}:

buildPythonPackage rec {
  pname = "LIV-robotics";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "breakds";
    repo = "LIV";
    rev = "1dfa88d55a869b468cf66ab6fc8498c39c1203a8";
    hash = "sha256-W+DiG8xBZRu6cuM6edSjOWlQF/dRb61ISchvCxqZl+o=";
  };

  nativeBuildInputs = [
    pythonRelaxDepsHook
  ];

  # pythonRelaxDeps = [
  # ];

  pythonRemoveDeps = [
    "opencv-python"
  ];

  propagatedBuildInputs = [
    pytorch
    torchvision
    clip
    omegaconf
    hydra-core
    pillow
    opencv4
    matplotlib
    flatten-dict
    gdown
    huggingface-hub
    tabulate
    pandas
    transforms3d
    moviepy
    termcolor
    wandb
  ];

  doCheck = false;
  pythonImportsCheck = [ "liv" ];

  meta = with lib; {
    homepage = "https://github.com/penn-pal-lab/LIV";
    description = ''
      Official repository for "LIV: Language-Image Representations and Rewards for
      Robotic Control" (ICML 2023)
    '';
    license = licenses.cc-by-nc-nd-40;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
