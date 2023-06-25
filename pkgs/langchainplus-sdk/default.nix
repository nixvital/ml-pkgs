{ lib
, fetchurl
, buildPythonPackage
, pydantic
, requests
, tenacity
}:

# NOTE(breakds): This is not a complicated package and Ideally I should build it
# from source. However, the source of this package uses a Makefile which
# requires poetry command. See
# https://discourse.nixos.org/t/question-of-packaging-python-package-with-poetry-and-makefile/29613
let wheel = {
      url = https://files.pythonhosted.org/packages/32/92/b4ce0f5c576233ccfdadce90031b64b9a12be5ed3ce9d555b28af34845bf/langchainplus_sdk-0.0.17-py3-none-any.whl;
      sha256 = "1gq5zdzlbxg5w5n2svsvaghmshmlqgal6xnfj6b85c0bhpz7b5l9";
    };

in buildPythonPackage rec {
  pname = "langchainplus-sdk";
  version = "0.0.17";
  format = "wheel";

  src = fetchurl wheel;

  propagatedBuildInputs = [
    pydantic
    requests
    tenacity
  ];

  pythonImportsCheck = [
    "langchainplus_sdk"
  ];

  meta = with lib; {
    description = ''
      Python client for interacting with the LangSmith platform.
    '';
    homepage = "";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
