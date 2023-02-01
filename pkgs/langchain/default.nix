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
, dataclasses-json
}:

buildPythonPackage rec {
  pname = "langchain";
  version = "0.0.75";

  src = fetchFromGitHub {
    owner = "hwchase17";
    repo = "langchain";
    rev = "v${version}";
    hash = "sha256-WZjaaYSL/GdTXDI6g85kJVN2nq7y2RoFKrP9kw3Kdro=";
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
      dataclasses-json
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
  
