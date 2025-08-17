{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, nodeenv
, typing-extensions
, pyright
, makeWrapper
}:

buildPythonPackage rec {
  pname = "pyright";
  version = "1.1.403";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "RobertCraigie";
    repo = "pyright-python";
    tag = "v${version}";
    hash = "sha256-utYisd/PRkTBTY83uNKpl2RPYjrMV7XOjGxcvkauZKg=";
  };

  patches = [
    ./use-system-pyright.patch
  ];

  nativeBuildInputs = [ makeWrapper ];

  build-system = [
    setuptools
  ];

  dependencies = [
    nodeenv
    typing-extensions
  ];

  postFixup = ''
    wrapProgram $out/bin/pyright \
      --prefix PATH : ${lib.makeBinPath [ pyright ]}
    wrapProgram $out/bin/pyright-python \
      --prefix PATH : ${lib.makeBinPath [ pyright ]}
    wrapProgram $out/bin/pyright-langserver \
      --prefix PATH : ${lib.makeBinPath [ pyright ]}
    wrapProgram $out/bin/pyright-python-langserver \
      --prefix PATH : ${lib.makeBinPath [ pyright ]}
  '';

  pythonImportsCheck = [ "pyright" ];

  meta = with lib; {
    description = "Command line wrapper for pyright";
    homepage = "https://github.com/RobertCraigie/pyright-python";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
