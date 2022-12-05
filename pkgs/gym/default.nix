# NOTE(breakds): Added this because the default gym v0.21.0 cannot
# handle the open source mujoco.

{ lib
, buildPythonPackage
, fetchFromGitHub
, numpy
, cloudpickle
}:

buildPythonPackage rec {
  pname = "gym";
  version = "0.21.0";

  src = fetchFromGitHub {
    owner = "openai";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-zOzLuwYwRbvCg5zxP6vHFFR7aK8KuZPLJ09k8HshZYk=";
  };

  propagatedBuildInputs = [
    cloudpickle
    numpy
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
