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
        url = https://files.pythonhosted.org/packages/be/ba/6a089650aa1bc6930c65993c2b8f94bcad9f0070a0c46e46e70d117ba609/mujoco-2.3.1.post1-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0ffq4yygm66zpjwhms509wypb2gqj7a7xw5fl7gv3jklavhbh2z4";
      };
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/a1/70/339a1b20524690d36913eeadb0d23a15dc1715dec2f4ec5f986dc60b463e/mujoco-2.3.1.post1-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0nkgbdbh93nr40bddb3i9ybf8wz1i1rjk07m9xjkjjmxs1h1rva0";        
      };
      "x86_64-linux-python-3.11" = {
        url = https://files.pythonhosted.org/packages/38/fe/8be7204b50bea5f8aec969cad3c92ffc386485cf108b678b4dfac8ff056d/mujoco-2.3.1.post1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "1v1s2bjxl4845wq1msy0ph6wh83hs56ssz42nfvdckmjy3jgmd28";
      };
    };

in buildPythonPackage rec {
  pname = "mujoco";
  version = "2.3.1.post1";
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
