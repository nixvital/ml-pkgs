{ lib, buildPythonPackage, fetchFromGitHub, setuptools, backoff, joblib, openai
, pandas, spacy, regex, ujson, tqdm, datasets, optuna, json-repair, litellm
, diskcache, tenacity, anyio, pydantic, magicattr, asyncer }:

let
  pname = "dspy";
  version = "2.5.41";

in buildPythonPackage {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "stanfordnlp";
    repo = "dspy";
    rev = version;
    hash = "sha256-s6o22tNIgWRUbAkPtXPhEZMMzewXy1Vst/Eu5wsGIOU=";
  };

  build-system = [ setuptools ];

  dependencies = [
    backoff
    joblib
    openai
    pandas
    spacy
    regex
    ujson
    tqdm
    datasets
    optuna
    json-repair
    litellm
    diskcache
    tenacity
    anyio
    pydantic
    magicattr
    asyncer
  ];

  # workaround the error: Permission denied: '/homeless-shelter' in check
  preHook = ''
    export HOME=$(mktemp -d)
  '';
  pythonImportsCheck = [ "dspy" ];

  meta = with lib; {
    homepage = "https://github.com/stanfordnlp/dspy";
    description = "DSPy: The framework for programming with foundation models";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}