{ lib
, buildPythonPackage
, fetchFromGitHub
, pybullet
, numpy
, matplotlib
, opencv4
, omegaconf
, hydra
, scipy
, pyopengl
}:

buildPythonPackage rec {
  pname = "tacto";
  version = "2021.11.02";

  src = fetchFromGitHub {
    owner = "breakds";
    repo = "tacto";
    rev = "759acd751512cf48c35fa5fddc37214266ae497e";
    sha256 = "sha256-ph9MUsttxOestrz0+n5YKIMS9JQbltVFKhEnqvmfQm0=";
  };

  propagatedBuildInputs = [
    pybullet
    numpy
    matplotlib
    opencv4
    omegaconf
    hydra
    scipy
    pyopengl
  ];

  pythonImportsCheck = [ "tacto" ];

  meta = with lib; {
    homepage = "https://github.com/lukashermann/tacto";
    description = ''
      Simulator of vision-based tactile sensors
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
