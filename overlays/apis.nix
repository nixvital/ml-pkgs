final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      openai = python-final.callPackage ../bleeding/openai {};
      litellm = python-final.callPackage ../bleeding/litellm {};
      wolframalpha = python-final.callPackage ../pkgs/apis/wolframalpha {};
    })
  ];
}
