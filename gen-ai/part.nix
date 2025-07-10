{ inputs, ... }:

{
  flake.overlays.gen-ai = inputs.nixpkgs.lib.composeManyExtensions[
    # The actual content start here.
    (final: prev: {
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (py-final: py-prev: {
          textgrad = py-final.callPackage ./textgrad { };

          magicattr = py-final.callPackage ./dspy/magicattr.nix { };          
          dspy = py-final.callPackage ./dspy { };

          e2b = py-final.callPackage ./e2b {};
          e2b-code-interpreter = py-final.callPackage ./e2b/code-interpreter.nix {};

          sgl-kernel = py-final.callPackage ./sglang/sgl-kernel.nix {};

          llama-index = py-final.callPackage ./llama-index {};
        })
      ];
    })
  ];

  perSystem = { pkgs, lib, ... }: {
    packages = {
      inherit (pkgs.python3Packages) textgrad e2b e2b-code-interpreter llama-index;
    };

    devShells.gen-ai = pkgs.mkShell {
      name = "gen-ai";

      packages = with pkgs; [
        (python3.withPackages
          (p: with p; [
            ollama
            litellm
            openai
            llguidance
	    torch
            llama-index
          ]))
        ollama-cuda
        goose-cli
      ];

      shellHook = let
        inherit (pkgs.python3Packages.torch) cudaPackages;
      in ''
         export CUDA_HOME=${cudaPackages.cudatoolkit}
      '';
    };
  };
}
