{ inputs, ... }:

{
  flake.overlays.simulators = final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (py-final: py-prev: {
        gym3 = py-final.callPackage ./gym3 { };
        mujoco-menagerie = py-final.callPackage ./mujoco-menagerie { };
        mujoco-mjx = py-final.callPackage ./mujoco-mjx { };
      })
    ];
  };

  perSystem = { pkgs, lib, ... }: {
    packages = {
      inherit (pkgs.python3Packages) gym3 mujoco-menagerie mujoco-mjx;
    };

    devShells.simulators = pkgs.mkShell {
      name = "simulators";

      packages = [
        (pkgs.python3.withPackages
          (p: with p; [ gym3 mujoco mujoco-mjx mujoco-menagerie ]))
      ];
    };
  };
}
