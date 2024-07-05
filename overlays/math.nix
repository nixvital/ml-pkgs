final: prev: {
  cbc2 = final.callPackage ../bleeding/cbc {};
  or-tools = final.callPackage ../bleeding/or-tools {
    inherit (final.darwin) DarwinTools;
    python = final.python3;
    protobuf = final.protobuf_25;
  };
  
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      numpy-quaternion = python-final.callPackage ../pkgs/numpy-quaternion {};
      chumpy = python-final.callPackage ../pkgs/chumpy {};
      pulp = python-prev.pulp.override {
        cbc = final.cbc2;
      };
    })
  ];
}
