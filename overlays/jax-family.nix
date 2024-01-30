final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      jaxlib-bin = python-final.callPackage ../bleeding/jaxlib/bin.nix {
        inherit (final.config) cudaSupport;
      };
        
      jax = python-final.callPackage ../bleeding/jax {
        jaxlib = python-final.jaxlib-bin;
      };
      equinox = python-final.callPackage ../pkgs/equinox {
        jaxlib = python-final.jaxlib-bin;
      };
    })
  ];
}
