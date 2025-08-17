{ lib
, buildPythonPackage
, fetchFromGitHub
, joblib
, toml-sort
, ruff
, pytest-xdist
, pyyaml
, overrides
, docstring-parser
, black
, pytest
, types-pyyaml
, tiktoken
, pathspec
, tqdm
, poethepoet
, flask
, google-genai
, python-dotenv
, pydantic
, sensai-utils
, jinja2
, anthropic
, sqlalchemy
, ruamel-yaml
, syrupy
, requests
, mcp
, psutil
, agno
, hatchling
, mypy
, pkgs
}:

let
  pname = "serena-agent";
  version = "0.1.4";

in buildPythonPackage {
  inherit pname version;
  pyproject = true;

  src = fetchFromGitHub {
    owner = "oraios";
    repo = "serena";
    tag = "v${version}";
    hash = "sha256-oj5iaQZa9gKjjaqq/DDT0j5UqVbPjWEztSuaOH24chI=";
  };

  build-system = [
    hatchling
  ];

  dependencies = [
    requests
    overrides
    python-dotenv
    mcp
    flask
    sensai-utils
    pydantic
    types-pyyaml
    pyyaml
    ruamel-yaml
    jinja2
    pathspec
    psutil
    docstring-parser
    joblib
    tqdm
    tiktoken
    anthropic
  ];

  optional-dependencies = {
    dev = [
      black
      poethepoet
      toml-sort
      syrupy
      pytest
      ruff
      jinja2
      pytest-xdist
      mypy
      types-pyyaml
    ];
    agno = [
      agno
      sqlalchemy
    ];
    google = [
      google-genai
    ];
  };

  pythonRelaxDeps = [
    "joblib"
    "mcp"
    "sensai-utils"
  ];

  pythonRemoveDeps = [
    "dotenv"
    "pyright"
  ];

  postFixup = ''
    wrapProgram $out/bin/serena \
        --set PATH "${lib.makeBinPath [ pkgs.pyright pkgs.nodejs ]}"
  '';

  meta = with lib; {
    mainProgram = "serena";
    homepage = "https://github.com/oraios/serena";
    description = ''
      A powerful coding agent toolkit providing semantic retrieval and editing
        capabilities (MCP server & Agno integration)
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
