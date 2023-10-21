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
        url = https://files.pythonhosted.org/packages/c2/ef/09e0a263487c26ddc76f5cdcf854bd161bd77888a4ec13fe560f1caf63f5/mujoco-3.0.0-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "16yxsm5s0kkcp0g6w1q770m38cqgi47k3fr3lyqgfy0pk5pcwg74";
      };
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/ba/c3/ac38f009d419f3fd82402e23c367c545a104a272d1d64269e97de9b53c30/mujoco-3.0.0-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0xih11mbydd2skjkwm5zzdl04z06n7x3j1hrw6hz4y28r1c7vs27";
      };
      "x86_64-linux-python-3.11" = {
        url = https://files.pythonhosted.org/packages/58/b6/d0f3c40437dc7962ed73c591f7b09e43d64b9b03786de72fdc62d74c3190/mujoco-3.0.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "08gs6xwyid7a5z2h3cd5lg7c7h60c1azjjf3yi9r2f3wysw8z81j";
      };
    };

in buildPythonPackage rec {
  pname = "mujoco";
  version = "3.0.0";
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
