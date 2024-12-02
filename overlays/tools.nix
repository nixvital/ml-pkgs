final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      ddddocr = python-final.callPackage ../pkgs/ddddocr {};
      
      # Dependencies for `aider`
      tree-sitter-languages = python-final.callPackage ../bleeding/tree-sitter-language {};
      grep-ast = python-final.callPackage ../pkgs/grep-ast {};
      pypager = python-final.callPackage ../bleeding/pypager {};
      
      # SwanLab series
      cos-python-sdk-v5 = python-final.callPackage ../pkgs/cos-python-sdk-v5 {};
      swankit = python-final.callPackage ../pkgs/swanlab/swankit.nix {};
      swanboard = python-final.callPackage ../pkgs/swanlab/swanboard.nix {};
      swanlab = python-final.callPackage ../pkgs/swanlab {};
    })
  ];

  aider-chat = final.callPackage ../bleeding/aider-chat {};
}
