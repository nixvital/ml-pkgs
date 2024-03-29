{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, pyparsing
# Runtime Requirements
, absl-py
, dm-env
, dm-tree
, glfw
, h5py
, labmaze
, lxml
, mujoco-pybind
, numpy
, pillow
, protobuf
, pyopengl
, requests
, scipy
, tqdm
}:

buildPythonPackage rec {
  pname = "dm_control";
  version = "1.0.16";

  src = fetchFromGitHub {
    owner = "deepmind";
    repo = "dm_control";
    rev = version;
    hash = "sha256-xx+CgvhGAVOdpYfnCZEBS3mZXCKeFzgXkHM4pOV3X5E=";
  };

  patches = [
    # The problem is that setup.py uses logging.DEBUG, whose enum ID has
    # changed. The fix is just to silence that logging line in setup.py.
    ./silence_logging.patch
  ];

  buildInputs = [
    setuptools
    pyparsing
  ];

  propagatedBuildInputs = [
    absl-py
    dm-env
    dm-tree
    glfw
    h5py
    labmaze
    lxml
    mujoco-pybind
    numpy
    pillow
    protobuf
    pyopengl
    requests
    scipy
    tqdm
  ];

  pythonImportsCheck = [
    "dm_control"
  ];

  doCheck = false;

  meta = with lib; {
    description = ''
      DeepMind's software stack for physics-based simulation and
      Reinforcement Learning environments, using MuJoCo.
    '';
    homepage = "https://github.com/deepmind/dm_control";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
