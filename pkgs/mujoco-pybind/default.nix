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
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/61/4b/5c57057305c3291aeab610ad61196d7935ce042429f31fe1d82abcf538e9/mujoco-3.1.2-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "1dsgqspc8crpbh8z9ql62m3lr0f6rrqn1a01igszw5hc751cd1im";
      };
      "x86_64-linux-python-3.11" = {
        url = https://files.pythonhosted.org/packages/77/5f/35edc07f790cc6a211e1c2b42645c2410376342e0d3a8e4fca8587f3bb2e/mujoco-3.1.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "16yqhp9d9928m2d47h2g6c1c36xlaxz8b15ywzgxsifx0s2qcr9s";
      };
      "x86_64-linux-python-3.12" = {
        url = https://files.pythonhosted.org/packages/8f/5a/b22011daa82a4bec9341f140f8a0ce8ba684bd75227bde12c7174eb6b95d/mujoco-3.1.2-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "1fb06wgnlxj84fn2frm0pbnw78h7bz953w1mr2dvl2mz1g8hk83f";
      };
    };

in buildPythonPackage rec {
  pname = "mujoco";
  version = "3.1.2";
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
