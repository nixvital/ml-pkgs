{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, pythonRelaxDepsHook
, numpy
, numba
, scipy
, mujoco
, pillow
, opencv4
, pynput
, termcolor
, hidapi
, h5py
}:

buildPythonPackage rec {
  pname = "robosuite";
  version = "robocasa_v0.1";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "ARISE-Initiative";
    repo = pname;
    rev = "29ee7efb49476d5bcc5bb43cf75105903eadb1a7";
    hash = "sha256-qLyws+9GTWRsFa0u53rMdadts6SdYwo55bf711ayTD8=";
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
    pillow
    opencv4
    pynput
    termcolor
    hidapi
    h5py
  ];

  pythonRelaxDeps = [ "numpy" "mujoco" ];
  pythonRemoveDeps = [ "opencv-python" ];

  # pythonImportsCheck = [ "robosuite" ];

  meta = with lib; {
    description = ''
      A Modular Simulation Framework and Benchmark for Robot Learning
    '';
    homepage = "https://robosuite.ai/";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
