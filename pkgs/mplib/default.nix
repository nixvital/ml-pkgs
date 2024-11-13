{ lib
, stdenv
, pkgs
, python
, autoPatchelfHook
, buildPythonPackage
, fetchurl
, numpy
, toppra
, transforms3d
}:

let 
  wheels = {
    "x86_64-linux-python-3.9" = {
      url = https://files.pythonhosted.org/packages/13/14/9c947ab4cfe25048efd74322bbe9e49285272e9aaf9c8a6610d8b79412a6/mplib-0.2.1-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
      sha256 = "558bcd4936986d3c142c67d5ad1f383f24f7c7d83c90d46e2b6841a2888333a6";
    };
    "x86_64-linux-python-3.10" = {
      url = https://files.pythonhosted.org/packages/c7/30/637fe639d5231d9bb267befde4fd409d2a1aececc692cd96052190e54232/mplib-0.2.1-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
      sha256 = "87cd73ce6974bbb4035ddf941b4d05b3eafb071faf217c860f262be65581cbb4";
    };
    "x86_64-linux-python-3.11" = {
      url = https://files.pythonhosted.org/packages/c9/3c/676109cc90f84db4e866f75c0241f5eb65788bb56296c941144be64b2d53/mplib-0.2.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
      sha256 = "3596cb217ca7a226dbf952133dbff5cf5529d8893388fb0e042a9cb4e7f26eab";
    };
    "x86_64-linux-python-3.12" = {
      url = https://files.pythonhosted.org/packages/dd/73/0316b490a15a0a0493b00b3078af173cc2ca825a5d5bc8e5529b31f2b456/mplib-0.2.1-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
      sha256 = "9d90de48f982f1e7412994ba851b223b411533a69514dc2fa21d655aed761295";
    };
  };
in buildPythonPackage rec {
  pname = "mplib";
  version = "0.2.1";

  src = fetchurl wheels."${stdenv.system}-python-${python.pythonVersion}";

  format = "wheel";

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  propagatedBuildInputs = [
    numpy
    toppra
    transforms3d
  ];

  pythonImportsCheck = [ "mplib" ];

  meta = with lib; {
    description = "a Lightweight Motion Planning Package";
    homepage = "https://motion-planning-lib.readthedocs.io/";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
