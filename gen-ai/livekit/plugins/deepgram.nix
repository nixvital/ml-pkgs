{ callPackage }:

let
  inherit (import ../agents-source.nix) livekitPlugin;
in callPackage livekitPlugin {
  name = "deepgram";
  patches = [
    ./0001-Add-speaker-diarization.patch
  ];
}
