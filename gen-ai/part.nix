{ inputs, ... }:

{
  flake.overlays.gen-ai = inputs.nixpkgs.lib.composeManyExtensions[
    # The actual content start here.
    (final: prev: {
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (py-final: py-prev: {
          textgrad = py-final.callPackage ./textgrad { };

          e2b = py-final.callPackage ./e2b {};
          e2b-code-interpreter = py-final.callPackage ./e2b/code-interpreter.nix {};

          flashinfer = py-final.callPackage ./flashinfer {};
        })
      ];
    })
  ];

  perSystem = { pkgs, lib, ... }: {
    packages = {
      inherit (pkgs.python3Packages) textgrad e2b e2b-code-interpreter flashinfer torch;
    };

    devShells.gen-ai = pkgs.mkShell {
      name = "gen-ai";

      packages = with pkgs; [
        (python3.withPackages
          (p: with p; [
            ollama
            smolagents
            litellm
            openai
            llguidance
	    torch
            flashinfer
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
