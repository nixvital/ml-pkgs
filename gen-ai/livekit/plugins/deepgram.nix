{ callPackage }:

let
  inherit (import ../agents-source.nix) livekitPlugin;
in callPackage livekitPlugin {
  name = "deepgram";
}
