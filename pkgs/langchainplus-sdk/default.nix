{ lib
, buildPythonPackage
, fetchFromGitHub
, poetry-core
, pydantic
, requests
, tenacity
}:

buildPythonPackage rec {
  pname = "langchainplus-sdk";
  version = "0.0.17";

  src = fetchFromGitHub {
    owner = "langchain-ai";
    repo = "langchainplus-sdk";
    rev = "v${version}";
    hash = "sha256-yeMNAsAcAU91qPwmv268ikZ7EHzW00c0nt1Zj8AJzgo=";
  };

  sourceRoot = "source/python";

  format = "pyproject";

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    pydantic
    requests
    tenacity
  ];

  doCheck = false;
}
