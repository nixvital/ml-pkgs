final: prev: {
  cbc2 = final.callPackage ../bleeding/cbc {};
  
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      numpy-quaternion = python-final.callPackage ../pkgs/numpy-quaternion {};
      pulp = python-prev.pulp.override {
        cbc = final.cbc2;
      };
    })
  ];
}
