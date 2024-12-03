final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      ddddocr = python-final.callPackage ../pkgs/ddddocr {};
      
      # SwanLab series
      cos-python-sdk-v5 = python-final.callPackage ../pkgs/cos-python-sdk-v5 {};
      swankit = python-final.callPackage ../pkgs/swanlab/swankit.nix {};
      swanboard = python-final.callPackage ../pkgs/swanlab/swanboard.nix {};
      swanlab = python-final.callPackage ../pkgs/swanlab {};
    })
  ];

  aider-chat = final.callPackage ../bleeding/aider-chat {};
}
