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
, transformers
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
, azure-identity
, azure-cosmos
, tqdm
, langchainplus-sdk
, pytesseract
, html2text
, duckduckgo-search
, lark
, anthropic
, pinecone-client
, weaviate-client
, opensearch-py
, manifest-ml
, pypdf
, pdfminer-six
, pymupdf
, sentence-transformers
, pexpect
, jq
, steamship
, lxml
, gql
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

  propagatedBuildInputs = let
    coredDeps = [
      pydantic
      sqlalchemy
      tqdm
      requests
      pyyaml
      numpy
      numexpr
      spacy
      nltk
      huggingface-hub
      (transformers.override {
        torch = pytorch;
      })
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
        opensearch-py
        redis
        manifest-ml
        tiktoken
        # tensorflow-text
        sentence-transformers
        pypdf
        networkx
        # deeplake
        # pgvector
        psycopg2
        boto3
        html2text
        lark
        pexpect
        jq
        pdfminer-six
        pymupdf
        lxml
        # pypdfium2
        gql
      ];

      apis = [
        azure-core
        azure-identity
        azure-cosmos
        # wikipedia
        pinecone-client
        weaviate-client
        google-api-python-client
        anthropic
        # qdrant-client
        wolframalpha
        # cohere
        openai
        # nlpcloud
        # google-search-results
        # aleph-alpha-client
        # jina
        pyowm  # open street map
        pytesseract  # Google OCR API
        duckduckgo-search
        # lancedb
        # pyvespa
        # O365
        steamship  # ??
        # docarray
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
