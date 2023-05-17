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
        url = https://files.pythonhosted.org/packages/01/8b/0abf42e7c526b9f76d6eabe21a6a1630d165b35fbfbd8fe7e04022fc4bbd/mujoco-2.3.4-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "1dh7h1air317j4c5dgari2j22b408irz1xmx2gfp7vi5pnwqjbax";
      };
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/02/7c/b784c3c3eca5f0744fd481c9d76f646fa9b8d064930118c36238e8b9e5fd/mujoco-2.3.4-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0jqmdz3zgw9jd6fzf09kkff0i1v9k0balrsalnbkifzbvvwpybf4";
      };
      "x86_64-linux-python-3.11" = {
        url = https://files.pythonhosted.org/packages/88/a4/4bdc891ff9e1262c10570a86683696326a8b6d2d09aef70262c90d89a8e7/mujoco-2.3.4-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0k74j3cgsls8wh3qdc875mam4ys12j7djnpzzllb6x22rrbbvdj7";
      };
    };

in buildPythonPackage rec {
  pname = "mujoco";
  version = "2.3.4";
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
