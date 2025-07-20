{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  hatchling,
  livekit-agents,
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

  pypaBuildFlags = [ "livekit-plugins/livekit-plugins-elevenlabs" ];

  build-system = [ hatchling ];

  dependencies = [
    livekit-agents
  ];

  meta = {
    description = ''
        LiveKit Agent Framework plugin for ElevenLabs
    '';
    homepage = "https://github.com/livekit/python-sdks/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ breakds ];
    platforms = lib.platforms.all;
  };
}
