{ lib
, buildPythonPackage
, fetchFromGitHub
, cython
, gym
, numpy
, matplotlib
, pandas
, pygame
, yapf
, seaborn
, panda3d
, panda3d-simplepbr
, panda3d-gltf
, pillow
, opencv4
, tqdm
, pytest }:

buildPythonPackage rec {
  pname = "metadrive-simulator";
  version = "0.2.5";

  src = fetchFromGitHub {
    owner = "decisionforce";
    repo = "metadrive";
    rev = "13dbc2fa915073c5d126742390db2cc8e4dc56f8";
    sha256 = "sha256-/9+iPoou/CEJl764O4a/QdQo9j+oPuI/sxyLgFT9g50=";
  };

  patches = [
    ./0001-Adjust-python-requirements.patch
  ];

  propagatedBuildInputs = [
    cython
    gym
    numpy
    matplotlib
    pandas
    pygame
    yapf
    seaborn
    panda3d
    panda3d-simplepbr
    panda3d-gltf
    pillow
    opencv4
    tqdm
    pytest
  ];

  doCheck = false;
  pythonImportsCheck = [ "metadrive" ];

  meta = with lib; {
    homepage = "https://github.com/decisionforce/metadrive";
    description = ''
      Composing Diverse Scenarios for Generalizable Reinforcement Learning
    '';
    license = licenses.bsd3;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
