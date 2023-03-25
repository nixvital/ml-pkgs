{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonRelaxDepsHook
, poetry
, pydantic
, sqlalchemy
, requests
, pyyaml
, numpy
, redis
, spacy
, nltk
, huggingface-hub
, huggingface-transformers
, beautifulsoup4
, pytorch
, jinja2
, google-api-python-client
, dataclasses-json
, tenacity
, faiss
, aiohttp
, elasticsearch
, networkx
, psycopg2
, openai
}:

buildPythonPackage rec {
  pname = "langchain";
  version = "0.0.123";

  src = fetchFromGitHub {
    owner = "hwchase17";
    repo = "langchain";
    rev = "v${version}";
    hash = "sha256-INUTp9cOySUErQVIs+rqK4TdAopFDmIfwRDNYFhTwh4=";
  };

  format = "pyproject";

  buildInputs = [
    poetry
  ];

  nativeBuildInputs = [ pythonRelaxDepsHook ];
  pythonRelaxDeps = [ "tenacity" ];

  propagatedBuildInputs = let
    coredDeps = [
      pydantic
      sqlalchemy
      requests
      pyyaml
      numpy
      spacy
      nltk
      huggingface-hub
      huggingface-transformers
      beautifulsoup4
      pytorch
      jinja2
      dataclasses-json
      tenacity
      aiohttp
    ];
    optionalDeps = {
      utils = [
        (faiss.override {
          # Force using cpu version
          cudaSupport = false;
        })
        elasticsearch
        # opensearch-py
        redis
        # manifest-ml
        # tiktoken
        # tensorflow-text
        # sentence-transformers
        # pypdf
        networkx
        # deeplake
        # pgvector
        psycopg2
      ];

      apis = [
        # wikipedia
        # pinecone-client
        # weaviate-client
        google-api-python-client
        # anthropic
        # qdrant-client
        # wolframalpha
        # cohere
        openai
        # nlpcloud
        # google-search-results
        # aleph-alpha-client
      ];
    };
  in coredDeps ++ optionalDeps.utils ++ optionalDeps.apis;

  pythonImportsCheck = [
    "langchain"
  ];

  meta = with lib; {
    description = ''
      Building applications with LLMs through composability
    '';
    homepage = "https://langchain.readthedocs.io/en/latest/?";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
