{ mkShell
, python38
, mujoco
}:

let ml-pkgs-dev = python38.withPackages (pyPkgs: with pyPkgs; [
      # ----- Torch Family -----
      pytorchWithCuda11
      torchvisionWithCuda11
    ]);

    pythonIcon = "f3e2";

in mkShell rec {
  name = "ml-pkgs";

  packages = [
    ml-pkgs-dev
  ];

  # This is to have a leading python icon to remind the user we are in
  # the Alf python dev environment.
  shellHook = ''
    export PS1="$(echo -e '\u${pythonIcon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
  '';
}
