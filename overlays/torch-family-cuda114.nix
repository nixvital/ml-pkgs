final: prev: let
  cuda114 = final.cudaPackages_11_4;

in {
  magmaWithCuda114 = prev.magma.override {
    cudaPackages = cuda114;
  };
  
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      
      pytorchWithCuda114 = python-prev.pytorchWithCuda.override {
        cudaPackages = cuda114;
        magma = final.magmaWithCuda114;
      };

      lightning-utilities = python-final.callPackage ../bleeding/lightning-utilities {};

      torchmetricsWithCuda114 = python-final.callPackage ../bleeding/torchmetrics {
        torch = python-final.pytorchWithCuda114;
      };

      pytorchLightningWithCuda114 = python-final.callPackage ../bleeding/pytorch-lightning {
        torch = python-final.pytorchWithCuda114;
        torchmetrics = python-final.torchmetricsWithCuda114;
      };

      torchvisionWithCuda114 = python-prev.torchvision.override {
        torch = python-final.pytorchWithCuda114;
      };

      pytorchvizWithCuda114 = python-final.callPackage ../pkgs/pytorchviz {
        pytorch = python-final.pytorchWithCuda114;
      };
    })
  ];
}
