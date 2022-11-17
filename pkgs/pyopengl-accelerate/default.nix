# TODO(breakds): Retire when 22.11 has the 3.1.6

{ lib
, fetchFromGitHub
, buildPythonPackage
, pythonAtLeast
, fetchPypi
}:

buildPythonPackage rec {
  pname = "pyopengl-accelerate";
  version = "3.1.6";

  src = let parent = fetchFromGitHub {
    owner = "mcfletch";
    repo = "pyopengl";
    rev = "227f9c66976d9f5dadf62b9a97e6beaec84831ca";
    sha256 = "sha256-RTua39H+WAJTNJGTINuSaCxBCwcs1B3JfJZ6iplvNNQ=";
  }; in "${parent}/accelerate";

  meta = {
    description = "This set of C (Cython) extensions provides acceleration of common operations for slow points in PyOpenGL 3.x";
    homepage = "http://pyopengl.sourceforge.net/";
    maintainers = with lib.maintainers; [ breakds ];
    license = lib.licenses.bsd3;
  };
}
