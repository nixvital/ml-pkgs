{ inputs, ... }:

{
  flake.overlays.gen-ai = final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (py-final: py-prev: {
        asyncer = py-final.callPackage ./asyncer { };

        magicattr = py-final.callPackage ./dspy/magicattr.nix { };
        dspy = py-final.callPackage ./dspy { };

        ollama = py-final.callPackage ./ollama/python.nix {};
      })
    ];

    ollama = final.callPackage ./ollama {};
    ollama-cuda = final.callPackage ./ollama { acceleration = "cuda"; };
    ollama-rocm = final.callPackage ./ollama { acceleration = "rocm"; };
    open-webui = final.callPackage ./open-webui {};
  };

  perSystem = { pkgs, lib, ... }: {
    packages = {
      inherit (pkgs) ollama open-webui;
      inherit (pkgs.python3Packages) asyncer dspy;
    };

    devShells.gen-ai = pkgs.mkShell {
      name = "gen-ai";

      packages = with pkgs; [
        (python3.withPackages (p: with p; [ asyncer dspy ollama ]))
        ollama
        open-webui
      ];
    };
  };
}
