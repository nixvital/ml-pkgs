# You will need torch-family overlay, misc overlay and the apis overlay applied
# first to be able to use this.

final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      async-timeout = python-final.callPackage ../pkgs/async-timeout {};
      
      langchain = python-final.callPackage ../pkgs/langchain {
        pytorch = python-final.pytorchWithCuda11;
      };
    })
  ];
}
