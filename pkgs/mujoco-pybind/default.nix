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
, etils
, zipp
, typing-extensions
, importlib-resources
}:

let wheels = {
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/7b/d3/9ae4171d6454f3fd2119bfe9e31849c6fc45c68aa29c84d91998674f994b/mujoco-3.1.1-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0iwaz4bxm7r8l8jw1s1jfwdp5iqd6aqblwf553k2wqbfy2fhzb2i";
      };
      "x86_64-linux-python-3.11" = {
        url = https://files.pythonhosted.org/packages/d5/52/f034c94af7c398729f0cc6b4251e324700444478483168552b2dcc774a13/mujoco-3.1.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "04005rarx0597hhsgz9895vy5czbhhixs2gwqsh46m3zyad8mvis";
      };
      "x86_64-linux-python-3.12" = {
        url = https://files.pythonhosted.org/packages/a3/d5/b8be6ad03eb055bd32cb0c8ceda413f2b02f38a59622bc9ebd790be83ea4/mujoco-3.1.1-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "14dmwnmv4n4fln6wf6caszndds3n5n9scpr0rqp32fdpxzkchcap";
      };
    };

in buildPythonPackage rec {
  pname = "mujoco";
  version = "3.1.1";
  format = "wheel";

  src = fetchurl wheels."${stdenv.system}-python-${python.pythonVersion}";

  propagatedBuildInputs = [
    numpy
    glfw
    pyopengl
    absl-py
    etils
    zipp
    typing-extensions
    importlib-resources
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
