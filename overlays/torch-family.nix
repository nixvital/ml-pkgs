final: prev: let
  cuda11 = final.cudaPackages_11_8.overrideScope' (cuFinal: cuPrev: {
    # The libnvrtc.so does not even know it needs libnvrtc-builtins.so. This
    # will cause torch to break at runtime at this moment. Before it is fixed
    # upstream with a patch similar to this:
    # https://github.com/SomeoneSerge/nixpkgs/commit/f55d2a112dc33855bad42980bf93d684505cbe6d
    # It is fixed temporarily like below as suggested by @SomeoneSerge.
    cudatoolkit = cuPrev.cudatoolkit.overrideAttrs (oldAttrs: {
      preFixup = (oldAttrs.preFixup or "") + ''
        patchelf $out/lib64/libnvrtc.so --add-needed libnvrtc-builtins.so
      '';
    });
  });

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
    })
  ];
}
