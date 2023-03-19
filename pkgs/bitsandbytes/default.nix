{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, pytorch
}:

buildPythonPackage rec {
  pname = "bitsandbytes";
  version = "0.37.1-pre";

  src = fetchFromGitHub {
    owner = "TimDettmers";
    repo = pname;
    rev = "2c8352e316d5428f57f47ec8b557dc9c9caf427f";
    sha256 = "sha256-7HwpoqI9J3FvVeA+J4jlrsyP5GkuiDRid2eOHHOjf3I=";
  };

  buildInputs = [ setuptools ];
  propagatedBuildInputs = [
    pytorch
  ];

  doCheck = true;
  pythonImportsCheck = [ "bitsandbytes" ];

  meta = with lib; {
    # Need to correctly handle the CUDA part. It should be compiled
    # from the Makefile and generate .so files to the bisandbytes
    # directory.
    broken = true;
    description = ''
      8-bit CUDA functions for PyTorch
    '';
    homepage = "https://github.com/TimDettmers/bitsandbytes";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
