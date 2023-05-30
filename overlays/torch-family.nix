final: prev: let
  cuda11 = final.cudaPackages_11_8;

in {
  magmaWithCuda11 = prev.magma.override {
    cudaPackages = cuda11;
  };
  
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      
      pytorchWithCuda11 = python-prev.pytorchWithCuda.override {
        cudaPackages = cuda11;
        magma = final.magmaWithCuda11;
      };

      lightning-utilities = python-final.callPackage ../bleeding/lightning-utilities {};

      torchmetricsWithCuda11 = python-final.callPackage ../bleeding/torchmetrics {
        torch = python-final.pytorchWithCuda11;
      };

      pytorchLightningWithCuda11 = python-final.callPackage ../bleeding/pytorch-lightning {
        torch = python-final.pytorchWithCuda11;
        torchmetrics = python-final.torchmetricsWithCuda11;
      };

      torchvisionWithCuda11 = python-prev.torchvision.override {
        torch = python-final.pytorchWithCuda11;
      };

      pytorchvizWithCuda11 = python-final.callPackage ../pkgs/pytorchviz {
        pytorch = python-final.pytorchWithCuda11;
      };
    })
  ];
}
