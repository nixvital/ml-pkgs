# NOTE(breakds): Added this because the default gym v0.21.0 cannot
# handle the open source mujoco.

{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonRelaxDepsHook
, numpy
, cloudpickle
, gym-notices
}:

buildPythonPackage rec {
  pname = "gym";
  version = "0.25.2";

  src = fetchFromGitHub {
    owner = "openai";
    repo = pname;
    rev = "${version}";
    hash = "sha256-dCJUgc99puh+/5qY2Hq9PA3Fu1JhxXTQhb4arnRHHao=";
  };

  nativeBuildInputs = [
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [ "cloudpickle" ];

  propagatedBuildInputs = [
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
