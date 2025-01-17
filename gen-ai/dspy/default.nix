{ lib, buildPythonPackage, fetchFromGitHub, setuptools, backoff, joblib, openai
, pandas, spacy, regex, ujson, tqdm, datasets, optuna, json-repair, litellm
, diskcache, tenacity, anyio, pydantic, magicattr, asyncer, cloudpickle, cachetools }:

let
  pname = "dspy";
  version = "2.6.0rc8";

in buildPythonPackage {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "stanfordnlp";
    repo = "dspy";
    rev = version;
    hash = "sha256-dccfZG3sv5fdZAQJOVIJB043GDdzWdk/pJxGuk0dYI4=";
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
    cloudpickle
    cachetools
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
