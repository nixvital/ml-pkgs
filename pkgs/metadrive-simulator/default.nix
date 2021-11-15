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
, pytest }:

buildPythonPackage rec {
  pname = "metadrive-simulator";
  version = "2021.11.15";

  src = fetchFromGitHub {
    owner = "decisionforce";
    repo = "metadrive";
    rev = "8fd4e30200eb022416a43d1accecf8a85f3ed44f";
    sha256 = "sha256-H/CojBnNKY1QlSDLV2ZxDpx44gaOEJk94wr0iwHiGBI=";
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
