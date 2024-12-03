{ inputs, ... }:

{
  flake.overlays.torch-family = final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (py-final: py-prev: {
        pytorchviz = py-final.callPackage ./pytorchviz {};
      })
    ];
  };

  perSystem = {pkgs, lib, ...}: {
    packages = {
      inherit (pkgs.python3Packages) pytorchviz;
    };

    devShells.torch-family = pkgs.mkShell {
      name = "torch-family";

      packages = [
        (pkgs.python3.withPackages (p: with p; [
          pytorchviz
        ]))
      ];
    };
  };
}
