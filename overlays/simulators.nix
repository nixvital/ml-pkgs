# Note that this must be combined together with overlays.torch-family
# for some of the packages such as huggingface-transformers to work.

final: prev: let
  cuda11 = final.cudaPackages_11_8;
in {
  libopen3d = final.callPackage ../pkgs/libopen3d {
    cudaPackages = cuda11;
  };
  
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
      mujoco = python-final.callPackage ../pkgs/mujoco {};  # Broken
      # This package is a shithole of dependency hell. Will revisit.
      #
      open3d = python-final.callPackage ../pkgs/open3d {
        pytorch = python-final.pytorchWithCuda11;
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
    })
  ];
}
