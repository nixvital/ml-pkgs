{
  description = "Provide extra Nix packages for Machine Learning and Data Science";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    overlays.default = import ./overlay.nix;
  } // inputs.utils.lib.eachSystem [
    "x86_64-linux"
  ] (system:
    let pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            # Use this overlay to provide customized python packages
            # for development environment.
            self.overlays.default
          ];
        };
    in rec {
      devShells.default = pkgs.callPackage ./pkgs/dev-shell {};
      
      packages = {
        inherit (pkgs.python3Packages)
          # TODO(breakds): Currently jax does not build. Should fix it.
          # jaxWithCuda11
          # jaxlibWithCuda11
          # equinoxWithCuda11
          pytorchWithCuda11
          pytorchLightningWithCuda11
          torchvisionWithCuda11
          pytorchvizWithCuda11
          atari-py-with-rom
          ale-py-with-roms  # TODO(breakds): Compatibility
          huggingface-transformers
          gym-notices
          gym  # TODO(breakds): Also bring in gymasim
          gym3
          procgen
          redshift-connector
          awswrangler
          numerapi
          highway-env
          panda3d
          panda3d-simplepbr
          panda3d-gltf
          metadrive-simulator
          mujoco
          pytorch-tabnet
          pybulletx;
          # open3d;
      };

      # hydraJobs = {
      #   devShell = devShell;
      # };
    });
}
