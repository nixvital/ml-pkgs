final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      wolframalpha = python-final.callPackage ../pkgs/apis/wolframalpha {};
    })
  ];
}
