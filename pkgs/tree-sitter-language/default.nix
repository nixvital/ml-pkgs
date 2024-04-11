{ lib
, buildPythonPackage
, fetchFromGitHub
, tree-sitter
, setuptools
, cython
}:

buildPythonPackage rec {
  pname = "tree-sitter-languages";
  version = "1.10.2";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "grantjenks";
    repo = "py-tree-sitter-languages";
    rev = "v${version}";
    hash = "sha256-AuPK15xtLiQx6N2OATVJFecsL8k3pOagrWu1GascbwM=";
  };

  buildInputs = [
    setuptools
    cython
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
