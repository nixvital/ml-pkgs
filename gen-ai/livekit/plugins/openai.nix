{ callPackage, openai }:

let
  inherit (import ../agents-source.nix) livekitPlugin;
in callPackage livekitPlugin {
  name = "openai";
  extraDeps = [ openai ];
}
