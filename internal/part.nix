{ inputs, ... }:

{
  flake.overlays.internal = final: prev: {
    pyproj2nix = final.writers.writePython3Bin "pyproj2nix" {
      libraries = with final.python3Packages; [
        click
        jinja2
        httpx
      ];
    } (builtins.readFile ./pyproj2nix/pyproj2nix.py);
  };

  flake.overlays.internal-hooks = final: prev: {
    # TODO: Remove after upgraded to 25.04
    writableTmpDirAsHomeHook = final.callPackage ({ makeSetupHook}: makeSetupHook {
      name = "writeable-tmpdir-as-home-hook";
    } ./hooks/writable-tmpdir-as-home.sh) {};
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
