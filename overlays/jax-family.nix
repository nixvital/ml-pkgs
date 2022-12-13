final: prev: let
  cuda11 = final.cudaPackages_11_6;

in {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
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
