{
  description = "Provide extra Nix packages for Machine Learning and Data Science";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  };

  outputs = { self, flake-parts, ... }@inputs: flake-parts.lib.mkFlake { inherit inputs; } {
    # Uncomment the following line to enable debug, e.g. in nix repl.
    # See https://flake.parts/debug
    
    # debug = true;

    systems = [
      "x86_64-linux" "aarch64-linux" "aarch64-darwin"
    ];

    perSystem = { config, pkgs, ... }: {
      formatter = pkgs.nixfmt-rfc-style;
    };

    imports = [
    ];
  };
}
