{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  httpx,
  pillow,
  pydantic,
  poetry-core,
  pytest-asyncio,
  pytest-httpserver,
  pytestCheckHook,
  pythonOlder,
}:

buildPythonPackage rec {
  pname = "ollama";
  version = "0.4.3";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "ollama";
    repo = "ollama-python";
    rev = "refs/tags/v${version}";
    hash = "sha256-wHLdNMpj5YbBM0WB449ugWhVTV1kD8SDuqRM9zrPTrY=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail "0.0.0" "${version}"
  '';

  pythonRelaxDeps = [ "httpx" ];

  build-system = [ poetry-core ];


  dependencies = [ httpx pydantic ];

  nativeCheckInputs = [
    pillow
    pytest-asyncio
    pytest-httpserver
    pytestCheckHook
  ];

  pythonImportsCheck = [ "ollama" ];

  meta = with lib; {
    description = "Ollama Python library";
    homepage = "https://github.com/ollama/ollama-python";
    changelog = "https://github.com/ollama/ollama-python/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
