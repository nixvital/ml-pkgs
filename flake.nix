{
  description = "Provide extra Nix packages for Machine Learning and Data Science";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    overlays = {
      # Please be very careful including the bleeding overlay. It provides
      # pydantic 2.0 but it will break pydantic 1.0 and everything depending on
      # it.
      bleeding = import ./overlays/bleeding.nix;
      torch-family = import ./overlays/torch-family.nix;
      torch-family-cuda114 = import ./overlays/torch-family-cuda114.nix;
      jax-family = import ./overlays/jax-family.nix;
      data-utils = import ./overlays/data-utils.nix;
      simulators = import ./overlays/simulators.nix;
      math = import ./overlays/math.nix;
      misc = import ./overlays/misc.nix;
      apis = import ./overlays/apis.nix;
      langchain = import ./overlays/langchain.nix;
      symbolic = import ./overlays/symbolic.nix;

      # Default is a composition of all above.
      default = nixpkgs.lib.composeManyExtensions [
        self.overlays.torch-family
        self.overlays.jax-family
        self.overlays.data-utils
        self.overlays.simulators
        self.overlays.math
        self.overlays.misc
        self.overlays.apis
        self.overlays.langchain
        self.overlays.symbolic
      ];
    };
  } // inputs.utils.lib.eachSystem [
    "x86_64-linux"
  ] (system:
    let pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            cudaSupport = true;
            # ChatGPT: When you compile a CUDA program, you can specify for
            # which Compute Capability you want to build it. The resulting
            # binary code will be optimized for that specific version of Compute
            # Capability, and it won't run on GPUs with lower Compute
            # Capability. If you want your CUDA program to be able to run on
            # different GPUs, you should compile it for the lowest Compute
            # Capability you intend to support.
            #
            # 7.5 - 20X0 (Ti), T4
            # 8.0 - A100
            # 8.6 - 30X0 (Ti)
            # 8.9 - 40X0 (Ti)
            cudaCapabilities = [ "7.5" "8.6" ];
            cudaForwardCompat = false;
          };
          overlays = [
            self.overlays.default
          ];
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
          pytorchLightningWithCuda11
          LIV-robotics
          einops

          # ----- Jax Family -----
          # jaxWithCuda11
          # equinoxWithCuda11

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
          open3d
          metadrive-simulator
          robot-descriptions
          mujoco-pybind
          mujoco-menagerie
          dm-tree
          dm-env
          labmaze
          dm-control
          python-fcl
          sapien

          # ----- Math -----
          numpy-quaternion

          # ----- Misc -----
          numerapi

          # ----- API -----
          wolframalpha

          # ----- Symbolic -----
          pyjulia
          pysr

          # ----- Lang Chain -----
          gptcache
          openapi-schema-pydantic
          langchainplus-sdk
          langchain;

        inherit (pkgs) mujoco;
      };

      apps = {
        extract-langchain-deps = {
          type = "app";
          program = "${pkgs.callPackage ./pkgs/langchain/extract-langchain-deps.nix {}}/bin/extract";
        };
      };

      checks =  {
        full-devshell = self.devShells."${system}".default;
      };
    });
}
