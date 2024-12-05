{ inputs, ... }:

{
  flake.overlays.julia-family = final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (py-final: py-prev: {
        pyjulia = py-final.callPackage ./pyjulia { };
        juliapkg = py-final.callPackage ./pyjulia/juliapkg.nix { };
        juliacall = py-final.callPackage ./pyjulia/juliacall.nix { };
      })
    ];
  };

  perSystem = { pkgs, lib, ... }: {
    packages = { inherit (pkgs.python3Packages) pyjulia juliacall; };

    devShells.julia-family = pkgs.mkShell {
      name = "julia-family";

      packages =
        [ (pkgs.python3.withPackages (p: with p; [ pyjulia juliacall ])) ];
    };
  };
}
