{ lib
, fetchFromGitHub
, buildPythonPackage
, pythonOlder
, jax
, jaxlib
}:

buildPythonPackage rec {
  pname = "equinox";
  version = "0.5.2";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "patrick-kidger";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-LVzRMCLkU1b/0xpHTRbiKg+OudU0hIF2O1Ak95I+wCI=";
  };

  # jaxlib is _not_ included in propagatedBuildInputs because there are
  # different versions of jaxlib depending on the desired target hardware. The
  # JAX project ships separate wheels for CPU, GPU, and TPU. Currently only the
  # CPU wheel is packaged.
  propagatedBuildInputs = [
    jax
  ];

  checkInputs = [
    jaxlib
  ];

  meta = with lib; {
    homepage = "https://github.com/patrick-kidger/equinox";
    description = ''
      Callable PyTrees and filtered transforms => neural networks in JAX.
    '';
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
