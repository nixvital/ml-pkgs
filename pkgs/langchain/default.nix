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
, huggingface-transformers
, beautifulsoup4
, pytorch
, jinja2
, google-api-python-client
, dataclasses-json
, tenacity
, faiss
}:

buildPythonPackage rec {
  pname = "langchain";
  version = "0.0.88";

  src = fetchFromGitHub {
    owner = "hwchase17";
    repo = "langchain";
    rev = "v${version}";
    sha256 = "sha256-7FBUMxv+XpO6CKw6XvsZkRZ4d6AXSqvOopUFvewce2Y=";
  };

  format = "pyproject";

  buildInputs = [
    poetry
  ];

  nativeBuildInputs = [ pythonRelaxDepsHook ];
  pythonRelaxDeps = [ "tenacity" ];

  propagatedBuildInputs = let
    requiredDeps = [
      pydantic
      sqlalchemy
      requests
      pyyaml
      numpy      
    ];
    optionalDeps = [
      (faiss.override {
        # Force using cpu version
        cudaSupport = false;
      })
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
      tenacity
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
  
