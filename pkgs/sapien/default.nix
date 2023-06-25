{ lib
, fetchurl
, buildPythonPackage
, pythonRelaxDepsHook
, python
, stdenv
, autoPatchelfHook
, numpy
, requests
, opencv4
, transforms3d
, vulkan-headers
, vulkan-loader
}:

let wheels = {
      "x86_64-linux-python-3.8" = {
        url = https://files.pythonhosted.org/packages/96/67/7b41e20984e8d7279fd182824a8765f6fed6b70c298b2d4513b7b0737766/sapien-2.2.1-cp38-cp38-manylinux2014_x86_64.whl;
        sha256 = "00hlfnyxxgss0aksaxhwvsd69wxqwg9i68v39w0kwq6pqjy5lslk";
      };
      "x86_64-linux-python-3.9" = {
        url = https://files.pythonhosted.org/packages/39/06/2b9e8477f87cca6df3f0cee7738934e2ee815818c952f526fd8eaf8c1085/sapien-2.2.1-cp39-cp39-manylinux2014_x86_64.whl;
        sha256 = "0pp7ids7gc90q9g5ywj98lji57rzxsdrw72c55r8nwgal0nsi97j";
      };
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/b9/8a/39dbc5128acf3939403fd8984c01f340c7bda3d6814fb069164290ab697a/sapien-2.2.1-cp310-cp310-manylinux2014_x86_64.whl;
        sha256 = "0p24fxqb719yjwkd0rfgnbpilnjdg2m6j20kznwwg3zdhczk11gb";
      };
      "x86_64-linux-python-3.11" = {
        url = https://files.pythonhosted.org/packages/18/e9/de53f5def0fefa55854c017349c42fe5c5322eda0a3e33636794fe21a4d3/sapien-2.2.1-cp311-cp311-manylinux2014_x86_64.whl;
        sha256 = "1mpw78xvbqddwy874vgpbkb34kq8nr3iyywaxv5syjggk5166n7w";
      };
    };

in buildPythonPackage rec {
  pname = "sapien";
  version = "2.2.1";
  format = "wheel";

  src = fetchurl wheels."${stdenv.system}-python-${python.pythonVersion}";

  propagatedBuildInputs = [
    numpy
    requests
    opencv4
    transforms3d
  ];

  pythonRemoveDeps = [ "opencv-python" ];

  buildInputs = [
    stdenv.cc.cc.lib
    vulkan-headers
    vulkan-loader
  ];

  nativeBuildInputs = [
    autoPatchelfHook
    pythonRelaxDepsHook
  ];

  # This is important, otherwise it will report ELF load command
  # address/offset not page-aligned.
  dontStrip = true;

  meta = with lib; {
    homepage = "https://github.com/haosulab/SAPIEN";
    description = ''
      A SimulAted Part-based Interactive ENvironment
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
