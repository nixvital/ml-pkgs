final: prev: let
  cuda11 = prev.cudaPackages_11_6;
in rec {
  python3 = prev.python3.override {
    packageOverrides = pyFinal: pyPrev: rec {
      pytorchWithCuda11 = pyPrev.pytorchWithCuda.override {
        cudaPackages = cuda11;
      };

      pytorchLightningWithCuda11 = pyPrev.pytorch-lightning.override {
        pytorch = pytorchWithCuda11;
      };

      torchvisionWithCuda11 = pyPrev.torchvision.override {
        pytorch = pytorchWithCuda11;
      };

      pytorchvizWithCuda11 = pyFinal.callPackage ./pkgs/pytorchviz {
        pytorch = pytorchWithCuda11;
      };

      jaxlibWithCuda11 = pyPrev.jaxlibWithCuda.override {
        cudaPackages = cuda11;
      };

      jaxWithCuda11 = pyPrev.jax.override {
        jaxlib = jaxlibWithCuda11;
      };

      equinoxWithCuda11 = pyFinal.callPackage ./pkgs/equinox {
        jax = jaxWithCuda11;
      };

      atari-py-with-rom = pyFinal.callPackage ./pkgs/atari-py-with-rom {};

      py-glfw = pyFinal.callPackage ./pkgs/py-glfw {};

      gym3 = pyFinal.callPackage ./pkgs/gym3 {};

      procgen = pyFinal.callPackage ./pkgs/procgen {};

      redshift-connector = pyFinal.callPackage ./pkgs/redshift-connector {};

      awswrangler = pyFinal.callPackage ./pkgs/awswrangler {};

      numerapi = pyFinal.callPackage ./pkgs/numerapi {};

      highway-env = pyFinal.callPackage ./pkgs/highway-env {};

      panda3d = pyFinal.callPackage ./pkgs/panda3d {};
      panda3d-simplepbr = pyFinal.callPackage ./pkgs/panda3d-simplepbr {};
      panda3d-gltf = pyFinal.callPackage ./pkgs/panda3d-gltf {};

      metadrive-simulator = pyFinal.callPackage ./pkgs/metadrive-simulator {};

      huggingface-transformers = pyFinal.callPackage ./pkgs/huggingface-transformers {
        pytorch = pytorchWithCuda11;
      };
    };
  };

  python3Packages = python3.pkgs;
}
