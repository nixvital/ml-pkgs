{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, setuptools
, gym
, numpy
, quaternion
, attrs
, opencv4
, hydra-core
, omegaconf
, numba
, imageio
, imageio-ffmpeg
, scipy
, tqdm
, magnum-bindings
, habitat-sim
}:

buildPythonPackage rec {
  pname = "habitat-lab";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "facebookresearch";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-o5q+Kx9Se99d4awlvrVGAdqT4i2SWCArRvNKaKOPImA=";
  };

  build-system = [ setuptools ];

  patches = [ ./py311-dataclasses.patch ];
  postPatch = ''
    cd habitat-lab
  '';

  propagatedBuildInputs = [
    gym
    numpy
    quaternion
    attrs
    opencv4
    hydra-core
    omegaconf
    numba
    imageio
    imageio-ffmpeg
    scipy
    tqdm
    magnum-bindings
    habitat-sim
  ];

  doCheck = false;
  pythonImportsCheck = [ "habitat" ];

  meta = with lib; {
    description = "A modular high-level library to train embodied AI agents across a variety of tasks and environments.";
    homepage = "https://aihabitat.org/";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
