final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      numpy-quaternion = python-final.callPackage ../pkgs/numpy-quaternion {};
      chumpy = python-final.callPackage ../pkgs/chumpy {};
    })
  ];
}
