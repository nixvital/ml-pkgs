{ inputs, ... }:

{
  flake.overlays.gen-ai = final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (py-final: py-prev: {
        asyncer = py-final.callPackage ./asyncer { };

        magicattr = py-final.callPackage ./dspy/magicattr.nix { };
        dspy = py-final.callPackage ./dspy { };

        ollama = py-final.callPackage ./ollama/python.nix { };

        textgrad = py-final.callPackage ./textgrad { };

        pyowm = py-final.callPackage ./pyowm { };
        airportsdata = py-final.callPackage ./airportsdata { };
        outlines-core = py-final.callPackage ./outlines/outlines-core.nix { };
        outlines = py-final.callPackage ./outlines { };
        e2b = py-final.callPackage ./e2b {};
        e2b-code-interpreter = py-final.callPackage ./e2b/code-interpreter.nix {};
        smolagents = py-final.callPackage ./smolagents {};
      })
    ];

    ollama = final.callPackage ./ollama { };
    ollama-cuda = final.callPackage ./ollama { acceleration = "cuda"; };
    ollama-rocm = final.callPackage ./ollama { acceleration = "rocm"; };

    # TODO(breakds): Fix opensearch-py
    # open-webui = final.callPackage ./open-webui {};
  };

  perSystem = { pkgs, lib, ... }: {
    packages = {
      inherit (pkgs) ollama open-webui;
      inherit (pkgs.python3Packages)
        asyncer dspy opensearch-py textgrad pyowm airportsdata outlines-core
        outlines e2b e2b-code-interpreter smolagents;
    };

    devShells.gen-ai = pkgs.mkShell {
      name = "gen-ai";

      packages = with pkgs; [
        (python3.withPackages
          (p: with p; [ asyncer dspy ollama textgrad outlines smolagents ]))
        ollama
        open-webui
      ];
    };
  };
}
