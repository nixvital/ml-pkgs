{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonRelaxDepsHook
, autoPatchelfHook
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
, geopandas
, shapely
, psutil
, pytest }:

buildPythonPackage rec {
  pname = "metadrive-simulator";
  version = "0.3.0.1";

  src = fetchFromGitHub {
    owner = "decisionforce";
    repo = "metadrive";
    rev = "MetaDrive-0.3.0.1";
    hash = "sha256-eYMJU/dGnDnwfTsyLgkMViJf9+R4KsnKf6khcU/t78E=";
  };

  nativeBuildInputs = [
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [ "gym" "protobuf" ];
  pythonRemoveDeps = [ "opencv-python" ];

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
    geopandas
    shapely
    psutil
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
