{
  description = "Provide extra Nix packages for Machine Learning and Data Science";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/22.05";

    utils.url = "github:numtide/flake-utils";
    utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    overlay = import ./overlay.nix;
  } // inputs.utils.lib.eachSystem [
    "x86_64-linux"
  ] (system:
    let pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            # Use this overlay to provide customized python packages
            # for development environment.
            self.overlay
          ];
        };
    in rec {
      devShell = pkgs.callPackage ./pkgs/dev-shell {};
      
      packages = {
        inherit (pkgs.python3Packages)
          jaxWithCuda11
          jaxlibWithCuda11
          equinoxWithCuda11
          pytorchWithCuda11
          pytorchLightningWithCuda11
          torchvisionWithCuda11
          pytorchvizWithCuda11
          atari-py-with-rom
          py-glfw
          huggingface-transformers
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
          mujoco;
      };

      hydraJobs = {
        devShell = devShell;
      };
    });
}
