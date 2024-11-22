final: prev: {
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

      habitat-sim = python-final.callPackage ../pkgs/habitat-sim {};
      habitat-lab = python-final.callPackage ../pkgs/habitat-lab {};
      magnum-bindings = python-final.callPackage ../pkgs/magnum-bindings {};
    })
  ];

  # mujoco depends on sdflib now, which in turn depends on cereal >= 1.3.1
  cereal = final.cereal_1_3_2;
  magnum = final.callPackage ../pkgs/magnum {};
  magnum-integration = final.callPackage ../pkgs/magnum-integration {};
  magnum-plugins = final.callPackage ../pkgs/magnum-plugins {};
  corrade = final.callPackage ../pkgs/corrade {};
  basis-universal = final.callPackage ../pkgs/basis-universal {};
  recastnavigation = final.callPackage ../pkgs/recastnavigation {};
}
