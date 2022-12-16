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
      # This package is a shithole of dependency hell. Will revisit.
      #
      # open3d = pyFinal.callPackage ../pkgs/open3d {
      #   cudaPackages = cuda11;
      #   pytorchWithCuda = pytorchWithCuda11;
      # };

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
    })
  ];

  mujoco = final.callPackage ../bleeding/mujoco/default.nix {};
}
