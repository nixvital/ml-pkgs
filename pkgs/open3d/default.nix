# Original gist: https://gist.github.com/rowanG077/6e12b2edda19aa9179b238bc442acaa3, as well as the github issue: https://github.com/NixOS/nixpkgs/issues/115218

{ stdenv
, lib
, buildPythonPackage
, fetchurl
, python
, torch
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
, libtensorflow
, nbformat
, libusb
, libGL
, expat
, libdrm
, llvm_10 }:

let wheels = {
      "x86_64-linux-python-3.9" = {
        url = https://files.pythonhosted.org/packages/5b/97/d875534b7fd35ff85eab4f30e2151712346ea0b53144c93de080aa331b3c/open3d-0.17.0-cp39-cp39-manylinux_2_27_x86_64.whl;
        sha256 = "04nc5vxkqgdyhl7xhf2pahrx8f2pcvfcmw728dk3jc9addd27fas";
      };
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/50/cd/1128fbaab30faeb356e05cb00ed01a65a7ef57cacfac9188ff1ac86e8e86/open3d-0.17.0-cp310-cp310-manylinux_2_27_x86_64.whl;
        sha256 = "0mqn8dbdgck434zmfs1548rmr0a521l9zl658s16ifr0fdlh1hrx";
      };
    };

    inherit (torch) cudaPackages;

in buildPythonPackage rec {
  pname = "open3d";
  version = "0.17.0";
  format = "wheel";

  src = fetchurl wheels."${stdenv.system}-python-${python.pythonVersion}";

  postInstall = ''
    ln -s "${llvm_10.lib}/lib/libLLVM-10.so" "$out/lib/libLLVM-10.so.1"

    # Now, replace some of the prebuilt shared objects
    rm $out/lib/python3.10/site-packages/open3d/libGL.so.1
    ln -s "${libGL}/lib/libGL.so.1" "$out/lib/python3.10/site-packages/open3d/libGL.so.1"
  '';

  nativeBuildInputs = [
    autoPatchelfHook
    pythonRelaxDepsHook
  ];

  # TODO(breakds): There are shared libraries still missing, need to be fixed.
  # Probably better addressed by building from source.
  #
  # I think missing the following cripples open3d by not having some rendering
  # and torch integration, but I am not sure.
  # 
  # libtorch_cuda_cpp.so
  # libtorch_cuda_cu.so
  # libglapi.so.0  
  autoPatchelfIgnoreMissingDeps = true;

  buildInputs = [
    stdenv.cc.cc.lib
    libusb.out
    cudaPackages.cudatoolkit
    libGL
    libtensorflow
    torch
    expat.dev
    libdrm
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
