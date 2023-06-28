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
        url = https://files.pythonhosted.org/packages/48/4f/ab8bcb1eed1ab8d5866d31cf8cd48065cff28668623e7f67dc8addd7accb/mujoco-2.3.6-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "02384swcqmir6x84nr0ii735n6bnl8j34apz7bi93c6rhn7ksc4g";
      };
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/08/33/ec4a7b1073d9f3e5bebd9a19c3a70b02093c2926db8fb48d2aed59f30e31/mujoco-2.3.6-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "1f8g6j3wzd6wmr80hp2rlaf4crkf27zgsssg2x9a8r3mfwhjafpp";
      };
      "x86_64-linux-python-3.11" = {
        url = https://files.pythonhosted.org/packages/25/60/4d05a28578e2cf021c72b46fda7420a2ffce6eb547ea443147f942661a6b/mujoco-2.3.6-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "1jhd3jla7q0m503y6gwgvd4nbvka9hzc057mffa1h9gql6zsrw0x";
      };
    };

in buildPythonPackage rec {
  pname = "mujoco";
  version = "2.3.6";
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
