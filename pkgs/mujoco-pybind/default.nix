{ lib
, fetchurl
, buildPythonPackage
, autoPatchelfHook
, python
, stdenv
, numpy
, glfw
, pyopengl
, absl-py
}:

let wheels = {
      "x86_64-linux-python-3.9" = {
        url = https://files.pythonhosted.org/packages/02/c7/bec8fce4bbe70e11d6e81f78f9c6413eaaa02952db2be9d5a1a0fd8f8c0d/mujoco-2.3.5-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "114x37bq1c3951zyynaw0zamh3q615bjb51a2xbwpgn4njj84f12";
      };
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/7f/cd/7257c20302a51417ca970a6cdf77c8fd42ee5574b3563bb4ea98e75d3332/mujoco-2.3.5-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "181sn3rqyjfxx9mkhb5wdy1j1hvxbnvlhjx56wrdlks53x1iqjwg";
      };
      "x86_64-linux-python-3.11" = {
        url = https://files.pythonhosted.org/packages/ba/68/0975be108e0ddae4b28f2274cc33efc75db49ee7e6354433e519bc692ce6/mujoco-2.3.5-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "051xhhbby770dmnk8sj2irc1zix8hqkyy87qf7797a8pbv5qggrj";
      };
    };

in buildPythonPackage rec {
  pname = "mujoco";
  version = "2.3.5";
  format = "wheel";

  src = fetchurl wheels."${stdenv.system}-python-${python.pythonVersion}";

  propagatedBuildInputs = [
    numpy
    glfw
    pyopengl
    absl-py
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  meta = with lib; {
    homepage = "https://github.com/deepmind/mujoco";
    description = ''
      Multi-Joint dynamics with Contact. A general purpose physics simulator.
    '';
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; (linux ++ darwin);
  };
}
