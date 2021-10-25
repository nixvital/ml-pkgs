{ lib
, buildPythonPackage
, panda3d
, pytestrunner
, pylint
, pytest
, pytest-pylint }:

buildPythonPackage rec {
  pname = "panda3d-simplepbr";
  version = "0.9";
  format = "wheel";

  src = builtins.fetchurl {
    url = https://files.pythonhosted.org/packages/ec/d9/040ca6513485797a6a31a6e5cf8846c551cf3c8d1933e25180a73116deab/panda3d_simplepbr-0.9-py3-none-any.whl;
    sha256 = "1ywq35jmphxhmzrswj34g1szbg9dn4p8b4jxrj7n80682954rql2";
  };

  propagatedBuildInputs = [ panda3d ];

  checkInputs = [ pytestrunner pytest-pylint pylint pytest ];
  pythonImportsCheck = [ "simplepbr" ];

  meta = with lib; {
    homepage = "https://github.com/Moguri/panda3d-simplepbr";
    description = ''
      A simple, basic, lightweight, no-frills PBR render pipeline 
      for Panda3D
    '';
    license = licenses.bsd3;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
