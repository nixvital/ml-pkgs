# Upstream https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/development/python-modules/jiter/default.nix#L45

{
  lib,
  buildPythonPackage,
  rustPlatform,
  fetchFromGitHub,
  libiconv,
  dirty-equals,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "jiter";
  version = "0.5.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "pydantic";
    repo = "jiter";
    rev = "refs/tags/v${version}";
    hash = "sha256-EgovddXbwutLaVkosdbJ2Y3BpEms+RoeaO8ghBRNdio=";
  };

  postPatch = ''
    cp ${./Cargo.lock} Cargo.lock
  '';

  cargoDeps = rustPlatform.importCargoLock { lockFile = ./Cargo.lock; };

  buildAndTestSubdir = "crates/jiter-python";

  nativeBuildInputs = [ rustPlatform.cargoSetupHook ];

  build-system = [ rustPlatform.maturinBuildHook ];

  buildInputs = [ libiconv ];

  pythonImportsCheck = [ "jiter" ];

  nativeCheckInputs = [
    dirty-equals
    pytestCheckHook
  ];

  meta = {
    description = "Fast iterable JSON parser";
    homepage = "https://github.com/pydantic/jiter/";
    changelog = "https://github.com/pydantic/jiter/releases/tag/v${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ natsukium ];
  };
}
