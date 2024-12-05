{ inputs, ... }:

{
  flake.overlays.math = final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (py-final: py-prev: {
        # TODO(breakds): Enable numpy 2.0 when needed, also numpy-quaternion requires numpy 2 currently.
        # numpy = py-prev.numpy_2;
        # numpy-quaternion = py-final.callPackage ./numpy-quaternion {};
        chumpy = py-final.callPackage ./chumpy { };
      })
    ];
  };

  perSystem = { pkgs, lib, ... }: {
    packages = { inherit (pkgs.python3Packages) chumpy; };
  };
}
