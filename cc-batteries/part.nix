{ inputs, ... }:

{
  flake.overlays.cc-batteries = final: prev: {
    aria-csv-parser = final.callPackage ../cc-batteries/aria-csv-parser {};
    cpp-sort = final.callPackage ../cc-batteries/cpp-sort {};
    scnlib = final.callPackage ../cc-batteries/scnlib {};
  };

  perSystem = {pkgs, lib, ...}: {
    packages = {
      inherit (pkgs) aria-csv-parser cpp-sort scnlib;
    };
  };
}
