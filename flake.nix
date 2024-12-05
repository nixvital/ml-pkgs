{
  description =
    "Provide extra Nix packages for Machine Learning and Data Science";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

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
          };
          overlays = [
            self.overlays.cc-batteries
            self.overlays.math
            self.overlays.torch-family
            self.overlays.tools
            self.overlays.julia-family
            self.overlays.time-series
            self.overlays.simulators
          ];
        };
      };

      imports = [
        ./cc-batteries/part.nix
        ./math/part.nix
        ./torch-family/part.nix
        ./tools/part.nix
        ./julia-family/part.nix
        ./time-series/part.nix
        ./simulators/part.nix
      ];
    };
}
