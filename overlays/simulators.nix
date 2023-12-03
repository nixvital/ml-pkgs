final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      # OpenAI Gym Series. An interface to a lot of simulation environments.
      gym-notices = python-final.callPackage ../pkgs/gym-notices {};
      gym = python-final.callPackage ../pkgs/gym {};
      gym3 = python-final.callPackage ../pkgs/gym3 {};

      # Physics and rendering engines.
      panda3d = python-final.callPackage ../pkgs/panda3d {};
      panda3d-simplepbr = python-final.callPackage ../pkgs/panda3d-simplepbr {};
      panda3d-gltf = python-final.callPackage ../pkgs/panda3d-gltf {};
      pybulletx = python-final.callPackage ../pkgs/pybulletx {};

      # NOTE(breakds): There are still missing libraries when autoPatchelf this
      # package, and therefore some of the functionality may not be there.
      open3d = python-final.callPackage ../pkgs/open3d {
        torch = python-final.pytorchWithCuda11;
      };

      # Atari. Note that though ale-py-with-roms is preferred, it does not fully
      # reproduce the result from atari-py yet. This means that we will stick to
      # atari-py for a while.
      atari-py-with-rom = python-final.callPackage ../pkgs/atari-py-with-rom {};
      ale-py-with-roms = python-final.callPackage ../pkgs/ale-py-with-roms {};

      # Procedually generated games, with gym3 interface.
      procgen = python-final.callPackage ../pkgs/procgen {};

      # Driving simulators. Based on Panda3d.
      highway-env = python-final.callPackage ../pkgs/highway-env {};
      metadrive-simulator = python-final.callPackage ../pkgs/metadrive-simulator {};

      # Supporting libraries
      robot-descriptions = python-final.callPackage ../pkgs/robot-descriptions {};

      # Mujoco (Official Python Binding) and friends
      mujoco-pybind = python-final.callPackage ../pkgs/mujoco-pybind {};
      mujoco-pybind-231 = python-final.callPackage ../pkgs/mujoco-pybind/2.3.1.nix {};
      mujoco-mjx = python-final.callPackage ../bleeding/mujoco-mjx {};
      mujoco-menagerie = python-final.callPackage ../pkgs/mujoco-menagerie {};
      dm-tree = python-final.callPackage ../pkgs/deepmind/dm-tree {};
      dm-env = python-final.callPackage ../pkgs/deepmind/dm-env {};
      labmaze = python-final.callPackage ../pkgs/deepmind/labmaze {};
      dm-control = python-final.callPackage ../pkgs/deepmind/dm-control {};
      dm-control-109 = python-final.callPackage ../pkgs/deepmind/dm-control/1.0.9.nix {};
      python-fcl = python-final.callPackage ../pkgs/python-fcl {};

      # SAPIEN from Hao Su's Lab
      sapien = python-final.callPackage ../pkgs/sapien {};

      # nixpkgs has a problematic glfw on 23.11 at this moment.
      glfw = python-final.callPackage ../bleeding/glfw {};      
    })
  ];

  # mujoco depends on sdflib now, which in turn depends on cereal >= 1.3.1
  cereal = final.cereal_1_3_2;
  mujoco = final.callPackage ../bleeding/mujoco/default.nix {};
  mujoco-231 = final.callPackage ../bleeding/mujoco/2.3.1.nix {};
}
