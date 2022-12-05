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
, lxml
, protobuf
, tqdm
, pytest }:

buildPythonPackage rec {
  pname = "metadrive-simulator";
  version = "0.2.5.2";

  src = fetchFromGitHub {
    owner = "decisionforce";
    repo = "metadrive";
    rev = "78ee891904ed70c3277971a563cb3807a614a38c";
    sha256 = "sha256-0nofeqCqbcgLIPx//q95G0QM3dpdl1CQwU/Y3sdXBW4=";
  };

  patches = [
    ./0001-adjust-requirements.patch
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
    lxml
    protobuf
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
