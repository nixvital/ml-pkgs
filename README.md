# ml-pkgs - Machine Learning and Data Science Nix Overlays

This Nix flake provides a set of overlays for machine learning and data science packages. It also includes simulation and robotics packages that are widely used in machine learning research as well. The overlays are defined in the overlays attribute set of the flake's outputs.

To use an overlay in another flake, you can import it in your flake's outputs block like this:

```nix
outputs = { self, nixpkgs, ... }@inputs: {
  overlays = {
    dev = nixpkgs.lib.composeManyExtensions [
      inputs.ml-pkgs.overlays.torch-family
      # Add some other overlays
    ];
  };
};
```

The available overlays in this flake are:

- torch-family: packages for the PyTorch machine learning framework and its ecosystem
- jax-family: packages for the JAX machine learning framework and its ecosystem
- data-utils: packages for data manipulation and storage
- simulators: packages for simulators and environments for reinforcement learning
- misc: miscellaneous packages for machine learning and data science

There is also a special overlay for scientific computing / machine learning related c++ packages, called `cc-batteries`.

Please note that some of the packages in this flake may have dependencies on proprietary or non-free software. To allow the installation of such packages, you may need to set the config.allowUnfree option in your Nix configuration.

## Using templates

Alternatively, you may want to automatically generate `flake.nix` for your project using templates. This is also the recommended way to start using `ml-pkgs`. Please refer to [nixvital/flake-template](https://github.com/nixvital/flake-templates) for details.

---

This README.md file was partly generated with the help of ChatGPT, an OpenAI language model.
