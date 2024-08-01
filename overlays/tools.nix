final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      # Dependencies for `aider`
      tree-sitter-languages = python-final.callPackage ../pkgs/tree-sitter-language/bin.nix {};
      grep-ast = python-final.callPackage ../pkgs/grep-ast {};

      aimrocks = python-final.callPackage ../pkgs/aim/aimrocks.nix {};
    })
  ];

  aider = final.callPackage ../pkgs/aider {};
}
