final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (py-final: py-prev: {
      pyjulia = py-final.callPackage ../pkgs/pyjulia {};
      pysr = py-final.callPackage ../pkgs/pysr {};
    })
  ];
}
