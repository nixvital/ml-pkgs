{ inputs, ... }:

{
  flake.overlays.gen-ai = final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (py-final: py-prev: {
        asyncer = py-final.callPackage ./asyncer {};
        
        magicattr = py-final.callPackage ./dspy/magicattr.nix {};
        dspy = py-final.callPackage ./dspy { };
      })
    ];
  };

  perSystem = { pkgs, lib, ... }: {
    packages = {
      inherit (pkgs.python3Packages) asyncer dspy;
    };

    devShells.gen-ai = pkgs.mkShell {
      name = "gen-ai";

      packages = [
        (pkgs.python3.withPackages
          (p: with p; [ asyncer dspy ]))
      ];
    };
  };
}
