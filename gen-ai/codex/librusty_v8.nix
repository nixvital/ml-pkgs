{ callPackage }:
let
  fetchers = callPackage ./fetchers.nix { };
in
fetchers.fetchLibrustyV8 {
  version = "146.4.0";
  hashes = {
    x86_64-linux = "sha256-5ktNmeSuKTouhGJEqJuAF4uhA4LBP7WRwfppaPUpEVM=";
    aarch64-linux = "sha256-2/FlsHyBvbBUvARrQ9I+afz3vMGkwbW0d2mDpxBi7Ng=";
  };
}
