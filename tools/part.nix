{ inputs, ... }:

{
  flake.overlays.tools = final: prev: let

    unstable-overlay = ufinal: uprev: {
      temporal-ui-server = ufinal.callPackage ./temporal-ui-server { };
    };

    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system config;
      overlays = [ unstable-overlay ];
    };
  in {
    inherit (unstable) temporal temporal-cli temporal-ui-server playwright-driver;

    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (py-final: py-prev: {
        ddddocr = py-final.callPackage ./ddddocr { };
        cos-python-sdk-v5 = py-final.callPackage ./cos-python-sdk-v5 { };
        swankit = py-final.callPackage ./swanlab/swankit.nix { };
        swanboard = py-final.callPackage ./swanlab/swanboard.nix { };
        swanlab = py-final.callPackage ./swanlab { };
        tyro = py-final.callPackage ./tyro { };
        temporalio = py-final.callPackage ./temporalio {};
      })
    ];
  };

  perSystem = { pkgs, lib, ... }: {
    packages = {
      inherit (pkgs.python3Packages) ddddocr cos-python-sdk-v5 tyro temporalio;
      inherit (pkgs) temporal temporal-cli temporal-ui-server;
    };

    devShells.tools = pkgs.mkShell {
      name = "tools";

      packages = [
        (pkgs.python3.withPackages
          (p: with p; [ ddddocr cos-python-sdk-v5 swanlab tyro temporalio ]))
      ];
    };
  };
}
