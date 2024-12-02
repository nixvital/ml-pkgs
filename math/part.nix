{ inputs, ... }:

{
  flake.overlays.math = final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (py-final: py-prev: {
        numpy = py-prev.numpy_2;
        numpy-quaternion = py-final.callPackage ./numpy-quaternion {};
      })
    ];
  };

  perSystem = {pkgs, lib, ...}: {
    packages = {
      inherit (pkgs.python3Packages) numpy-quaternion;
    };
  };
}
