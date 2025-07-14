{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  docstring-parser,
  gitpython,
  httpx,
  pydantic-settings,
  pydantic,
  python-dotenv,
  python-multipart,
  pyyaml,
  rich,
  tomli,
  typer,
  typing-extensions,
  # optional
  tantivy,
  pylance,
  lancedb,
  qdrant-client,
  unstructured,
  markdown,
  aiofiles,
}:

buildPythonPackage rec {
  pname = "agno";
  version = "1.7.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "agno-agi";
    repo = "agno";
    rev = "v${version}";
    hash = "sha256-EU80+vKzX0AyPN7WBjElAqia1zeXSzVKEjmBlbSaSS0=";
  };

  sourceRoot = "${src.name}/libs/agno";

  build-system = [ setuptools ];

  dependencies = [
    docstring-parser
    gitpython
    httpx
    pydantic-settings
    pydantic
    python-dotenv
    python-multipart
    pyyaml
    rich
    tomli
    typer
    typing-extensions
  ];

  optional-dependencies = {
    lancedb = [ lancedb tantivy pylance ];
    qdrant = [ qdrant-client ];
    markdown = [ unstructured markdown aiofiles ];
  };

  pythonImportsCheck = [ "agno" ];

  meta = {
    description = "Full-stack framework for building Multi-Agent Systems with memory, knowledge and reasoning";
    homepage = "https://github.com/agno-agi/agno";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "agno";
    platforms = lib.platforms.all;
  };
}
