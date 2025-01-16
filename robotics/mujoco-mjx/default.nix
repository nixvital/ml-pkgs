{ lib, pythonOlder, buildPythonPackage, fetchFromGitHub, setuptools, absl-py
, etils, jax, jaxlib, scipy, trimesh, fsspec, importlib-resources
, typing-extensions, zipp, importlib-metadata, ml-dtypes, numpy, opt-einsum
, exceptiongroup, iniconfig, packaging, pluggy, pyparsing, tomli, execnet
, mujoco }:

buildPythonPackage rec {
  pname = "mujoco-mjx";
  version = "3.2.5";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "google-deepmind";
    repo = "mujoco";
    rev = version;
    hash = "sha256-XKN489oexHf2/Gv0MVxXUzqyeJJTJXV99+fNi8shdsg=";
  };

  # MuJoCo MJX is actually a completely re-implementation of MuJoCo using Jax.
  # It resides in the `mjx` subdirectory.
  sourceRoot = "${src.name}/mjx";

  buildInputs = [ setuptools ];

  propagatedBuildInputs = [
    absl-py
    etils
    jax
    jaxlib
    scipy
    trimesh
    fsspec
    importlib-resources
    typing-extensions
    zipp
    importlib-metadata
    ml-dtypes
    numpy
    opt-einsum
    iniconfig
    packaging
    pluggy
    pyparsing
    execnet
    mujoco
  ] ++ (lib.optionals (pythonOlder "3.11") [ exceptiongroup tomli ]);

  meta = with lib; {
    description = ''
      This package is a re-implementation of the MuJoCo physics engine in JAX. 
    '';
    homepage = "https://mujoco.readthedocs.io/en/stable/mjx.html";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
