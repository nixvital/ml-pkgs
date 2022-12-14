# Original gist: https://gist.github.com/rowanG077/6e12b2edda19aa9179b238bc442acaa3

{ stdenv
, lib
, buildPythonPackage
, fetchurl
, python
, pytorch
, jupyter-packaging
, jupyterlab
, addict
, pyquaternion
, scipy
, scikitlearn
, numpy
, matplotlib
, ipywidgets
, plyfile
, pandas
, pyyaml
, tqdm
, tree
, dash
, configargparse
, zip
, autoPatchelfHook
, pythonRelaxDepsHook
# TODO(breakds): Should remove libtensorflow dependencies
, libtensorflow-bin
, nbformat
, libusb
, libGL }:

let pyVerNoDot = builtins.replaceStrings [ "." ] [ "" ] python.pythonVersion;
    version = "0.16.0";
    sources = {
      "39" = {
        name = "open3d-0.16.0-cp39-cp39-manylinux_2_27_x86_64.whl";
        url = https://files.pythonhosted.org/packages/44/2d/039c3035cb6eb8f23203dd9a8bc401a4e05b340680f9a09959b2cce9233b/open3d-0.16.0-cp39-cp39-manylinux_2_27_x86_64.whl;
        sha256 = "1yqyv1q0yh37kgkjlggb8rfihbgm65j0y210pksb049kyj9fl6i9";
      };
      "310" = {
        name = "open3d-0.16.0-cp310-cp310-manylinux_2_27_x86_64.whl";
        url = https://files.pythonhosted.org/packages/c5/18/0e50c0834a2504878bfac3549365704beba004b9322700160c1012d41cf8/open3d-0.16.0-cp310-cp310-manylinux_2_27_x86_64.whl;
        sha256 = "0qapm9n6cyp2yp6d9cvwp6cpglbzc32y20mjnnr8igciqmr5xr7v";
      };
    };
in buildPythonPackage rec {
  pname = "open3d";
  format = "wheel";
  inherit version;

  src = fetchurl sources."${pyVerNoDot}";

  nativeBuildInputs = [
    autoPatchelfHook
    pythonRelaxDepsHook
  ];

  buildInputs = [
    # so deps
    libtensorflow-bin
    stdenv.cc.cc.lib
    libusb.out
    pytorch.cudaPackages.cudatoolkit.lib
    libGL
  ];

  pythonRelaxDeps = [ "dash" "nbformat" ];

  propagatedBuildInputs = [
    # py deps
    ipywidgets
    tqdm
    pyyaml
    pandas
    plyfile
    scipy
    scikitlearn
    numpy
    matplotlib
    dash
    configargparse
    nbformat
    # TODO(breakds): Having jupyter as dependencies is so weird. I will strip it
    # of from this package later.
    jupyter-packaging
    addict
    pyquaternion
    jupyterlab
  ];
}
