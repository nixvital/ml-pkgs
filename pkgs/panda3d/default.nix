{ lib
, buildPythonPackage
, isPy37
, isPy38
, isPy39
, isPy310 ? false }:

assert (isPy37 || isPy38 || isPy39 || isPy310);

buildPythonPackage rec {
  pname = "panda3d";
  version = "1.10.10";
  format = "wheel";

  src = builtins.fetchurl (import ./wheel-urls.nix {
    inherit version isPy37 isPy38 isPy39 isPy310;
  });

  propagatedBuildInputs = [];

  pythonImportsCheck = [ "panda3d" ];

  meta = with lib; {
    homepage = "https://www.panda3d.org";
    description = ''
      Powerful, mature open-source cross-platform game engine for 
      Python and C++, developed by Disney and CMU
    '';
    license = licenses.bsd3;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
