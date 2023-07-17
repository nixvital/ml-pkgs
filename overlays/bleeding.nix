final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (py-final: py-prev: {
      typing-extensions= py-prev.typing-extensions.overrideAttrs (oldAttrs: rec {
        version = "4.6.3";
        src = py-prev.fetchPypi {
          pname = "typing_extensions";
          inherit version;
          hash = "sha256-2R1ZGTV/5/aBqfK1tMsqXx7woen1nE2P8NNJHgXA/9U=";
        };
      });
      annotated-types = py-final.callPackage ../bleeding/annotated-types {};
      pydantic-core = py-final.callPackage ../bleeding/pydantic-core {};
      pydantic = py-final.callPackage ../bleeding/pydantic {};      
    })
  ];
}
