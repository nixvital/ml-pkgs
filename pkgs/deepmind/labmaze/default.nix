{ lib
, stdenv
, buildPythonPackage
, autoPatchelfHook
, python
, absl-py
, numpy
, setuptools
}:

let wheels = {
      "x86_64-linux-python-3.9" = {
        url = https://files.pythonhosted.org/packages/2d/19/2d46c90732a1ac60a872169c4ef0a246c322d7d4ece73c47bac93dc86877/labmaze-1.0.6-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "1s91lmvnwab8p28dmaa9jd4a6x0xbhj4fj91h20jvz5k1x7cks5y";
      };
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/4d/93/abac7877e1d7de984a2f0f5be561ff0dc795ae7e22595cf2f7c7032cd27e/labmaze-1.0.6-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0sj8xr1kyi838aq0wqjif6vyppzx4q2h94c1vs8ifm5w96yk6r2f";
      };
      "x86_64-linux-python-3.11" = {
        url = https://files.pythonhosted.org/packages/a7/ce/be3952d7036b009f6dd004b6f5dfe97bbff79572ef0cf56a734aaead030f/labmaze-1.0.6-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0zl1qr06qbz7rapy6pa5270x6jh7ssa4a2d8pvdbdncb4f9jfizz";
      };
    };

in buildPythonPackage rec {
  pname = "labmaze";
  version = "1.0.6";
  format = "wheel";

  src = builtins.fetchurl wheels."${stdenv.system}-python-${python.pythonVersion}";

  propagatedBuildInputs = [
    absl-py
    numpy
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    setuptools
  ];

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  pythonImportsCheck = [
    "labmaze"
  ];

  meta = with lib; {
    homepage = "https://github.com/deepmind/labmaze";
    description = ''
      A standalone release of DeepMind Lab's maze generator with Python bindings
    '';
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; (linux ++ darwin);
  };
}
