final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      # Dependencies for `aider`
      tree-sitter-languages = python-final.callPackage ../pkgs/tree-sitter-language {};
      grep-ast = python-final.callPackage ../pkgs/grep-ast {};
      
      aider = python-final.callPackage ../pkgs/aider {};
    })
  ];
}
