{ inputs, ... }:

{
  flake.overlays.robotics = final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (py-final: py-prev: {
        gym3 = py-final.callPackage ./gym3 { };
        mujoco-menagerie = py-final.callPackage ./mujoco-menagerie { };
        mujoco-mjx = py-final.callPackage ./mujoco-mjx { };
        toppra = py-final.callPackage ./toppra { };
      })
    ];
    physx5 = final.callPackage ./physx5/default.nix {};
    physx5-gpu = final.callPackage ./physx5/gpu.nix {};
    basis-universal = final.callPackage ./basis-universal {};
  };

  perSystem = { pkgs, lib, ... }: {
    packages = {
      inherit (pkgs.python3Packages) gym3 mujoco-menagerie mujoco-mjx toppra;
      inherit (pkgs) physx5 physx5-gpu basis-universal;
    };

    devShells.robotics = pkgs.mkShell {
      name = "robotics";

      packages = with pkgs; [
        (python3.withPackages
          (p: with p; [ gym3 mujoco mujoco-mjx mujoco-menagerie toppra ]))
        physx5
        physx5-gpu
      ];
    };
  };
}
