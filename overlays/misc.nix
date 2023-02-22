# Note that this must be combined together with overlays.torch-family
# for some of the packages such as huggingface-transformers to work.

final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      numerapi = python-final.callPackage ../pkgs/numerapi {};

      huggingface-transformers = python-final.callPackage ../pkgs/huggingface-transformers {
        pytorch = python-final.pytorchWithCuda11;
      };

      huggingface-accelerate = python-final.callPackage ../pkgs/huggingface-accelerate {
        pytorch = python-final.pytorchWithCuda11;
      };

      blobfile = python-final.callPackage ../pkgs/blobfile {};

      tiktoken = python-final.callPackage ../pkgs/tiktoken {};
    })
  ];
}
