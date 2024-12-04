{ inputs, ... }:

{
  flake.overlays.tools = final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (py-final: py-prev: {
        ddddocr = py-final.callPackage ./ddddocr {};
      })
    ];
  };

  perSystem = {pkgs, lib, ...}: {
    packages = {
      inherit (pkgs.python3Packages) ddddocr;
    };

    devShells.tools = pkgs.mkShell {
      name = "tools";

      packages = [
        (pkgs.python3.withPackages (p: with p; [
          ddddocr
        ]))
      ];
    };
  };
}
