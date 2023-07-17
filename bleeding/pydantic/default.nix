# This is pydantic 2.0 which does not exist in nixpkgs yet.

{ lib
, stdenv
, buildPythonPackage
, pythonRelaxDepsHook
, fetchFromGitHub
, pythonOlder
, hatchling
, typing-extensions
, pydantic-core
, annotated-types
, python-dotenv
, email-validator
}:

buildPythonPackage rec {
  pname = "pydantic";
  version = "2.0.3";
  format = "pyproject";

  # outputs = [
  #   "out"
  # ] ++ lib.optionals withDocs [
  #   "doc"
  # ];

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "pydantic";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-Nx6Jmx9UqpvG3gMWOarVG6Luxgmt3ToUbmDbGQTHQto=";
  };

  patches = [
    ./0001-Patch-remove-hatch-pypi.patch
  ];

  nativeBuildInputs = [
    hatchling
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [
    "typing-extensions"
  ];

  propagatedBuildInputs = [
    typing-extensions
    pydantic-core
    annotated-types
  ];
    

  passthru.optional-dependencies = {
    dotenv = [
      python-dotenv
    ];
    email = [
      email-validator
    ];
  };

  enableParallelBuilding = true;

  pythonImportsCheck = [ "pydantic" ];

  meta = with lib; {
    description = "Data validation and settings management using Python type hinting";
    homepage = "https://github.com/pydantic/pydantic";
    changelog = "https://github.com/pydantic/pydantic/blob/v${version}/HISTORY.md";
    license = licenses.mit;
    maintainers = with maintainers; [ wd15 ];
  };
}
