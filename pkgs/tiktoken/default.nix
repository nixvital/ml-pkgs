{ lib
, buildPythonPackage
, fetchFromGitHub
, libiconv
, blobfile
, regex
, requests
, rustPlatform
, setuptools-rust
, pytest
}:

buildPythonPackage rec {
  pname = "tiktoken";
  version = "0.2.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "openai";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-ccGqXP/P2AV7Mti3YUIVdjgBwrpAyOa03wOjRe/Yegg=";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src patches;
    name = "${pname}-${version}";
    hash = "sha256-QY4ouQoBXE2JUTGfn/+01ljn1H4abmFpZpQVf6myams=";
  };

  patches = [ ./Cargo.lock.patch ];

  doCheck = false;

  nativeBuildInputs = with rustPlatform; [
    cargoSetupHook
    rust.cargo
    rust.rustc
    setuptools-rust
  ];

  buildInputs = [
    libiconv
  ];

  propagatedBuildInputs = [
    blobfile
    regex
    requests
  ];

  # checkInputs = [ pytest ];
  # checkPhase = "pytest ./tests";

  meta = with lib; {
    description = "tiktoken is a fast BPE tokeniser for use with OpenAI's models";
    homepage = "https://github.com/openai/tiktoken";
    license = licenses.mit;
    # maintainers = with maintainers; [ katanallama ];
  };
}
