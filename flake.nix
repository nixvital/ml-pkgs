{
  description = "Provide extra Nix packages for Machine Learning and Data Science";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    overlays = {
      cc-batteries = import ./overlays/cc-batteries.nix;
      bleeding = import ./overlays/bleeding.nix;
      torch-family = import ./overlays/torch-family.nix;
      jax-family = import ./overlays/jax-family.nix;
      data-utils = import ./overlays/data-utils.nix;
      simulators = import ./overlays/haosu.nix;
      haosu = import ./overlays/simulators.nix;
      math = import ./overlays/math.nix;
      misc = import ./overlays/misc.nix;
      apis = import ./overlays/apis.nix;
      symbolic = import ./overlays/symbolic.nix;
      time-series = import ./overlays/time-series.nix;
      tools = import ./overlays/tools.nix;
      
      # Default is a composition of all above.
      default = nixpkgs.lib.composeManyExtensions [
        self.overlays.cc-batteries
        self.overlays.torch-family
        self.overlays.jax-family
        self.overlays.data-utils
        self.overlays.simulators
        self.overlays.haosu
        self.overlays.math
        self.overlays.misc
        self.overlays.apis
        self.overlays.symbolic
        self.overlays.time-series
        self.overlays.tools
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
            cudaForwardCompat = true;
          };
          overlays = [
            self.overlays.default
          ];
        };
    in rec {
      devShells = {
        default = pkgs.callPackage ./pkgs/dev-shell {};
        jax = pkgs.callPackage ./pkgs/dev-shell/jax.nix {};
        quicktest = pkgs.callPackage ./pkgs/dev-shell/quicktest.nix {};
        ddddocr = pkgs.callPackage ./pkgs/dev-shell/ddddocr.nix {};
        maniskill = pkgs.callPackage ./pkgs/dev-shell/maniskill.nix {};
        habitat = pkgs.callPackage ./pkgs/dev-shell/habitat.nix {};
      };

      packages = {
        inherit (pkgs.python3Packages)
          # ----- Torch Family -----
          torchWithCuda

          # ----- Jax Family -----
          jaxlib
          jax
          equinox

          # ----- Data Utils -----
          awswrangler

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
          mujoco-mjx
          mujoco-menagerie
          dm-control
          python-fcl
          glfw
          gputil
          aws-requests-auth
          objaverse
          objathor
          ai2thor
          procthor
          robosuite
          robocasa

          sapien
          maniskill
          pytorch-seed
          pytorch-kinematics
          arm-pytorch-utilities
          fast-kinematics
          tyro
          toppra
          mplib
          stable-baselines3

          magnum-bindings
          habitat-sim
          habitat-lab

          # ----- Math -----
          numpy-quaternion
          chumpy
          pulp

          # ----- Tools -----
          ddddocr
          cos-python-sdk-v5
          swankit
          swanboard
          swanlab
          
          # ----- Misc -----
          numerapi

          # ----- API -----
          wolframalpha

          # ----- Time Series -----
          pyod
          nfoursid
          darts

          # ----- Symbolic -----
          pyjulia
          pysr;

        inherit (pkgs)
          mujoco
          cbc2
          aria-csv-parser
          cpp-sort
          scnlib
          unordered-dense
          xxhash-cpp
          vectorclass
          outcome
          quickcpplib
          status-code
          eve
          physx5
          physx5-gpu
          sapien-vulkan-2
          ompl;
      };

      apps = {
        # TODO(breakds): Deprecate this in the future
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
