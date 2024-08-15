final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      ddddocr = python-final.callPackage ../pkgs/ddddocr {};
      
      # Dependencies for `aider`
      tree-sitter-languages = python-final.callPackage ../pkgs/tree-sitter-language/bin.nix {};
      grep-ast = python-final.callPackage ../pkgs/grep-ast {};

      # SwanLab series
      cos-python-sdk-v5 = python-final.callPackage ../pkgs/cos-python-sdk-v5 {};
      swankit = python-final.callPackage ../pkgs/swanlab/swankit.nix {};
    })
  ];

  aider = final.callPackage ../pkgs/aider {};
}
