# You will need torch-family overlay, misc overlay and the apis overlay applied
# first to be able to use this.

final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      gptcache = python-final.callPackage ../pkgs/gptcache {};
      openapi-schema-pydantic = python-final.callPackage ../pkgs/openapi-schema-pydantic {};
      langchainplus-sdk = python-final.callPackage ../pkgs/langchainplus-sdk {};

      langchain = python-final.callPackage ../pkgs/langchain {
        pytorch = python-final.pytorchWithCuda11;
      };
    })
  ];
}
