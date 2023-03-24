{
  description = "Provide extra Nix packages for Machine Learning and Data Science";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?rev=944c56e188e02c5e791e26357820566936f38060";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    overlays = {
      torch-family = import ./overlays/torch-family.nix;
      jax-family = import ./overlays/jax-family.nix;
      data-utils = import ./overlays/data-utils.nix;
      simulators = import ./overlays/simulators.nix;
      math = import ./overlays/math.nix;
      misc = import ./overlays/misc.nix;
      langchain = import ./overlays/langchain.nix;

      # Default is a composition of all above.
      default = nixpkgs.lib.composeManyExtensions [
        self.overlays.torch-family
        self.overlays.jax-family
        self.overlays.data-utils
        self.overlays.simulators
        self.overlays.math
        self.overlays.misc
        self.overlays.langchain
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
          cudaSupport = true;
          cudaCapabilities = [ "8.6 "];
          cudaForwardCompat = false;
        };
    in rec {
      devShells.default = pkgs.callPackage ./pkgs/dev-shell {};
      # devShells.py38 = pkgs.callPackage ./pkgs/dev-shell {
      #   python3 = pkgs.python38;
      # };

      packages = {
        inherit (pkgs.python3Packages)
          # ----- Torch Family -----
          pytorchWithCuda11
          torchvisionWithCuda11
          pytorchvizWithCuda11
          lightning-utilities
          torchmetricsWithCuda11
          pytorchLightningWithCuda11
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
          robot-descriptions
          mujoco-pybind
          mujoco-menagerie
          dm-tree
          dm-env
          labmaze
          dm-control
          python-fcl

          # ----- Math -----
          numpy-quaternion

          # ----- Misc -----
          numerapi
          huggingface-transformers
          huggingface-accelerate
          huggingface-peft
          bitsandbytes

          # ----- Lang Chain -----
          langchain;

        inherit (pkgs) mujoco;
      };

      checks =  {
        full-devshell = self.devShells."${system}".default;
      };
    });
}
