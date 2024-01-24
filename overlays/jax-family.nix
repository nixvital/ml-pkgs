final: prev: {
  # The current jaxlib-bin is built against CUDA 12.2. We will have to
  # use this specific version. Otherwise jaxlib-bin will be built
  # successfully but refuse to work with CUDA, e.g. 
  #
  # >>> import jax
  # >>> jax.devices()
  # CUDA backend failed to initialize: Found CUDA version 12000, but JAX was built against version 12020, which is newer. The copy of CUDA that is installed must be at least as new as the version against which JAX was built. (Set TF_CPP_MIN_LOG_LEVEL=0 and rerun for more info.)
  cudaPackagesGoogle = prev.cudaPackages_12_2;
  
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      jax = python-final.callPackage ../bleeding/jax {
        jaxlib = python-final.jaxlib-bin;
      };
      equinox = python-final.callPackage ../pkgs/equinox {
        jaxlib = python-final.jaxlib-bin;
      };
    })
  ];
}
