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
        url = https://files.pythonhosted.org/packages/51/b5/63e576514c5897bb64cb7dc635cef3b494c86e2f110d2a7267d61f47f3c9/mujoco-3.1.3-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0k0mn4i2rlx28ss697lfaqa8l14aykn1dk4k133x27jqzxwq4mzi";
      };
      "x86_64-linux-python-3.11" = {
        url = https://files.pythonhosted.org/packages/f6/67/563b4755fd77a898cda35f448d4f8f5f062932965d7833de75287451ffcd/mujoco-3.1.3-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "1fdl17wnsl2x5irgc2z45jjrwqj5dpm7ph334r6jg9wh9h9wd7gp";
      };
      "x86_64-linux-python-3.12" = {
        url = https://files.pythonhosted.org/packages/be/a9/270cc9947fdb60ebe0eeb9c701e94fe161ba21407b79a402df19fbabcb33/mujoco-3.1.3-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "14hlivc2gsjf7snyqxcpvvm4lv6ddggb2pizir9i36pq9d0j1hfl";
      };
    };

in buildPythonPackage rec {
  pname = "mujoco";
  version = "3.1.3";
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
