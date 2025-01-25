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
    version = "1.5.0";

in buildPythonPackage {
  inherit pname version;
  pyproject = true;

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = "smolagents";
    rev = "v${version}";
    hash = "sha256-E/vFRMSOCV6BtqImxmWB1h3PkDm1Ghs1iw29rSZuxyQ=";
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
