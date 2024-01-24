final: prev:

let cuda12 = prev.cudaPackages_12;

in {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {

      openai-triton-bin = python-prev.openai-triton-bin.override {
        cudaPackages = cuda12;
      };

      torchWithCuda = python-prev.torchWithCuda.override {
        openai-triton = python-final.openai-triton-bin;
        cudaPackages = cuda12;
      };

      # Now torch becomes torchWithCuda (12).
      torch = python-final.torchWithCuda;
      

      pytorchviz = python-final.callPackage ../pkgs/pytorchviz {
        pytorch = python-final.torch;
      };

      LIV-robotics = python-final.callPackage ../pkgs/LIV-robotics {
        pytorch = python-final.torch;
      };
    })
  ];
}
