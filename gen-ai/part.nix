{ inputs, ... }:

{
  flake.overlays.gen-ai = final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (py-final: py-prev: {
        asyncer = py-final.callPackage ./asyncer { };

        magicattr = py-final.callPackage ./dspy/magicattr.nix { };
        dspy = py-final.callPackage ./dspy { };

        ollama = py-final.callPackage ./ollama/python.nix {};

        textgrad = py-final.callPackage ./textgrad {};
      })
    ];

    ollama = final.callPackage ./ollama {};
    ollama-cuda = final.callPackage ./ollama { acceleration = "cuda"; };
    ollama-rocm = final.callPackage ./ollama { acceleration = "rocm"; };

    # TODO(breakds): Fix opensearch-py
    # open-webui = final.callPackage ./open-webui {};
  };

  perSystem = { pkgs, lib, ... }: {
    packages = {
      inherit (pkgs) ollama open-webui;
      inherit (pkgs.python3Packages) asyncer dspy opensearch-py textgrad;
    };

    devShells.gen-ai = pkgs.mkShell {
      name = "gen-ai";

      packages = with pkgs; [
        (python3.withPackages (p: with p; [ asyncer dspy ollama textgrad ]))
        ollama
        open-webui
      ];
    };
  };
}
