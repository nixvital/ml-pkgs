{ lib
, buildPythonPackage
, isPy37
, isPy38
, isPy39
, fetchFromGitHub
, writeText
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

  propagatedBuildInputs = [
    glfw3
  ];

  postFixup = let
    pythonName = if isPy37 then "python3.7" else if isPy38 then "python3.8" else "python3.9";
    libraryScriptPath = "$out/lib/${pythonName}/site-packages/glfw/library.py";
  in ''
    substituteInPlace ${libraryScriptPath} \
            --replace "if os.environ.get('PYGLFW_LIBRARY', ''\'''\'):" \
            "if os.path.exists('${glfw3}/lib/libglfw.so'):"
    substituteInPlace ${libraryScriptPath} \
            --replace "ctypes.CDLL(os.environ['PYGLFW_LIBRARY'])" \
            "ctypes.CDLL('${glfw3}/lib/libglfw.so')"
  '';

  doCheck = false;

  pythonImportsCheck = [ "glfw" ];

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
