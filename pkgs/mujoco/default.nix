{ lib
, buildPythonPackage
, autoPatchelfHook
, fetchFromGitHub
, stdenv
, numpy
, py-glfw
, pyopengl
, absl-py
}:

buildPythonPackage rec {
  pname = "mujoco";
  version = "2.2.0";
  format = "wheel";

  src = builtins.fetchurl {
    url = https://files.pythonhosted.org/packages/0c/24/efa05ae99eb293d2071181af9842189a3834d43671a7b4c72777004c372b/mujoco-2.2.0-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
    sha256 = "10wrdpl28dxzpw9yv5g92m4n7k0j613q58agvyzxx4jcc42kabjc";
  };

  propagatedBuildInputs = [
    numpy
    py-glfw
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
