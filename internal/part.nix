{ inputs, ... }:

{
  flake.overlays.internal = final: prev: {
    pyproj2nix = final.writers.writePython3Bin "pyproj2nix" {
      libraries = with final.python3Packages; [
        click
        jinja2
      ];
    } (builtins.readFile ./pyproj2nix/pyproj2nix.py);
  };

  perSystem = { system, pkgs-internal, lib, ... }: {
    _module.args.pkgs-internal = import inputs.nixpkgs {
      inherit system;
      overlays = [ inputs.self.overlays.internal ];
    };

    apps = {
      pyproj2nix = {
        type = "app";
        program = "${pkgs-internal.pyproj2nix}/bin/pyproj2nix";
      };
    };
  };
}
