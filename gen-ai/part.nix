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

          llama-cloud-services = py-prev.llama-cloud-services.overrideAttrs (oldAttrs: {
            postPatch = ''
              # Remove the entire [tool.poetry.scripts] section
              sed -i '/^\[tool\.poetry\.scripts\]$/,/^\[.*\]$/{/^\[tool\.poetry\.scripts\]$/d; /^\[.*\]$/!d;}' pyproject.toml
            '';
          });
          llama-index = py-prev.llama-index.overrideAttrs (oldAttrs: {
            postPatch = ''
              # Remove the entire [project.scripts] because it only contains
              # `llama-index-cli`, which will cause conflict with the actual `llama-index-cli` package.
              sed -i '/^\[project\.scripts\]$/,/^\[.*\]$/{/^\[project\.scripts\]$/d; /^\[.*\]$/!d;}' pyproject.toml
            '';
          });

          agno = py-final.callPackage ./agno {};
          tantivy = py-final.callPackage ./tantivy {};

          livekit-rtc = py-final.callPackage ./livekit/rtc.nix {};
          livekit-agents = py-final.callPackage ./livekit/agents.nix {};
          livekit-plugins-speechmatics = py-final.callPackage ./livekit/plugins/speechmatics.nix {};
          livekit-plugins-openai = py-final.callPackage ./livekit/plugins/openai.nix {};
          livekit-plugins-deepgram = py-final.callPackage ./livekit/plugins/deepgram.nix {};
          livekit-plugins-elevenlabs = py-final.callPackage ./livekit/plugins/elevenlabs.nix {};
          livekit-plugins-silero = py-final.callPackage ./livekit/plugins/silero.nix {};
          livekit-plugins-turn-detector = py-final.callPackage ./livekit/plugins/turn-detector.nix {};

          serena = py-final.callPackage ./serena {};

          pysilero-vad = py-final.callPackage ./pysilero-vad {};
        })
      ];

      serena = with final.python3Packages; toPythonApplication serena;
      claude-code = final.callPackage ./claude-code/package.nix {};
      codex = final.callPackage ./codex/package.nix {};
    })
  ];

  perSystem = { pkgs, lib, ... }: {
    packages = {
      inherit (pkgs.python3Packages) textgrad e2b e2b-code-interpreter llama-index agno
          tantivy livekit-rtc livekit-agents livekit-plugins-speechmatics livekit-plugins-openai livekit-plugins-deepgram
          livekit-plugins-elevenlabs livekit-plugins-silero livekit-plugins-turn-detector
          pysilero-vad;
      inherit (pkgs) serena claude-code codex;
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
            agno
            tantivy
            livekit-rtc
            livekit-agents
            livekit-plugins-speechmatics
            livekit-plugins-openai
            livekit-plugins-deepgram
            livekit-plugins-elevenlabs
            livekit-plugins-silero
            livekit-plugins-turn-detector
          ]))
        ollama-cuda
        pyright
      ];

      shellHook = let
        inherit (pkgs.python3Packages.torch) cudaPackages;
      in ''
         export CUDA_HOME=${cudaPackages.cudatoolkit}
      '';
    };
  };
}
