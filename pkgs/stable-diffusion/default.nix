{ lib
, buildPythonPackage
, fetchFromGitHub
, pytorch
, numpy
, tqdm
}:

buildPythonPackage rec {
  pname = "stable-diffusion";
  version = "2022.08.22";

  src = fetchFromGitHub {
    owner = "CompVis";
    repo = pname;
    rev = "69ae4b35e0a0f6ee1af8bb9a5d0016ccb27e36dc";
    sha256 = "sha256-3YkSUATD/73nJFm4os3ZyNU8koabGB/6iR0XbTUQmVY=";
  };

  propagatedBuildInputs = [
    pytorch
    numpy
    tqdm
  ];

  meta = with lib; {
    description = ''
      Stable Diffusion is a latent text-to-image diffusion model.
    '';
    homepage = "https://github.com/CompVis/stable-diffusion";
    maintainers = with maintainers; [ breakds ];
  };
}
