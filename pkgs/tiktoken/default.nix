{ lib
, stdenv
, buildPythonPackage
, pytestCheckHook
, rustPlatform
, fetchFromGitHub
, setuptools-rust
, regex
, requests
}:

buildPythonPackage rec {
  pname = "tiktoken";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "openai";
    repo = "tiktoken";
    rev = version;
    hash = "sha256-mucYWc0NM39Agz/Z0JL+L6nVaddMoUlYVC57FrwPpOU=";
  };

  format = "setuptools";

  postPatch = ''
    cp ${./Cargo.lock} Cargo.lock
  '';

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./Cargo.lock;
  };

  nativeBuildInputs = with rustPlatform; [
    cargoSetupHook
    rust.cargo
    rust.rustc
  ] ++ [setuptools-rust ];

  propagatedBuildInputs = [
    regex
    requests
  ];

  pythonImportsCheck = [ "tiktoken" ];

  meta = with lib; {
    description = ''
      tiktoken is a fast BPE tokeniser for use with OpenAI's models
    '';
    homepage = "https://github.com/openai/tiktoken";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
