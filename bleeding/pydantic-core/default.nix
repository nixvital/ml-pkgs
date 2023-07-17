{ lib
, fetchurl  
, buildPythonPackage
, autoPatchelfHook
, pythonRelaxDepsHook
, python
, stdenv
, typing-extensions
}:

let wheels = {
      # "x86_64-linux-python-3.9" = {
      #   url = https://files.pythonhosted.org/packages/48/4f/ab8bcb1eed1ab8d5866d31cf8cd48065cff28668623e7f67dc8addd7accb/mujoco-2.3.6-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
      #   sha256 = "02384swcqmir6x84nr0ii735n6bnl8j34apz7bi93c6rhn7ksc4g";
      # };
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/2d/1e/d7ef26e565273dd26c0309244f43c0ec555ed4ba9ef83d794967b432c4c9/pydantic_core-2.3.0-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0qcbigf4dg4vknvg4i4qs5wr4qnb6i27571dv6a976f8cppfg81q";
      };
      # "x86_64-linux-python-3.11" = {
      #   url = https://files.pythonhosted.org/packages/25/60/4d05a28578e2cf021c72b46fda7420a2ffce6eb547ea443147f942661a6b/mujoco-2.3.6-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
      #   sha256 = "1jhd3jla7q0m503y6gwgvd4nbvka9hzc057mffa1h9gql6zsrw0x";
      # };
    };

in buildPythonPackage rec {
  pname = "pydantic-core";
  version = "2.3.0";
  format = "wheel";

  src = fetchurl wheels."${stdenv.system}-python-${python.pythonVersion}";

  propagatedBuildInputs = [
    typing-extensions  
  ];

  # This one does not seem to like nixpkgs's typing-extensions even if I
  # override the version, so fuck it.
  pythonRelaxDeps = [ "typing-extensions" ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  nativeBuildInputs = [
    autoPatchelfHook
    pythonRelaxDepsHook
  ];

  meta = with lib; {
    homepage = "https://github.com/pydantic/pydantic-core";
    description = ''
      Multi-Joint dynamics with Contact. A general purpose physics simulator.
    '';
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; (linux ++ darwin);
  };
}
