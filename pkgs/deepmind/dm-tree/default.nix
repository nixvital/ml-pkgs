{ lib
, stdenv
, buildPythonPackage
, autoPatchelfHook
, python
, absl-py
, numpy
, attrs
, wrapt
}:

let wheels = {
      "x86_64-linux-python-3.9" = {
        url = https://files.pythonhosted.org/packages/43/8e/f2827985b559da76497a997193d2c1fee6217de6ca2921bca2d2ffd23aca/dm_tree-0.1.8-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "05xkcgpmm8gxmkbl7fsiffvx4zydnqn5804kydjh63a83m93a70q";
      };
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/cc/2b/a13e3a44f9121ecab0057af462baeb64dc50eb269de52648db8823bc12ae/dm_tree-0.1.8-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0i6iic147c9ni3rmx0i9w7zrlbc3jpy29472wpj3k25h3cvi9mz4";
      };
      "x86_64-linux-python-3.11" = {
        url = https://files.pythonhosted.org/packages/4a/27/c5e3580a952a07e5a1428ae952874796870dc8db789f3d774e886160a9f4/dm_tree-0.1.8-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "14s33w2zyy7plfp3pahhhdk03ls0zvlkwvpwps536mfqw16pddw3";
      };
    };

in buildPythonPackage rec {
  pname = "dm-tree";
  version = "0.1.8";
  format = "wheel";

  src = builtins.fetchurl wheels."${stdenv.system}-python-${python.pythonVersion}";

  propagatedBuildInputs = [
    absl-py
    numpy
    attrs
    wrapt
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  pythonImportsCheck = [
    "tree"
  ];

  meta = with lib; {
    homepage = "https://github.com/deepmind/tree";
    description = ''
        tree is a library for working with nested data structures
    '';
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; (linux ++ darwin);
  };
}
