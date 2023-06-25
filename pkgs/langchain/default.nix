{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonRelaxDepsHook
, poetry-core
, pydantic
, sqlalchemy
, requests
, pyyaml
, numpy
, numexpr
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
, wolframalpha
, tiktoken
, boto3
, pyowm
, openapi-schema-pydantic
, async-timeout
, gptcache
, azure-core
, tqdm
, langchainplus-sdk
}:

buildPythonPackage rec {
  pname = "langchain";
  version = "0.0.214";

  src = fetchFromGitHub {
    owner = "hwchase17";
    repo = "langchain";
    rev = "v${version}";
    hash = "sha256-clSIeaEavcJyFjvXHvUqPJPLiNP9Z1kTzCyM4gdwhbQ=";
  };

  format = "pyproject";

  buildInputs = [
    poetry-core
  ];

  nativeBuildInputs = [ pythonRelaxDepsHook ];
  pythonRelaxDeps = [ "tenacity" "SQLAlchemy" ];

  propagatedBuildInputs = let
    coredDeps = [
      pydantic
      sqlalchemy
      azure-core
      tqdm
      requests
      pyyaml
      numpy
      numexpr
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
      openapi-schema-pydantic
      async-timeout
      gptcache
      langchainplus-sdk
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
        tiktoken
        # tensorflow-text
        # sentence-transformers
        # pypdf
        networkx
        # deeplake
        # pgvector
        psycopg2
        boto3
      ];

      apis = [
        # wikipedia
        # pinecone-client
        # weaviate-client
        google-api-python-client
        # anthropic
        # qdrant-client
        wolframalpha
        # cohere
        openai
        # nlpcloud
        # google-search-results
        # aleph-alpha-client
        # jina
        pyowm  # open street map
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
