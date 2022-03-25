final: prev: let
  preferredCuda = prev.cudatoolkit_11_2;
  preferredCudnn = prev.cudnn_cudatoolkit_11_2;
  preferredNccl = prev.nccl_cudatoolkit_11;
in rec {
  python3 = prev.python3.override {
    packageOverrides = pyFinal: pyPrev: rec {
      pytorchWithCuda11 = pyPrev.pytorchWithCuda.override {
        cudatoolkit = preferredCuda;
        nccl = preferredNccl;
        cudnn = preferredCudnn;
        magma = prev.magma.override {
          cudatoolkit = preferredCuda;
        };
      };

      torchvisionWithCuda11 = pyPrev.torchvision.override {
        pytorch = pytorchWithCuda11;
        cudatoolkit = preferredCuda;
        cudnn = preferredCudnn;
      };

      pytorchvizWithCuda11 = pyFinal.callPackage ./pkgs/pytorchviz {
        pytorch = pytorchWithCuda11;
      };

      atari-py-with-rom = pyFinal.callPackage ./pkgs/atari-py-with-rom {};

      py-glfw = pyFinal.callPackage ./pkgs/py-glfw {};

      gym3 = pyFinal.callPackage ./pkgs/gym3 {};

      procgen = pyFinal.callPackage ./pkgs/procgen {};

      lxml = pyFinal.callPackage ./pkgs/lxml {};

      redshift-connector = pyFinal.callPackage ./pkgs/redshift-connector {};

      awswrangler = pyFinal.callPackage ./pkgs/awswrangler {};

      numerapi = pyFinal.callPackage ./pkgs/numerapi {};

      highway-env = pyFinal.callPackage ./pkgs/highway-env {};

      panda3d = pyFinal.callPackage ./pkgs/panda3d {};
      panda3d-simplepbr = pyFinal.callPackage ./pkgs/panda3d-simplepbr {};
      panda3d-gltf = pyFinal.callPackage ./pkgs/panda3d-gltf {};

      metadrive-simulator = pyFinal.callPackage ./pkgs/metadrive-simulator {};

      huggingface-hub = pyFinal.callPackage ./pkgs/huggingface-hub {};
      huggingface-transformers = pyFinal.callPackage ./pkgs/huggingface-transformers {
        pytorch = pytorchWithCuda11;
      };
    };
  };

  python3Packages = python3.pkgs;

  inherit preferredCuda preferredCudnn preferredNccl;
}
