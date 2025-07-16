{ lib, buildPythonPackage, fetchFromGitHub, setuptools, numpy, cffi, imageio, imageio-ffmpeg
, moderngl, glfw, glcontext }:

buildPythonPackage rec {
  pname = "gym3";
  version = "0.3.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "openai";
    repo = "gym3";
    rev = "4c3824680eaf9dd04dce224ee3d4856429878226";
    sha256 = "sha256-i+A/fGlg221wtKG8zbt7ATDKXe1HtVqXLOWbYJ9hZR8=";
  };

  patches = [ ./0001-Allow-newer-version-of-glfw-and-imageio-ffmpeg.patch ];

  build-system = [ setuptools ];

  propagatedBuildInputs =
    [ numpy cffi imageio imageio-ffmpeg moderngl glfw glcontext ];

  # Tests fail on python 3 due to writes to the read-only home directory
  doCheck = false;

  pythonImportsCheck = [ "gym3" ];

  meta = with lib; {
    description = ''
      provides a unified interface for reinforcement learning
      environments that improves upon the gym interface
    '';
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ breakds ];
  };
}
