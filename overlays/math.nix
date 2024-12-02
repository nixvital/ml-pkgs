final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      chumpy = python-final.callPackage ../pkgs/chumpy {};
    })
  ];
}
