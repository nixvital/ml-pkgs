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
  version = "2021.12.10";

  src = fetchFromGitHub {
    owner = "decisionforce";
    repo = "metadrive";
    rev = "b96ff820ae6a8b715fed9222ce3f73e602045bad";
    sha256 = "sha256-SBi+P2tFcqdaf56v+XXVGZUNl9xMcbsQ5fE01WCS26k=";
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
