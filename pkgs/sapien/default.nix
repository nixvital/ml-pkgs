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
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/b9/8a/39dbc5128acf3939403fd8984c01f340c7bda3d6814fb069164290ab697a/sapien-2.2.1-cp310-cp310-manylinux2014_x86_64.whl;
        sha256 = "0p24fxqb719yjwkd0rfgnbpilnjdg2m6j20kznwwg3zdhczk11gb";
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
