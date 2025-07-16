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
}:

buildPythonPackage rec {
  pname = "livekit-agents";
  version = "1.1.7";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "livekit";
    repo = "agents";
    tag = "livekit-agents@${version}";
    hash = "sha256-6FtpUxzRwnaseQfsQcLKowm7McF8NGntwf12+qT6yko=";
  };

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
  ];

  pythonRelaxDeps = [ "types-protobuf" ];
  pythonRemoveDeps = [ "livekit" ];

  meta = {
    description = ''
        Full-stack framework for building Multi-Agent Systems with memory,
        knowledge and reasoning.
    '';
    homepage = "https://github.com/livekit/python-sdks/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ breakds ];
    platforms = lib.platforms.all;
  };
}
