{ lib
, mkShell
, linuxPackages
, vulkan-loader
, python3Packages
, wayland
}:

mkShell rec {
  name = "habitat";

  venvDir = "./env";
  packages = with python3Packages; [
    venvShellHook
    python
    debugpy
    habitat-sim
    habitat-lab
  ];
}
