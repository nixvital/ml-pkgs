{
  description = "Provide extra Nix packages for Machine Learning and Data Science";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    overlays = {
      torch-family = import ./overlays/torch-family.nix;
      jax-family = import ./overlays/jax-family.nix;
      data-utils = import ./overlays/data-utils.nix;
      simulators = import ./overlays/simulators.nix;
      misc = import ./overlays/misc.nix;

      # Default is a composition of all above.
      default = nixpkgs.lib.composeManyExtensions [
        self.overlays.torch-family
        self.overlays.jax-family
        self.overlays.data-utils
        self.overlays.simulators
        self.overlays.misc
      ];
    };
  } // inputs.utils.lib.eachSystem [
    "x86_64-linux"
  ] (system:
    let pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            self.overlays.default
          ];
        };
    in rec {
      devShells.default = pkgs.callPackage ./pkgs/dev-shell {};
      devShells.py38 = pkgs.callPackage ./pkgs/dev-shell {
        python3 = pkgs.python38;
      };

      packages = {
        inherit (pkgs.python3Packages)
          # ----- Torch Family -----
          pytorchWithCuda11
          torchvisionWithCuda11
          pytorchvizWithCuda11
          pytorch-tabnet

          # ----- Jax Family -----
          jaxWithCuda11
          equinoxWithCuda11

          # ----- Data Utils -----
          redshift-connector
          # awswrangler  # currently broken

          # ----- Simulators -----
          gym
          gym3
          atari-py-with-rom
          ale-py-with-roms  # currently borken
          procgen
          highway-env
          metadrive-simulator

        # ----- Misc -----
          numerapi
          huggingface-transformers;
      };

      # hydraJobs = {
      #   devShell = devShell;
      # };
    });
}
