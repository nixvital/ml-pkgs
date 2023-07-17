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
    

  # patches = [
  #   # Fixes racy doctests build failures on really fast machines
  #   # FIXME: remove after next release
  #   (fetchpatch {
  #     url = "https://github.com/pydantic/pydantic/pull/6103/commits/f05014a30340e608155683aaca17d275f93a0380.diff";
  #     hash = "sha256-sr47hpl37SSFFbK+/h3hGlF6Pl6L8XPKDU0lZZV7Vzs=";
  #   })
  # ];

  # postPatch = ''
  #   sed -i '/flake8/ d' Makefile
  # '';

  # buildInputs = lib.optionals (pythonOlder "3.9") [
  #   libxcrypt
  # ];

  # nativeBuildInputs = [
  #   cython
  # ] ++ lib.optionals withDocs [
  #   # dependencies for building documentation
  #   autoflake
  #   ansi2html
  #   markdown-include
  #   mdx-truly-sane-lists
  #   mike
  #   mkdocs
  #   mkdocs-exclude
  #   mkdocs-material
  #   sqlalchemy
  #   ujson
  #   orjson
  #   hypothesis
  # ];

  # propagatedBuildInputs = [
  #   devtools
  #   pyupgrade
  #   typing-extensions
  # ];

  # passthru.optional-dependencies = {
  #   dotenv = [
  #     python-dotenv
  #   ];
  #   email = [
  #     email-validator
  #   ];
  # };

  # nativeCheckInputs = [
  #   pytest-mock
  #   pytestCheckHook
  # ] ++ lib.flatten (lib.attrValues passthru.optional-dependencies);

  # pytestFlagsArray = [
  #   # https://github.com/pydantic/pydantic/issues/4817
  #   "-W" "ignore::pytest.PytestReturnNotNoneWarning"
  # ];

  # preCheck = ''
  #   export HOME=$(mktemp -d)
  # '';

  # # Must include current directory into PYTHONPATH, since documentation
  # # building process expects "import pydantic" to work.
  # preBuild = lib.optionalString withDocs ''
  #   PYTHONPATH=$PWD:$PYTHONPATH make docs
  # '';

  # # Layout documentation in same way as "sphinxHook" does.
  # postInstall = lib.optionalString withDocs ''
  #   mkdir -p $out/share/doc/$name
  #   mv ./site $out/share/doc/$name/html
  # '';

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
