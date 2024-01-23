final: prev:

let cuda-118 = prev.cudaPackages_11_8;

in {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      # jaxlibWithCuda = python-prev.jaxlibWithCuda.override {
      #   cudaPackages = cuda-118;
      # };
      equinoxWithCuda11 = python-final.callPackage ../pkgs/equinox {};
    })
  ];
}
