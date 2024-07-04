final: prev: {
  cbc2 = final.callPackage ../bleeding/cbc {};
  cgl = final.callPackage ../bleeding/cgl {};
  osi = final.callPackage ../bleeding/osi {};
  
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      numpy-quaternion = python-final.callPackage ../pkgs/numpy-quaternion {};
      pulp = python-prev.pulp.override {
        cbc = final.cbc2;
      };
    })
  ];
}
