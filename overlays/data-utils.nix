final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {

      awswrangler = python-final.callPackage ../pkgs/awswrangler {};

    })
  ];
}
