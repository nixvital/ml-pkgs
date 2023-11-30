final: prev: 
{
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {

      pytorchWithCuda11 = python-prev.pytorchWithCuda;
      torchmetricsWithCuda11 = python-prev.torchmetrics.override {
        torch = python-final.pytorchWithCuda11;
      };

      pytorchLightningWithCuda11 = python-prev.pytorch-lightning.override {
        torch = python-final.pytorchWithCuda11;
        torchmetrics = python-final.torchmetricsWithCuda11;
      };

      torchvisionWithCuda11 = python-prev.torchvision.override {
        torch = python-final.pytorchWithCuda11;
      };

      pytorchvizWithCuda11 = python-final.callPackage ../pkgs/pytorchviz {
        pytorch = python-final.pytorchWithCuda11;
      };

      LIV-robotics = python-final.callPackage ../pkgs/LIV-robotics {
        pytorch = python-final.pytorchWithCuda11;
        torchvision = python-final.torchvisionWithCuda11;
      };      

      # Override to use a customized version of pytorch, built against
      # newer version of CUDA.

      transformers = python-prev.transformers.override {
        torch = python-final.pytorchWithCuda11;
      };

      accelerate = python-prev.accelerate.override {
        torch = python-final.pytorchWithCuda11;
      };

      manifest-ml = python-prev.manifest-ml.override {
        torch = python-final.pytorchWithCuda11;
        transformers = python-final.transformers;
        accelerate = python-final.accelerate;
      };

      peft = python-prev.peft.override {
        torch = python-final.pytorchWithCuda11;
        transformers = python-final.transformers;
        accelerate = python-final.accelerate;
      };

      lion-pytorch = python-prev.lion-pytorch.override {
        torch = python-final.pytorchWithCuda11;
      };

      bitsandbytes = python-prev.bitsandbytes.override {
        torch = python-final.pytorchWithCuda11;
      };

      sentence-transformers = python-prev.sentence-transformers.override {
        torch = python-final.pytorchWithCuda11;
        torchvision = python-final.torchvisionWithCuda11;
        transformers = python-final.transformers;
      };

      clip = python-prev.clip.override {
        torch = python-final.pytorchWithCuda11;
        torchvision = python-final.torchvisionWithCuda11;
      };
    })
  ];
}
