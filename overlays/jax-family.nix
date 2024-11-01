final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      jaxlib = python-final.callPackage ../bleeding/jaxlib {
        inherit (final.config) cudaSupport;
      };
        
      jax = python-prev.jax.override {
        jaxlib = python-final.jaxlib;
      };

      equinox = python-prev.equinox.override {
        jaxlib = python-final.jaxlib;
      };

      optax = python-prev.optax.override {
        jaxlib = python-final.jaxlib;
      };

      chex = python-prev.chex.override {
        jaxlib = python-final.jaxlib;
      };

      mujoco-mjx = python-final.callPackage ../bleeding/mujoco-mjx {
        jaxlib = python-final.jaxlib;
      };

      flax = python-prev.flax.override {
        jaxlib = python-final.jaxlib;
      };
    })
  ];
}
