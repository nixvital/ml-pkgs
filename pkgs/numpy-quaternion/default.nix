# TODO(breakds): Build this from source so that we have 3.11 support as well.

{ lib
, fetchurl
, stdenv
, buildPythonPackage
, autoPatchelfHook
, python
, numpy
, scipy
, numba
}:

let wheels = {
      "x86_64-linux-python-3.9" = {
        url = https://files.pythonhosted.org/packages/21/88/d55b90f97346a5f26622c3c1980b5a6e80d83f5c51fa16741f526ed5b17e/numpy_quaternion-2022.4.2-cp39-cp39-manylinux_2_17_aarch64.manylinux2014_aarch64.whl;
        sha256 = "1anhhp2rhmq2rgikkj2wc0dv611cndb79p7sc3jfsyhry5gwhj5j";
      };
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/d7/0c/7af44d49886cf99f701c96030b0b02c52092014ebb3a8f7e84fc25d50b46/numpy_quaternion-2022.4.2-cp310-cp310-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "1ymf53kp13nf500inrhg2vk5g9gzxc4m0v1gspyxyj2fbr6slzjz";
      };
    };

in buildPythonPackage rec {
  pname = "numpy-quaternion";
  version = "2022.4.2";
  format = "wheel";

  src = fetchurl wheels."${stdenv.system}-python-${python.pythonVersion}";

  propagatedBuildInputs = [
    numpy
    scipy
    numba
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  pythonImportsCheck = [
    "quaternion"
  ];

  meta = with lib; {
    homepage = "https://github.com/moble/quaternion";
    description = ''
      Add built-in support for quaternions to numpy
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; (linux ++ darwin);
  };
}
