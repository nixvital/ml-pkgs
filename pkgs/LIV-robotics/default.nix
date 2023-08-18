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
, ftfy
}:

buildPythonPackage rec {
  pname = "LIV-robotics";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "HorizonRoboticsInternal";
    repo = "LIV";
    rev = "0b74e9bf088d2453df0eed5e5af7f9e0f7057340";
    hash = "sha256-VG8Zqq2fvfqqWc9OZnyCmhfJNmcSxqTByAoxvdr7F4s=";
  };

  patches = [
    ./0001-Relax-deps.patch
  ];

  nativeBuildInputs = [
    pythonRelaxDepsHook
  ];

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
    ftfy
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
