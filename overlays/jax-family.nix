final: prev: let
  cuda11 = final.cudaPackages_11_8;

in {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    # TODO(breakds): Jax is failing at this moment with Cuda 11.8.
    # Should fix it.
    (python-final: python-prev: {
      jaxlibWithCuda11 = python-prev.jaxlibWithCuda.override {
        cudaPackages = cuda11;
      };

      jaxWithCuda11 = python-prev.jax.override {
        jaxlib = python-final.jaxlibWithCuda11;
      };

      equinoxWithCuda11 = python-final.callPackage ../pkgs/equinox {
        jax = python-final.jaxWithCuda11;
      };
    })
  ];

}
