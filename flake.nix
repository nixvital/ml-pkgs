{
  description = "Provide extra Nix packages for Machine Learning and Data Science";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, ... }@inputs: inputs.utils.lib.eachSystem [
    "x86_64-linux"
  ] (system:
    let pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            cudaSupport = true;
            cudaCapabilities = [ "7.5" "8.6" ];
            cudaForwardCompat = false;
          };
          overlays = [
            (final: prev: {
              cudaPackagesGoogle = prev.cudaPackages_11_8;
              pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
                (python-final: python-prev: {
                  jaxlib-bin = python-final.callPackage ./bleeding/jaxlib/bin.nix {
                    inherit (final.config) cudaSupport;
                  };
                })
              ];
            })
          ];
        };
    in rec {
      devShells.default = pkgs.mkShell {
        name = "jax-dev";

        packages = [
          (pkgs.python3.withPackages (py-pkgs: with py-pkgs; [
            jaxlib-bin
          ]))
        ];
      };
    });
}
