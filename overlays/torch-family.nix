final: prev:

{
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      torchWithCuda = python-prev.torchWithCuda;

      LIV-robotics = python-final.callPackage ../pkgs/LIV-robotics {
        pytorch = python-final.torchWithCuda;
      };

      torchmetrics = python-prev.torchmetrics.override {
        torch = python-final.torchWithCuda;
      };

      tensorboardx = python-prev.tensorboardx.override {
        torch = python-final.torchWithCuda;        
      };

      pytorch-lightning = python-prev.pytorch-lightning.override {
        torch = python-final.torchWithCuda;
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
