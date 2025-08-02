{ callPackage, onnxruntime, numpy }:

let
  inherit (import ../agents-source.nix) livekitPlugin;
in callPackage livekitPlugin {
  name = "silero";
  extraDeps = [ onnxruntime numpy ];
}
