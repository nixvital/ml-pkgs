final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      jaraco_context = python-final.callPackage ../pkgs/apis/wolframalpha/jaraco.context.nix {};
      wolframalpha = python-final.callPackage ../pkgs/apis/wolframalpha {};
      openai = python-final.callPackage ../bleeding/openai {};
    })
  ];
}
