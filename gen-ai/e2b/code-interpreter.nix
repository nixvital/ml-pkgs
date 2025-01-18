{ lib
, buildPythonPackage
, fetchFromGitHub
, poetry-core
, httpx
, attrs
, e2b
}:

let pname = "e2b-code-interpreter";
    version = "1.0.3";

in buildPythonPackage {
  inherit pname version;
  pyproject = true;

  src = fetchFromGitHub {
    owner = "e2b-dev";
    repo = "code-interpreter";
    rev = "@e2b/code-interpreter-python@${version}";
    hash = "sha256-YXdWSLs9oDAb0iJqLOZzRjKqWXEglaSGI8rPx289zJo=";
  };

  # src.name == "source"
  sourceRoot = "source/python";

  build-system = [ poetry-core ];

  dependencies = [
    httpx
    attrs
    e2b
  ];

  pythonImportsCheck = [ "e2b_code_interpreter" ];

  meta = with lib; {
    description = ''
        Python & JS/TS SDK for running AI-generated code/code interpreting
        in your AI app
    '';
    homepage = "https://e2b.dev/";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
