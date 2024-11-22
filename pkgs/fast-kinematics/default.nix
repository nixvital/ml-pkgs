{ lib
, stdenv
, python
, buildPythonPackage
, fetchurl
, autoPatchelfHook
, torch
, numpy
}:
let 
  wheels = {
    "x86_64-linux-python-3.9" = {
      url = https://files.pythonhosted.org/packages/57/01/fe14947878e7cc05ed8beebbbf9e92955eb4d462e7a5be6540505835ef35/fast_kinematics-0.2.2-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
      sha256 = "c01274f03fda3660c45816a86a5db820ec3d2ebc19abfac66a49451701a308f4";
    };
    "x86_64-linux-python-3.10" = {
      url = https://files.pythonhosted.org/packages/49/c7/c11523db2e63fd50f87276128bf26f758ffae8fcc997cdbc437029409047/fast_kinematics-0.2.2-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
      sha256 = "908f7ec94dfd947028170c0a37b326b3dde1b8c0a14417646e874f3e81b2cd71";
    };
    "x86_64-linux-python-3.11" = {
      url = https://files.pythonhosted.org/packages/5a/6e/9f9d89f2c135d33b3c2568962415e9210b7f7e74a9d7646c638cbb5121e6/fast_kinematics-0.2.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
      sha256 = "d2e24e736944aa7723f7445c8630d421eb61a6fcd2c23822e9bf4c6bc2d5bf69";
    };
    "x86_64-linux-python-3.12" = {
      url = https://files.pythonhosted.org/packages/1b/03/6d52d961d47d0a3847967e477abfd41f4ac4b4b6001a0172359a4981491b/fast_kinematics-0.2.2-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
      sha256 = "0500a63494e69d1e51d9770f4fa429e1d50dbbe27e5c448f8daca32bc4e03bb6";
    };
  };
in buildPythonPackage rec {
  pname = "fast-kinematics";
  version = "0.2.2";

  src = fetchurl wheels."${stdenv.system}-python-${python.pythonVersion}";

  format = "wheel";

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  propagatedBuildInputs = [
    numpy
    torch
  ];

  pythonImportsCheck = [ "fast_kinematics" ];

  meta = with lib; {
    homepage = "https://github.com/Lexseal/fast_kinematics";
    description = "Cuda enabled library for calculating forward kinematics and Jacobian of a kinematics chain.";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
