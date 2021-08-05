# The sha256 in this file can be fetched by calling
#
# nix-prefetch-url <URL>

{ version, isPy37, isPy38 }:

let urls = {
      "0.10.4" = {
        py37 = {
          url = https://files.pythonhosted.org/packages/07/95/ef434b72dc7a35463b01eadd4ce47fa9ec7fc1a0cd4271f6794f9cb0067f/procgen-0.10.4-cp37-cp37m-manylinux2010_x86_64.whl;
          sha256 = "16lx4hknm0vsdps29h5nib77w45ii6lmz81fbrnnh57mnmpjp19f";
        };

        py38 = {
          url = https://files.pythonhosted.org/packages/0a/29/bbca295a28b784a20668fcde5193b6e3b3b50e160443fa28fa8b8038d5f1/procgen-0.10.4-cp38-cp38-manylinux2010_x86_64.whl;
          sha256 = "0adp5nzrh09db0r88kxgwjkk2y207kwwawdrdm59l1lrr79y138s";
        };
      };
    };
in (if isPy37 then urls."${version}".py37
    else if isPy38 then urls."${version}".py38
    else "NOT_A_VALID_URL")
