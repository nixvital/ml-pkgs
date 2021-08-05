{ lib
, buildPythonPackage
, fetchFromGitHub
, autoPatchelfHook
, glfw3
}:

buildPythonPackage rec {
  name = "py-glfw";
  version = "2.1.0";

  src = fetchFromGitHub {
    owner = "FlorianRhiem";
    repo = "pyGLFW";
    rev = "v${version}";
    sha256 = "sha256-hFcCpDSeXd4C+jpvgeR8QnTDja/QsGswqobqEljoDa8=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    glfw3
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/FlorianRhiem/pyGLFW";
    description = ''
      This module provides Python bindings for GLFW (on GitHub: glfw/glfw)
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; (linux ++ darwin);
  };
}
