{ lib
, python3Packages
, fetchFromGitHub
}:

python3Packages.buildPythonApplication rec {
  pname = "aider-chat";
  version = "0.54.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "paul-gauthier";
    repo = "aider";
    rev = "v${version}";
    hash = "sha256-ysNhfhFGSDhEQLQLP26Lv6qmZehmwtQTSlAqJVPD5O8=";
  };

  build-system = with python3Packages; [
    setuptools
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [
    "aiohappyeyeballs"
    "aiohttp"
    "sounddevice"
    "tiktoken"
    "scipy"
    "tqdm"
    "annotated-types"
    "anyio"
    "attrs"
    "certifi"
    "cffi"
    "filelock"
    "flake8"
    "fsspec"
    "grep-ast"
    "huggingface-hub"
    "importlib-metadata"
    "importlib-resources"
    "jsonschema"
    "networkx"
    "openai"
    "packaging"
    "pillow"
    "prompt-toolkit"
    "pycodestyle"
    "pydantic"
    "pydantic-core"
    "pygments"
    "pyyaml"
    "referencing"
    "regex"
    "requests"
    "rpds-py"
    "smmap"
    "soupsieve"
    "tree-sitter"
    "typing-extensions"
    "urllib3"
    "zipp"
    "litellm"
    "pyperclip"
  ];

  propagatedBuildInputs = with python3Packages; [
    aiohappyeyeballs
    aiohttp
    aiosignal
    annotated-types
    click
    configargparse
    flake8
    fsspec
    gitpython
    huggingface-hub
    importlib-metadata
    importlib-resources
    openai
    tiktoken
    jinja2
    jiter
    jsonschema
    markupsafe
    mccabe
    litellm
    rich
    prompt-toolkit
    pyflakes
    pypager
    pyperclip
    python-dotenv
    tokenizers
    numpy
    scipy
    backoff
    pathspec
    networkx
    diskcache
    grep-ast
    packaging
    sounddevice
    soundfile
    beautifulsoup4
    pyyaml
    pillow
    diff-match-patch
    playwright
    pypandoc
    httpx
  ];

  meta = with lib; {
    description = ''
      aider is AI pair programming in your terminal
    '';
    homepage = "https://aider.chat/";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
