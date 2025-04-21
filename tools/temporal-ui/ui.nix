{ lib, nodejs, pnpm_9, stdenv, fetchFromGitHub }:

let pnpm = pnpm_9;

in stdenv.mkDerivation (finalAttrs: {
  pname = "temporal-ui";
  version = "2.37.0";

  src = fetchFromGitHub {
    owner = "temporalio";
    repo = "ui";
    rev = "v${finalAttrs.version}";
    hash = "sha256-qPYfsHQV73fulQBARAINLFe1aIoqSOQm58LtZXmpUVQ=";
  };

  pnpmDeps = pnpm.fetchDeps {
    inherit (finalAttrs) pname version src;
    pnpmLock = "${finalAttrs.src}/pnpm-lock.yaml";
    hash = "sha256-ts1GSPJcTkdLcBEIxVDeqcIqTYjje14KLkfYRhqkJJI=";
  };

  nativeBuildInputs = [
    nodejs
    pnpm.configHook
  ];

  buildPhase = ''
    runHook preBuild

    pnpm install --offline --ignore-scripts
    pnpm build:server

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/server/ui
    cp -r server/ui/assets $out/server/ui

    runHook postInstall
  '';

  meta = {
    description = "Temporal UI";
    homepage = "docs.temporal.io/web-ui";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ breakds ];
    platforms = with lib.platforms; (linux ++ darwin);
  };
})
