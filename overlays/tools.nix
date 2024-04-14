final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      # Dependencies for `aider`
      tree-sitter-languages = python-final.callPackage ../pkgs/tree-sitter-language/bin.nix {};
      grep-ast = python-final.callPackage ../pkgs/grep-ast {};
    })
  ];

  aider = final.callPackage ../pkgs/aider {};
}
