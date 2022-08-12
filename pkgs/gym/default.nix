# NOTE(breakds): Added this because the default gym v0.21.0 makes some
# breaking change on how atari is being handled (use ale-py instead
# atari-py).

{ lib
, buildPythonPackage
, fetchFromGitHub
, numpy
, cloudpickle
}:

buildPythonPackage rec {
  pname = "gym";
  version = "0.19.0";

  src = fetchFromGitHub {
    owner = "openai";
    repo = pname;
    rev = version;
    sha256 = "sha256-0O/s9OVNGQmeX9j8B1x63RxdI6dhqfTEJcgDH2jtCv4=";
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
