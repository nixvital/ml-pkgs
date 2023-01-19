{ lib
, buildPythonPackage
, fetchFromGitHub
, poetry
, pydantic
, sqlalchemy
, requests
, pyyaml
, numpy
, redis
, spacy
, nltk
, huggingface-transformers
, beautifulsoup4
, pytorch
, jinja2
, google-api-python-client
}:

buildPythonPackage rec {
  pname = "langchain";
  version = "2023.01.19";

  src = fetchFromGitHub {
    owner = "hwchase17";
    repo = "langchain";
    rev = "bfb23f460836b0018087bc210ccec083a002eb65";
    hash = "sha256-gGELX9xsd+oASwaWN27Y+Xrh+S27WDNNXjkBxL489rY=";
  };

  format = "pyproject";

  buildInputs = [
    poetry
  ];

  propagatedBuildInputs = let
    requiredDeps = [
      pydantic
      sqlalchemy
      requests
      pyyaml
      numpy      
    ];
    optionalDeps = [
      # faiss-cpu
      # wikipedia
      # elasticsearch
      redis
      # manifest-ml
      spacy
      nltk
      huggingface-transformers
      beautifulsoup4
      pytorch
      jinja2
      # tiktoken
      # pinecone-client
      # weaviate-client
      google-api-python-client
      # wolframalpha
    ];
  in requiredDeps ++ optionalDeps;

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
  
