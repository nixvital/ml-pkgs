{ inputs, ... }:

{
  flake.overlays.cc-batteries = final: prev: {
    aria-csv-parser = final.callPackage ../cc-batteries/aria-csv-parser {};
  };

  perSystem = {pkgs, lib, ...}: {
    packages = {
      aria-csv-parser = pkgs.aria-csv-parser;
    };
  };
}
