{ lib
, buildPythonPackage
, fetchFromGitHub
, pybullet
, numpy
, attrdict
, gym
}:

buildPythonPackage rec {
  pname = "pubulletx";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "breakds";
    repo = "pybulletX";
    rev = "97278897df756f5921b5d229f06c42b35ef9c729";
    sha256 = "sha256-kDnM4MyzimN2DN3CISUldH/nxg4db8s/8zErNlbvHJM=";
  };

  propagatedBuildInputs = [
    pybullet
    numpy
    attrdict
    gym
  ];

  pythonImportsCheck = [ "pybulletX" ];

  meta = with lib; {
    homepage = "https://github.com/facebookresearch/pybulletX";
    description = ''
      The lightweight PyBullet wrapper for robotics researchers
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
