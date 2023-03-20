{ lib
, stdenv
, glibc
, buildPythonPackage
, fetchFromGitHub
, setuptools
, pytorch
}:

let cudatoolkit = pytorch.cudaPackages.cudatoolkit;
    cudnn = pytorch.cudaPackages.cudnn;

in buildPythonPackage rec {
  pname = "bitsandbytes";
  version = "0.37.1-pre";

  src = fetchFromGitHub {
    owner = "TimDettmers";
    repo = pname;
    rev = "2c8352e316d5428f57f47ec8b557dc9c9caf427f";
    sha256 = "sha256-7HwpoqI9J3FvVeA+J4jlrsyP5GkuiDRid2eOHHOjf3I=";
  };

  patches = [ ./fix_cuda.patch ];

  postPatch = ''
    echo "---- start post patch ----"
    export LIBRARY_PATH="${glibc}/lib:$LIBRARY_PATH"
    CUDA_HOME=${cudatoolkit} \
        CUDALIB=${cudatoolkit.lib} \
        make cuda11x CUDA_VERSION="" GPP="${stdenv.cc.cc}/bin/g++"
    ls bitsandbytes
    echo "---- end post patch ----"
  '';

  buildInputs = [ setuptools ];
  propagatedBuildInputs = [
    pytorch
  ];

  doCheck = false;
  pythonImportsCheck = [ "bitsandbytes" ];

  meta = with lib; {
    description = ''
      8-bit CUDA functions for PyTorch
    '';
    homepage = "https://github.com/TimDettmers/bitsandbytes";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
