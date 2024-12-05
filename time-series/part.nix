{ inputs, ... }:

{
  flake.overlays.time-series = final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (py-final: py-prev: {
        pyod = py-final.callPackage ./pyod { };
        nfoursid = py-final.callPackage ./nfoursid { };
        # darts is not compatible with numpy 2.0 yet
        # darts = py-final.callPackage ./darts {};
      })
    ];
  };

  perSystem = { pkgs, lib, ... }: {
    packages = { inherit (pkgs.python3Packages) pyod nfoursid; };

    devShells.time-series = pkgs.mkShell {
      name = "time-series";

      packages = [ (pkgs.python3.withPackages (p: with p; [ pyod nfoursid ])) ];
    };
  };
}
