{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  hatchling,
  livekit-agents,
  openai
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

  pypaBuildFlags = [ "livekit-plugins/livekit-plugins-openai" ];

  build-system = [ hatchling ];

  dependencies = [
    livekit-agents
    openai
  ];

  meta = {
    description = ''
        LiveKit Agent Framework plugin for OpenAI
    '';
    homepage = "https://github.com/livekit/python-sdks/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ breakds ];
    platforms = lib.platforms.all;
  };
}
