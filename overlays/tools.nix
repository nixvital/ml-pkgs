final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      # Dependencies for `aider`
      tree-sitter-languages = python-final.callPackage ../pkgs/tree-sitter-language/bin.nix {};
      grep-ast = python-final.callPackage ../pkgs/grep-ast {};

      aimrocks = python-final.callPackage ../pkgs/aim/aimrocks.nix {};
      aimrecords = python-final.callPackage ../pkgs/aim/aimrecords.nix {};
      aim-ui = python-final.callPackage ../pkgs/aim/ui.nix {};
    })
  ];

  aider = final.callPackage ../pkgs/aider {};
  aim-app = final.callPackage ../pkgs/aim/app.nix {};
}
