{ lib
, buildPythonPackage
, fetchFromGitHub
, tree-sitter-languages
, pathspec
, setuptools
}:

buildPythonPackage rec {
  pname = "grep-ast";
  version = "2023.12.27";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "paul-gauthier";
    repo = pname;
    rev = "4adb83e164f31c3a9ae364de8a7b14b9481aca60";
    hash = "sha256-LupRIoy9G/jK02NMV+Uu2+mFX+5b0XV5M2JTfO16RfM=";
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    tree-sitter-languages
    pathspec
  ];

  pythonImportsCheck = [ "grep_ast" ];

  meta = with lib; {
    description = ''
      Grep source code and see useful code context about matching lines
    '';
    homepage = "https://github.com/paul-gauthier/grep-ast";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
