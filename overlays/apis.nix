final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      wolframalpha = python-final.callPackage ../pkgs/apis/wolframalpha {};
      openai = python-final.callPackage ../bleeding/openai {};
    })
  ];
  librealsense = final.callPackage ../bleeding/librealsense {};
}
