{ callPackage, numpy, onnxruntime, jinja2, transformers }:

let
  inherit (import ../agents-source.nix) livekitPlugin;
in callPackage livekitPlugin {
  name = "turn-detector";
  extraDeps = [ numpy onnxruntime jinja2 transformers ];
}
