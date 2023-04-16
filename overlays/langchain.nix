# You will need torch-family overlay, misc overlay and the apis overlay applied
# first to be able to use this.

final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      gptcache = python-final.callPackage ../pkgs/gptcache {};
      async-timeout = python-final.callPackage ../pkgs/async-timeout {};
      openapi-schema-pydantic = python-final.callPackage ../pkgs/openapi-schema-pydantic {};
      
      langchain = python-final.callPackage ../pkgs/langchain {
        pytorch = python-final.pytorchWithCuda11;
      };
    })
  ];
}
