{ lib
, buildPythonPackage
, fetchFromGitHub
, pydantic
, pytest
}:

buildPythonPackage rec {
  pname = "openapi-schema-pydantic";
  version = "v1.2.4";  # Use main branch since we need llama

  src = fetchFromGitHub {
    owner = "kuimono";
    repo = pname;
    rev = version;
    hash = "sha256-eMMkOUG6Ens8Wq5pzEIcH/8at+t6APMd9I8PfAiUeFw=";
  };
  
  propagatedBuildInputs = [ pydantic ];
  checkInputs = [ pytest ];

  doCheck = true;

  pythonImportsCheck = [ "openapi_schema_pydantic" ];

  meta = with lib; {
    description = ''
      OpenAPI (v3) specification schema as pydantic class
    '';
    homepage = "https://github.com/kuimono/openapi-schema-pydantic";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
