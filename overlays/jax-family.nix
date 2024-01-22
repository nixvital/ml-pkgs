final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      equinoxWithCuda11 = python-final.callPackage ../pkgs/equinox {};
    })
  ];
}
