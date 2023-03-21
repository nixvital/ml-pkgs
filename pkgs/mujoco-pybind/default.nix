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
        url = https://files.pythonhosted.org/packages/d6/ab/7bdae22f566a870c260a7e5332345bacbdb82000f4ba674a5393e8951daf/mujoco-2.3.3-2-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "1qkl5inbsljyw5q4qcf5bwbnh3vvr540kmbq91pd3lk0ifhd72pz";
      };
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/6d/27/90cc9b4f88c5b797417e1fbeacb7590cd85f7e464a8ab79f60c885708e39/mujoco-2.3.3-2-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0rahxcm0yvx8ysq5xcrk77pg1har7ivw5nw6imw04qd8pjax2zww";
      };
      "x86_64-linux-python-3.11" = {
        url = https://files.pythonhosted.org/packages/fd/a2/efbfcb5c9f02f7cfd8dff99631c409d202ff4360c7c50f09fe44d16aca0d/mujoco-2.3.3-2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "1pzkkwmizggzj9bfab2i2cbnrprsa6yq8q2r5s7am2lb936hpzzc";
      };
    };

in buildPythonPackage rec {
  pname = "mujoco";
  version = "2.3.3";
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
