final: prev: {
  physx5-gpu = final.callPackage ../pkgs/physx5-gpu {};
  physx5 = final.callPackage ../pkgs/physx5 {};
  sapien-vulkan-2 = final.callPackage ../pkgs/sapien-vulkan-2 {};

  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      # OpenAI Gym Series. An interface to a lot of simulation environments.
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
        torch = python-final.torchWithCuda;
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

      mujoco-menagerie = python-final.callPackage ../pkgs/mujoco-menagerie {};
      python-fcl = python-final.callPackage ../pkgs/python-fcl {};

      # SAPIEN from Hao Su's Lab
      sapien = python-final.callPackage ../pkgs/sapien {};
      maniskill = python-final.callPackage ../pkgs/maniskill {};
      # nixpkgs has a problematic glfw on 23.11 at this moment.
      glfw = python-final.callPackage ../bleeding/glfw {};

      # Procedually generated room layouts
      gputil = python-final.callPackage ../pkgs/allenai/gputil {};
      aws-requests-auth = python-final.callPackage ../pkgs/allenai/aws-requests-auth {};
      procthor = python-final.callPackage ../pkgs/allenai/procthor {};
      objaverse = python-final.callPackage ../pkgs/allenai/objaverse {};
      objathor = python-final.callPackage ../pkgs/allenai/objathor {};
      ai2thor = python-final.callPackage ../pkgs/allenai/ai2thor {};

      # Robocasa/Robosuite
      robosuite = python-final.callPackage ../research-community/robosuite {};
      robocasa = python-final.callPackage ../research-community/robocasa {};

      # IsaacGym
      isaacgym = python-final.callPackage ../pkgs/isaacgym {};
    })
  ];

  # mujoco depends on sdflib now, which in turn depends on cereal >= 1.3.1
  cereal = final.cereal_1_3_2;
}
