{ mkShell
, python3
, mujoco
}:

let ml-pkgs-dev = python3.withPackages (pyPkgs: with pyPkgs; [
      # ----- Torch Family -----
      pytorchWithCuda11
      torchvisionWithCuda11
      pytorchvizWithCuda11
      torchmetricsWithCuda11
      pytorchLightningWithCuda11
      pytorch-tabnet

      # ----- Jax Family -----
      # jaxWithCuda11
      # equinoxWithCuda11

      # ----- Data Utils -----
      redshift-connector
      # awswrangler  # currently broken

      # ----- Simulators -----
      gym
      gym3
      atari-py-with-rom
      ale-py-with-roms  # currently borken
      procgen
      highway-env
      metadrive-simulator
      robot-descriptions
      mujoco-pybind
      mujoco-menagerie
      dm-tree
      dm-env
      labmaze
      dm-control
      python-fcl

      # ----- Math -----
      numpy-quaternion

      # ----- Misc -----
      numerapi
      huggingface-transformers
      huggingface-accelerate

      # ----- Lang Chain -----
      langchain
    ]);

    pythonIcon = "f3e2";

in mkShell rec {
  name = "ml-pkgs";

  packages = [
    ml-pkgs-dev
    mujoco
  ];

  # This is to have a leading python icon to remind the user we are in
  # the Alf python dev environment.
  shellHook = ''
    export PS1="$(echo -e '\u${pythonIcon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
  '';
}
