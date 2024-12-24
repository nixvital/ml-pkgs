{ lib
, fetchFromGitHub
, buildPythonPackage
, pythonOlder
, rustPlatform
, setuptools-rust
, setuptools-scm
, rustc
, cargo
, pkg-config
, openssl
}:

let pname = "outlines-core";
    version = "0.1.26";

in buildPythonPackage {
  inherit pname version;
  format = "setuptools";
  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "dottxt-ai";
    repo = "outlines-core";
    rev = version;
    hash = "sha256-P5TDv/1LtbW0BTu6U1oLyKw+d9X5okPqSh28IWzSqgc=";
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./Cargo.lock;
  };

  postPatch = ''
    cp --no-preserve=mode ${./Cargo.lock} Cargo.lock
  '';

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    cargo
    rustc
    pkg-config
  ];

  buildInputs = [
    openssl.dev
  ];

  build-system = [
    setuptools-rust
    setuptools-scm
  ];

  pythonImportsCheck = [ "outlines_core" ];
  
  meta = with lib; {
    description = "Structured generation in Rust";
    homepage = "https://github.com/dottxt-ai/outlines-core";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
