{ lib
, buildPythonPackage
, fetchFromGitHub
, pdm-backend
, anyio
, typing-extensions
}:

let pname = "asyncer";
    version = "0.0.8";

in buildPythonPackage {
  inherit pname version;
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "fastapi";
    repo = pname;
    rev = version;
    hash = "sha256-SbByOiTYzp+G+SvsDqXOQBAG6nigtBXiQmfGgfKRqvM=";
  };

  build-system = [ pdm-backend ];

  dependencies = [
    anyio
    typing-extensions
  ];

  pythonImportsCheck = [ "asyncer" ];

  meta = with lib; {
    description = "Asyncer, async and await, focused on developer experience";
    homepage = "https://asyncer.tiangolo.com";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
