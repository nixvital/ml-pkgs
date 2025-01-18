{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonRelaxDepsHook
, setuptools
, transformers
, requests
, rich
, pandas
, jinja2
, markdownify
, gradio
, duckduckgo-search
, python-dotenv
, e2b-code-interpreter
, torchvision
, torch
, accelerate
, openai
}:

let pname = "smolagents";
    version = "1.4.1";

in buildPythonPackage {
  inherit pname version;
  pyproject = true;

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = "smolagents";
    rev = "v${version}";
    hash = "sha256-MFlQ6UEUL6yspKbh/DJeNEsgMP8N0Bthvm1amGORuaI=";
  };

  build-system = [
    setuptools
  ];

  nativeBuildInputs = [ pythonRelaxDepsHook ];

  pythonRelaxDeps = [
    "rich"
    "markdownify"
    "gradio"
    "duckduckgo-search"
    "e2b-code-interpreter"
  ];
  
  dependencies = [
    transformers
    requests
    rich
    pandas
    jinja2
    markdownify
    gradio
    duckduckgo-search
    python-dotenv
    e2b-code-interpreter

    # Better to have
    torchvision
    torch
    accelerate
    openai
  ];


  pythonImportsCheck = [ "smolagents" ];

  meta = with lib; {
    homepage = "https://huggingface.co/docs/smolagents/index";
    description= ''
        a barebones library for agents. Agents write python code to
        call tools and orchestrate other agents
    '';
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
