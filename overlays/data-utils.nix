final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {

      redshift-connector = python-final.callPackage ../pkgs/redshift-connector {};

      awswrangler = python-final.callPackage ../pkgs/awswrangler {};

    })
  ];
}
