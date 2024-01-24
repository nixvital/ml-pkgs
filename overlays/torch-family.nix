final: prev:

let cuda12 = final.cudaPackages_12_2;

in {
  magma = (prev.magma.override {
    cudaPackages = cuda12;
  }).overrideAttrs (oldAttrs: {
    # See https://github.com/NixOS/nixpkgs/issues/281656
    cmakeFlags = oldAttrs.cmakeFlags ++ [
      "-DCMAKE_C_FLAGS=-DADD_"
      "-DCMAKE_CXX_FLAGS=-DADD_"
      "-DFORTRAN_CONVENTION:STRING=-DADD_"
    ];
  });

  mpi = prev.mpi.override {
    cudaPackages = cuda12;
  };
  
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {

      openai-triton-bin = python-prev.openai-triton-bin.override {
        cudaPackages = cuda12;
      };

      torchWithCuda = python-prev.torchWithCuda.override {
        openai-triton = python-final.openai-triton-bin;
        cudaPackages = cuda12;
      };

      LIV-robotics = python-final.callPackage ../pkgs/LIV-robotics {
        pytorch = python-final.torchWithCuda;
      };

      torchmetrics = python-prev.torchmetrics.override {
        torch = python-final.torchWithCuda;
      };

      pytorch-lightning = python-prev.pytorch-lightning.override {
        torch = python-final.torchWithCuda;
        torchmetrics = python-final.torchmetricsWithCuda11;
      };

      torchvision = python-prev.torchvision.override {
        torch = python-final.torchWithCuda;
      };

      pytorchviz = python-final.callPackage ../pkgs/pytorchviz {
        pytorch = python-final.torchWithCuda;
      };

      # Override to use a customized version of pytorch, built against
      # newer version of CUDA.

      wandb = python-prev.wandb.override {
        torch = python-final.torchWithCuda;
      };

      transformers = python-prev.transformers.override {
        torch = python-final.torchWithCuda;
      };

      accelerate = python-prev.accelerate.override {
        torch = python-final.torchWithCuda;
      };

      manifest-ml = python-prev.manifest-ml.override {
        torch = python-final.torchWithCuda;
      };

      peft = python-prev.peft.override {
        torch = python-final.torchWithCuda;
      };

      lion-pytorch = python-prev.lion-pytorch.override {
        torch = python-final.torchWithCuda;
      };

      bitsandbytes = python-prev.bitsandbytes.override {
        torch = python-final.torchWithCuda;
      };

      sentence-transformers = python-prev.sentence-transformers.override {
        torch = python-final.torchWithCuda;
      };

      clip = python-prev.clip.override {
        torch = python-final.torchWithCuda;
      };
    })
  ];
}
