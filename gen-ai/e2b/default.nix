{ lib
, buildPythonPackage
, pythonOlder  
, fetchFromGitHub
, poetry-core
, python-dateutil
, protobuf
, httpcore
, httpx
, attrs
, packaging
, typing-extensions
}:

let pname = "e2b";
    version = "1.0.5";

in buildPythonPackage {
  inherit pname version;
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "e2b-dev";
    repo = "E2B";
    rev = "@e2b/python-sdk@${version}";
    hash = "sha256-dn8Qeq3ldnKv6HQhxREooHwjyGVDoSL6zG3U7IhGyuQ=";
  };

  # src.name == "source"
  sourceRoot = "source/packages/python-sdk";

  build-system = [ poetry-core ];

  dependencies = [
    python-dateutil
    protobuf
    httpcore
    httpx
    attrs
    packaging
    typing-extensions
  ];

  pythonImportsCheck = [ "e2b" ];

  meta = with lib; {
    description = "Secure open source cloud runtime for AI apps & AI agents";
    homepage = "https://e2b.dev/";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
