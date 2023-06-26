# Note that this must be combined together with overlays.torch-family
# for some of the packages such as huggingface-transformers to work.

final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      numerapi = python-final.callPackage ../pkgs/numerapi {};
    })
  ];
}
