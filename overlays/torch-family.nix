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

      # The one in Nixpkgs is getting old. Override it with a newer version.
      torchmetricsWithCuda11 = python-final.callPackage ../pkgs/torchmetrics {
        torch = python-final.pytorchWithCuda11;
      };

      # The one in Nixpkgs is getting old. Override it with a newer version.      
      pytorchLightningWithCuda11 = python-final.callPackage ../pkgs/torchmetrics {
        torch = python-final.pytorchWithCuda11;
        torchmetrics = python-final.torchmetricsWithCuda11;
      };

      torchvisionWithCuda11 = python-prev.torchvision.override {
        torch = python-final.pytorchWithCuda11;
      };

      pytorchvizWithCuda11 = python-final.callPackage ../pkgs/pytorchviz {
        pytorch = python-final.pytorchWithCuda11;
      };

      pytorch-tabnet = python-final.callPackage ../pkgs/pytorch-tabnet {
        pytorch = python-final.pytorchWithCuda11;
      };
    })
  ];
}
