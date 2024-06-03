final: prev:

{
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      pyod = python-final.callPackage ../pkgs/pyod {};
      nfoursid = python-final.callPackage ../pkgs/nfoursid {};
      darts = python-final.callPackage ../pkgs/darts {};
    })
  ];
}
