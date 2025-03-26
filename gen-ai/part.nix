{ inputs, ... }:

{
  flake.overlays.gen-ai = inputs.nixpkgs.lib.composeManyExtensions[
    # Patch with the customized hooks.
    inputs.self.overlays.internal-hooks
    
    # The actual content start here.
    (final: prev: {
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (py-final: py-prev: {
          asyncer = py-final.callPackage ./asyncer { };

          magicattr = py-final.callPackage ./dspy/magicattr.nix { };
          dspy = py-final.callPackage ./dspy { };

          ollama = py-final.callPackage ./ollama/python.nix { };
          openai = py-final.callPackage ./openai { };
          litellm = py-final.callPackage ./litellm {};

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

      goose-cli = final.callPackage ./goose-cli {};
    })
  ];

  perSystem = { pkgs, lib, ... }: {
    packages = {
      inherit (pkgs) ollama open-webui goose-cli;
      inherit (pkgs.python3Packages)
        asyncer dspy opensearch-py textgrad pyowm airportsdata outlines-core
        litellm openai outlines e2b e2b-code-interpreter smolagents;
    };

    devShells.gen-ai = pkgs.mkShell {
      name = "gen-ai";

      packages = with pkgs; [
        (python3.withPackages
          (p: with p; [ asyncer dspy ollama textgrad outlines smolagents
                        litellm openai ]))
        ollama
        open-webui
        goose-cli
      ];
    };
  };
}
