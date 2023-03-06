{ lib
, stdenv
, fetchFromGitHub
, buildPythonPackage
, rustPlatform
}:

buildPythonPackage rec {
  pname = "tiktoken";
  version = "0.2.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "openai";
    repo = "tiktoken";
    rev = version;
    hash = "sha256-ccGqXP/P2AV7Mti3YUIVdjgBwrpAyOa03wOjRe/Yegg=";
  };

  cargoRoot = "src";

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    sourceRoot = cargoRoot;
    name = "${pname}-${version}";
    hash = "sha256-ccGqXP/P2AV7Mti3YUIVdjgBwrpAyOa03wOjRe/Yegh=";    
  };

  navtiveBuildInputs = [
    rustPlatform.cargoSetupHook
  ] ++ (with rustPlatform; [ rust.cargo rust.rustc ]);


  meta = with lib; {
    description = ''
      tiktoken is a fast BPE tokeniser for use with OpenAI's models.
    '';
    homepage = "https://github.com/openai/tiktoken";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
