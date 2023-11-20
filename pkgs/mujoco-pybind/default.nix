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
        url = https://files.pythonhosted.org/packages/56/9b/dc44edd747e12fbab8793746876cb792ba66683477661baaf93e4a3bdf37/mujoco-3.0.1-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "1ixk9dsw942snn5ssl15wk8g3071v8v4ja2md3siz27aga7qjaky";
      };
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/7a/fa/d78b04b55f7cb1b2e66c2893ae9d847a426ed32e60658b6055af28f39eac/mujoco-3.0.1-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "151gim16ai1ifdnrf70k45h026qdgznzv041xfb47gzyb20f0k1z";
      };
      "x86_64-linux-python-3.11" = {
        url = https://files.pythonhosted.org/packages/47/99/102271e46fd00a15e7d47ecf7ebff2d9c33c9cdca484bf0dce60189decac/mujoco-3.0.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0qgmmfvl3da9lc40gbmg9alh0h09121mdjb7y45vqkmx56bf2fd8";
      };
      "x86_64-linux-python-3.12" = {
        url = https://files.pythonhosted.org/packages/44/a4/fac9ce45d933d71d484696a68c4634f32cbc65db74eb1e2e77ce327375f4/mujoco-3.0.1-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "1mkipp8x080sfnydf8zrwfm49qv4zkhjx9yrad7in9b6y29myx4i";
      };
    };

in buildPythonPackage rec {
  pname = "mujoco";
  version = "3.0.1";
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
