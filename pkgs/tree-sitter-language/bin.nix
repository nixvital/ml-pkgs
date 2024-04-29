{ lib
, stdenv
, buildPythonPackage
, autoPatchelfHook
, python
, fetchurl
, tree-sitter
}:

let wheels = {
      # linux
      "x86_64-linux-python-3.10" = {
        url = https://files.pythonhosted.org/packages/f4/86/b50a1a5cc7058bf572acceb8b005c77e2f43b06a13fdb7a52c38b0f8e6fa/tree_sitter_languages-1.10.2-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0lv1nml1lfc9017s001pfqmyy8pl6l1r8grzyfwcwq746gh8aqqw";
      };
      "x86_64-linux-python-3.11" = {
        url = https://files.pythonhosted.org/packages/96/81/ab4eda8dbd3f736fcc9a508bc69232d3b9076cd46b932d9bf9d49b9a1ec9/tree_sitter_languages-1.10.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0jdqscis0lzf4ypjdlabilfpd05cq6agk84q97i0n5x72k1lmqws";
      };
      "x86_64-linux-python-3.12" = {
        url = https://files.pythonhosted.org/packages/f2/e6/eddc76ad899d77adcb5fca6cdf651eb1d33b4a799456bf303540f6cf8204/tree_sitter_languages-1.10.2-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl;
        sha256 = "0q6jykj5wgmcb78m2a3mxlfwyj7ivi4pvdn2z4r57mmxs78iqbvd";
      };

      # macOS
      "aarch64-darwin-python-3.10" = {
        url = "https://files.pythonhosted.org/packages/62/ef/e5a182b77574b7512207687fce7798ecbfb3f53ed77714aae8a7d6da93de/tree_sitter_languages-1.10.2-cp310-cp310-macosx_11_0_arm64.whl";
        sha256 = "02y818i7c0i7fgqp8v33r89jz8bazi3dyl1qw3lv31j4cik78g0h";
      };
      "aarch64-darwin-python-3.11" = {
        url = "https://files.pythonhosted.org/packages/65/82/183b039abe46d6753357019b4f0484d5b74973ee4675da2f26af5ba8dfdf/tree_sitter_languages-1.10.2-cp311-cp311-macosx_11_0_arm64.whl";
        sha256 = "0974isq56b9ghwjfwq77cc25mld1fss1nzqch2hwicbl16qbqhbb";
      };
      "aarch64-darwin-python-3.12" = {
        url = "https://files.pythonhosted.org/packages/14/fb/1f6fe5903aeb7435cc66d4b56621e9a30a4de64420555b999de65b31fcae/tree_sitter_languages-1.10.2-cp312-cp312-macosx_11_0_arm64.whl";
        sha256 = "10p7gydxhkrkq0af27g6pd9xjifv9mdi5a9bm2vjad5c8h93rkgf";
      };
    };

in buildPythonPackage rec {
  pname = "tree-sitter-languages";
  version = "1.10.2";
  format = "wheel";

  src = fetchurl wheels."${stdenv.system}-python-${python.pythonVersion}";

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  propagatedBuildInputs = [
    tree-sitter
  ];

  meta = with lib; {
    description = ''
      Binary Python wheels for all tree sitter languages
    '';
    homepage = "https://github.com/grantjenks/py-tree-sitter-languages";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
