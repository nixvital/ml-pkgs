{ lib
, buildPythonPackage
, fetchFromGitHub
, joblib
, pyright
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
, hatchling
, mypy
, pkgs
}:

let
  pname = "serena-agent";
  version = "2025.08.09";

in buildPythonPackage {
  inherit pname version;
  pyproject = true;

  src = fetchFromGitHub {
    owner = "oraios";
    repo = "serena";
    rev = "0f467a64da30990b4a66b7f9327511cc2b6deed1";
    hash = "sha256-UP1ykzCVwAL8Nvn+mlKxLYoxNz+3UKXDVGAn/1U3Vpo=";
  };

  build-system = [
    hatchling
  ];

  dependencies = [
    requests
    pyright
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
    google = [
      google-genai
    ];
  };

  pythonRelaxDeps = [
    "joblib"
    "anthropic"
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
