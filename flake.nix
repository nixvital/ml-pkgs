{
  description =
    "Provide extra Nix packages for Machine Learning and Data Science";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  };

  outputs = { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      # Uncomment the following line to enable debug, e.g. in nix repl.
      # See https://flake.parts/debug

      # debug = true;

      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

      perSystem = { system, config, pkgs, ... }: {
        formatter = pkgs.nixfmt-classic;

        # Override pkgs so that all parts can use this as their `pkgs`.
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            cudaSupport = true;
            cudaForwardCompat = true;
            # NOTE: This is mainly to rule out `sm_90a` from showing up in
            # `torch.cuda.get_arch_list`, which will trigger
            # https://github.com/pytorch/pytorch/issues/144037
            cudaCapabilities = [ "7.5" "8.6" "8.9" ];
          };
          overlays = [
            self.overlays.cc-batteries
            self.overlays.math
            self.overlays.torch-family
            self.overlays.tools
            self.overlays.julia-family
            self.overlays.time-series
            self.overlays.robotics
            self.overlays.gen-ai
          ];
        };
      };

      imports = [
        ./internal/part.nix
        ./cc-batteries/part.nix
        ./math/part.nix
        ./torch-family/part.nix
        ./tools/part.nix
        ./julia-family/part.nix
        ./time-series/part.nix
        ./robotics/part.nix
        ./gen-ai/part.nix
      ];
    };
}
