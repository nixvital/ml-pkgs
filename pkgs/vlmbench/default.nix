{ lib
, buildPythonPackage
, fetchFromGitHub
, numpy
, pillow
, pyquaternion
, natsort
, opencv4
, scipy
, open3d
}:

buildPythonPackage rec {
  pname = "vlmbench";
  version = "2022.09.16";

  src = fetchFromGitHub {
    owner = "eric-ai-lab";
    repo = "VLMbench";
    rev = "c0bc31e55b20a795cdd6bafd6b6e05cd38f1bcf2";
    sha256 = "sha256-nP1HhsUpfjCZqrW0VW9NBfcSbqB0pbLRHoNzsPOopyY=";
  };

  propagatedBuildInputs = [
    numpy
    pillow
    pyquaternion
    natsort
    opencv4
    scipy
    open3d
  ];

  # pythonImportsCheck = [ "vlm" ];

  meta = with lib; {
    description = ''
      NeurIPS 2022 Paper "VLMbench: A Compositional Benchmark for
      Vision-and-Language Manipulation"
    '';
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ breakds ];
  };
}
