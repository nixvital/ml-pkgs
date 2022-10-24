# Original gist: https://gist.github.com/rowanG077/6e12b2edda19aa9179b238bc442acaa3

{ stdenv
, lib
, buildPythonPackage
, fetchurl
, python
, pytorchWithCuda
, cudaPackages
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
, zip
, autoPatchelfHook
# TODO(breakds): Should remove libtensorflow dependencies
, libtensorflow-bin
, libusb
, libGL }:

let pyVerNoDot = builtins.replaceStrings [ "." ] [ "" ] python.pythonVersion;
    version = "0.15.2";
    sources = {
      "39" = {
        name = "open3d-0.15.2-cp39-cp39-manylinux_2_27_x86_64.whl";
        url = https://files.pythonhosted.org/packages/e1/b2/58f3be3083e9e6893027acd9e80c7556706db3470ec671465b932c81d143/open3d-0.15.2-cp39-cp39-manylinux_2_27_x86_64.whl;
        sha256 = "sha256-3s1oeI7elwrHNo1yEm7494MsCqx7uSooT45pGvlrVnk=";
      };
    };
in buildPythonPackage rec {
  pname = "open3d";
  format = "wheel";
  inherit version;

  src = fetchurl sources."${pyVerNoDot}";

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    # so deps
    libtensorflow-bin    
    stdenv.cc.cc.lib
    libusb.out
    pytorchWithCuda
    cudaPackages.cudatoolkit.lib
    libGL
  ];

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
    # TODO(breakds): Having jupyter as dependencies is so weird. I will strip it
    # of from this package later.
    jupyter-packaging
    addict
    pyquaternion
    jupyterlab
  ];
}
