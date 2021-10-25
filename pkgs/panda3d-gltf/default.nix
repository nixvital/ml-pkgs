{ lib
, buildPythonPackage
, fetchPypi
, panda3d
, panda3d-simplepbr }:

buildPythonPackage rec {
  pname = "panda3d-gltf";
  version = "0.13";
  format = "wheel";

  src = builtins.fetchurl {
    url = https://files.pythonhosted.org/packages/70/94/98ed1f81ca0f5daf6de80533805cc1e98ac162abe4e3e1d382caa7ba5c3c/panda3d_gltf-0.13-py3-none-any.whl;
    sha256 = "1qpg46k6bdiri26k1vr8gbq7ifl9y9kwcj2bzyaiifs7yj0akl82";
  };

  propagatedBuildInputs = [
    panda3d panda3d-simplepbr
  ];

  meta = with lib; {
    description = ''
      glTF utilities for Panda3D
    '';
    homepage = "https://github.com/Moguri/panda3d-gltf";
    license = licenses.bsd3;
    maintainers = with maintainers; [ breakds ];
  };
}
