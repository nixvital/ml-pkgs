{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, pythonRelaxDepsHook
, numpy
, numba
, scipy
, mujoco
, pygame
, pillow
, opencv4
, pyyaml
, pynput
, tqdm
, termcolor
, imageio
, h5py
, lxml
, hidapi
, robosuite
}:

buildPythonPackage rec {
  pname = "robocasa";
  version = "2024.05.28";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "robocasa";
    repo = pname;
    rev = "49923f0115465cbf388db7595c0ad461726f2c6a";
    hash = "sha256-rxCDpgj+Qbpsmq2Di8iPgCr46PB1xMrpHv/dWbWOgz8=";
  };

  buildInputs = [
    setuptools
  ];

  nativeBuildInputs = [
    pythonRelaxDepsHook
  ];

  propagatedBuildInputs = [
    numpy
    numba
    scipy
    mujoco
    pygame
    pillow
    opencv4
    pyyaml
    pynput
    tqdm
    termcolor
    imageio
    h5py
    lxml
    hidapi
    robosuite
  ];

  pythonRelaxDeps = [ "numpy" "mujoco" ];
  pythonRemoveDeps = [ "opencv-python" ];

  meta = with lib; {
    description = ''
      Large-Scale Simulation of Everyday Tasks for Generalist Robots

      @inproceedings{robocasa2024,
        title={RoboCasa: Large-Scale Simulation of Everyday Tasks for Generalist Robots},
        author={Soroush Nasiriany and Abhiram Maddukuri and Lance Zhang and Adeet Parikh and Aaron Lo and Abhishek Joshi and Ajay Mandlekar and Yuke Zhu},
        booktitle={Robotics: Science and Systems},
        year={2024}
      }
    '';
    homepage = "https://robocasa.ai/";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
