{
  description = "Provide extra Nix packages for Machine Learning and Data Science";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?rev=ff639fcd13f4adf5f7699fff135dcba2cac6cf08";

    utils.url = "github:numtide/flake-utils";
    utils.inputs.nixpkgs.follows = "nixpkgs";
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
          jaxWithCuda11
          jaxlibWithCuda11
          equinoxWithCuda11
          pytorchWithCuda11
          pytorchLightningWithCuda11
          torchvisionWithCuda11
          pytorchvizWithCuda11
          # atari-py-with-rom
          ale-py-with-roms
          huggingface-transformers
          gym-notices
          gym
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
          pytorch-tabnet;
          # open3d;
      };

      # hydraJobs = {
      #   devShell = devShell;
      # };
    });
}
