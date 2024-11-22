{ lib
, fetchFromGitHub
, buildPythonPackage
, pythonRelaxDepsHook
, python
, stdenv
, autoPatchelfHook
, numpy
, scipy
, dacite
, gymnasium
, sapien
, h5py
, pyyaml
, tqdm
, gitpython
, tabulate
, transforms3d
, trimesh
, imageio
, imageio-ffmpeg
, mplib
# , fast-kinematics
, ipython
, pytorch-kinematics
, tyro
, huggingface-hub
, pynvml
, psutil
, stable-baselines3
}:

buildPythonPackage rec {
  pname = "maniskill";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "haosulab";
    repo = pname;
    rev = "41a5cede87379cf311cfb6dad3f10626bdee66c7";
    hash = "sha256-nQS09Iuvel5gj1L6Z9qy6JqVMLUeEDTzJ0EYpoZmqcw=";
  };

  propagatedBuildInputs = [
    numpy
    scipy
    dacite
    gymnasium
    sapien
    h5py
    pyyaml
    tqdm
    gitpython
    tabulate
    transforms3d
    trimesh
    imageio
    imageio-ffmpeg
    mplib
    # fast-kinematics
    ipython
    pytorch-kinematics
    tyro
    huggingface-hub
    pynvml
    psutil
    stable-baselines3
  ];

  pythonImportsCheck = [ "mani_skill" ];
  
  # check requires pip and network
  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/haosulab/ManiSkill";
    description = ''
      ManiSkill3: A Unified Benchmark for Generalizable Manipulation Skills.
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
