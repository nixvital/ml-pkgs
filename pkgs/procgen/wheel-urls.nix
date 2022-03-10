# The sha256 in this file can be fetched by calling
#
# nix-prefetch-url <URL>

{ version, isPy37, isPy38, isPy39 }:

let urls = {
      "0.10.7" = {
        py37 = {
          url = https://files.pythonhosted.org/packages/36/52/3e4c2ce539c0ffc18a6dca9a9c997299dc90ec9d8f067c61e60d8024b746/procgen-0.10.7-cp37-cp37m-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
          sha256 = "1zdq8sngb48qgiszi69s8f30mbrzs4sjapag3nxc8g6xvj9bwqba";
        };

        py38 = {
          url = https://files.pythonhosted.org/packages/46/f4/2bd12e01d7c3528f8dffe6719b775e2daec840f32157043bffaa0acbf404/procgen-0.10.7-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
          sha256 = "0cdq5h3znnd4pjjsw8206myp6q6nspgj2wdqk1fgnk2p9i143pcs";
        };

        py39 = {
          url = https://files.pythonhosted.org/packages/dd/ae/6fdda3b2cb05e428db798c19ad582f2ef74fa9722b16b86d8b64cccb0577/procgen-0.10.7-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
          sha256 = "15rpb8j5k62grmi8lrhc67wksfhzyl263my9z2bglcnmgkixd1r9";
        };
      };
    };
in (if isPy37 then urls."${version}".py37
    else if isPy38 then urls."${version}".py38
    else if isPy39 then urls."${version}".py39
    else "NOT_A_VALID_URL")
