final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      litellm = python-final.callPackage ../bleeding/litellm {};
      wolframalpha = python-final.callPackage ../pkgs/apis/wolframalpha {};
    })
  ];
}
