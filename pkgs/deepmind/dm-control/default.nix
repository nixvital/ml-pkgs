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
  version = "1.0.12";

  src = fetchFromGitHub {
    owner = "deepmind";
    repo = "dm_control";
    rev = "330c91f41a21eacadcf8316f0a071327e3f5c017";
    hash = "sha256-EeVZUArKfqAsgp4c55qrGkcwVp+pt6UzP0h/r2dxGBw=";
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
