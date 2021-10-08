{
  description = "Provide extra Nix packages for Machine Learning and Data Science";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/21.05";

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
          pytorchWithCuda11
          torchvisionWithCuda11
          pytorchvizWithCuda11
          atari-py-with-rom
          py-glfw
          gym3
          procgen
          redshift-connector
          awswrangler
          fastavro
          numerapi;
      };

      hydraJobs = {
        devShell = devShell;
      };
    });
}
