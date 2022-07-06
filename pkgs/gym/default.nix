# NOTE(breakds): Added this because the default gym v0.21.0 cannot
# handle the open source mujoco.

{ lib
, buildPythonPackage
, fetchFromGitHub
, numpy
, cloudpickle
, importlib-metadata
, gym-notices
}:

buildPythonPackage rec {
  pname = "gym";
  version = "0.24.1";

  src = fetchFromGitHub {
    owner = "openai";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-EGK5wkDu/QUnK1YZXBybyOPIFRt+rQAkJ5AR2U7usZY=";
  };

  propagatedBuildInputs = [
    importlib-metadata    
    cloudpickle
    numpy
    gym-notices
  ];

  # The test needs MuJoCo that is not free library.
  doCheck = false;

  pythonImportsCheck = [ "gym" ];

  meta = with lib; {
    description = "A toolkit for developing and comparing your reinforcement learning agents";
    homepage = "https://gym.openai.com/";
    license = licenses.mit;
    maintainers = with maintainers; [ hyphon81 ];
  };
}
