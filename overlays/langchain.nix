# You will need torch-family overlay and misc overlay applied first to be able
# to use this.

final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      tiktoken = python-final.callPackage ../pkgs/tiktoken {};
      
      langchain = python-final.callPackage ../pkgs/langchain {
        pytorch = python-final.pytorchWithCuda11;
      };
    })
  ];
}
