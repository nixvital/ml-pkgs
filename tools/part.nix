{ inputs, ... }:

{
  flake.overlays.tools = final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (py-final: py-prev: {
        ddddocr = py-final.callPackage ./ddddocr { };
        cos-python-sdk-v5 = py-final.callPackage ./cos-python-sdk-v5 { };
        swankit = py-final.callPackage ./swanlab/swankit.nix { };
        swanboard = py-final.callPackage ./swanlab/swanboard.nix { };
        swanlab = py-final.callPackage ./swanlab { };
        tyro = py-final.callPackage ./tyro { };
        dowhen = py-final.callPackage ./dowhen { };
      })
    ];

    temporal-ui-server = final.callPackage ./temporal-ui-server { };
  };

  perSystem = { pkgs, lib, ... }: {
    packages = {
      inherit (pkgs.python3Packages) ddddocr cos-python-sdk-v5 tyro dowhen;
      inherit (pkgs) temporal-ui-server;
    };

    devShells.tools = pkgs.mkShell {
      name = "tools";

      packages = [
        (pkgs.python3.withPackages
          (p: with p; [ ddddocr cos-python-sdk-v5 swanlab tyro ]))
      ];
    };
  };
}
