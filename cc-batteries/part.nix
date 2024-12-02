{ inputs, ... }:

{
  flake.overlays.cc-batteries = final: prev: {
    aria-csv-parser = final.callPackage ./aria-csv-parser {};
    cpp-sort = final.callPackage ./cpp-sort {};
    scnlib = final.callPackage ./scnlib {};
    unordered-dense = final.callPackage ./unordered-dense {};
  };

  perSystem = {pkgs, lib, ...}: {
    packages = {
      inherit (pkgs) aria-csv-parser cpp-sort scnlib unordered-dense;
    };
  };
}
