{ lib, buildPythonPackage, fetchFromGitHub, pythonRelaxDepsHook, setuptools, pip
, numpy, scipy, six }:

buildPythonPackage rec {
  pname = "chumpy";
  version = "2023.02.21";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "breakds";
    repo = pname;
    rev = "42d88c1aeee8da19c0269ff7a7a2fa09fd14d8cc";
    hash = "sha256-8nkT0FeEkug25kw6Ge87A6kSZmpvY3TcqjQGtlWGQlc=";
  };

  buildInputs = [ setuptools pip ];

  propagatedBuildInputs = [ numpy scipy six ];

  pythonImportsCheck = [ "chumpy" ];

  meta = with lib; {
    description = ''
      Autodifferentiation tool for Python
    '';
    homepage = "https://github.com/mattloper/chumpy/";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
