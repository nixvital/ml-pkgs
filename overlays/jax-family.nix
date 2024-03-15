final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      jaxlib-bin = python-final.callPackage ../bleeding/jaxlib/bin.nix {
        inherit (final.config) cudaSupport;
      };
        
      jax = python-final.callPackage ../bleeding/jax {
        jaxlib = python-final.jaxlib-bin;
      };

      equinox = python-prev.equinox.override {
        jaxlib = python-final.jaxlib-bin;
      };

      optax = python-prev.optax.override {
        jaxlib = python-final.jaxlib-bin;
      };

      chex = python-prev.chex.override {
        jaxlib = python-final.jaxlib-bin;
      };
    })
  ];
}
