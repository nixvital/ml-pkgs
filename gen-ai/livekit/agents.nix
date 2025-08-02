{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  hatchling,
  aiohttp,
  av,
  click,
  colorama,
  docstring-parser,
  eval-type-backport,
  livekit-api,
  nest-asyncio,
  numpy,
  protobuf,
  psutil,
  pydantic,
  pyjwt,
  sounddevice,
  types-protobuf,
  typing-extensions,
  watchfiles,
  opentelemetry-api,
  opentelemetry-exporter-otlp,
  opentelemetry-sdk,
  prometheus-client,
}:

let
  source = import ./agents-source.nix;

in buildPythonPackage rec {
  pname = "livekit-agents";
  inherit (source) version;
  pyproject = true;

  src = fetchFromGitHub source.src;

  pypaBuildFlags = [ "livekit-agents" ];

  build-system = [ hatchling ];

  dependencies = [
    aiohttp
    av
    click
    colorama
    docstring-parser
    eval-type-backport
    livekit-api
    nest-asyncio
    numpy
    protobuf
    psutil
    pydantic
    pyjwt
    sounddevice
    types-protobuf
    typing-extensions
    watchfiles
    opentelemetry-api
    opentelemetry-exporter-otlp
    opentelemetry-sdk
    prometheus-client
  ];

  pythonRelaxDeps = [
    "types-protobuf"
    "opentelemetry-api"
    "opentelemetry-sdk"
    "opentelemetry-exporter-otlp"
  ];
  pythonRemoveDeps = [ "livekit" ];

  meta = {
    description = ''
        Full-stack framework for building Multi-Agent Systems with memory,
        knowledge and reasoning.
    '';
    homepage = "https://github.com/livekit/agents";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ breakds ];
    platforms = lib.platforms.all;
  };
}
