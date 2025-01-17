{ inputs, ... }:

{
  flake.overlays.cc-batteries = final: prev: {
    aria-csv-parser = final.callPackage ./aria-csv-parser { };
    cpp-sort = final.callPackage ./cpp-sort { };
    scnlib = final.callPackage ./scnlib { };
    unordered-dense = final.callPackage ./unordered-dense { };
    vectorclass = final.callPackage ./vectorclass { };
    eve = final.callPackage ./eve { };
    libcoro = final.callPackage ./libcoro { };
    corrade = final.callPackage ./corrade { };
    magnum = final.callPackage ./magnum { };
    magnum-plugins = final.callPackage ./magnum-plugins { };
    magnum-integration = final.callPackage ./magnum-integration { };
  };

  perSystem = { pkgs, lib, ... }: {
    packages = {
      inherit (pkgs)
        aria-csv-parser cpp-sort scnlib unordered-dense vectorclass eve libcoro
        corrade magnum magnum-plugins magnum-integration;
    };
  };
}
