{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  hatchling,
  livekit-agents,
  transformers,
  numpy,
  onnxruntime,
  jinja2,
}:

buildPythonPackage rec {
  pname = "livekit-agents-plugins-turn-detector";
  version = "1.1.7";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "livekit";
    repo = "agents";
    tag = "livekit-agents@${version}";
    hash = "sha256-6FtpUxzRwnaseQfsQcLKowm7McF8NGntwf12+qT6yko=";
  };

  pypaBuildFlags = [ "livekit-plugins/livekit-plugins-turn-detector" ];

  build-system = [ hatchling ];

  dependencies = [
    livekit-agents
    transformers
    numpy
    onnxruntime
    jinja2
  ];

  meta = {
    description = ''
        LiveKit Agent Framework plugin for Turn Detector
    '';
    homepage = "https://github.com/livekit/python-sdks/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ breakds ];
    platforms = lib.platforms.all;
  };
}
