{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, setuptools
, docstring-parser
, typing-extensions
, rich
, shtab
}:

buildPythonPackage rec {
  pname = "tyro";
  version = "0.8.14";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "brentyi";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-ipkAgeHvKDbprRPNIC8XQtEi7TNo0rXgjs9TyM7mjPg=";
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    docstring-parser
    typing-extensions
    rich
    shtab
  ];

  meta = with lib; {
    description = "tool for generating CLI interfaces in Python";
    homepage = "https://brentyi.github.io/tyro";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
