{ mkShell
, python3
, mujoco
, julia
}:

let ml-pkgs-dev = python3.withPackages (pyPkgs: with pyPkgs; [
      pydantic
      
      # ----- Torch Family -----
      torchWithCuda
      pytorchviz
      LIV-robotics

      # # ----- Jax Family -----
      jaxlib-bin
      jax

      # # ----- Data Utils -----
      # # awswrangler  # currently broken

      # # ----- Simulators -----
      gym
      gym3
      atari-py-with-rom
      ale-py-with-roms  # currently borken
      procgen
      highway-env
      metadrive-simulator
      robot-descriptions
      mujoco
      mujoco-menagerie
      dm-control
      python-fcl
      sapien
      gputil

      # # ----- Math -----
      numpy-quaternion

      # # ----- Misc -----
      numerapi

      # # ----- Symbolic -----
      pyjulia
      pysr
    ]);

    pythonIcon = "f3e2";

in mkShell rec {
  name = "ml-pkgs";

  packages = [
    ml-pkgs-dev
    mujoco
    julia
  ];

  # This is to have a leading python icon to remind the user we are in
  # the Alf python dev environment.
  shellHook = ''
    export PS1="$(echo -e '\u${pythonIcon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
  '';
}
