rec {
  version = "1.1.7";

  src = {
    owner = "livekit";
    repo = "agents";
    tag = "livekit-agents@${version}";
    hash = "sha256-6FtpUxzRwnaseQfsQcLKowm7McF8NGntwf12+qT6yko=";
  };

  livekitPlugin = {
    lib,
    buildPythonPackage,
    fetchFromGitHub,
    hatchling,
    livekit-agents,
    name,
    extraDeps ? [],
    patches ? [],
  }: buildPythonPackage {
    pname = "livekit-agents-plugins-${name}";
    inherit version patches;
    src = fetchFromGitHub src;
    pyproject = true;

    pypaBuildFlags = [ "livekit-plugins/livekit-plugins-${name}" ];

    build-system = [ hatchling ];

    dependencies = [ livekit-agents ] ++ extraDeps;

    meta = {
      description = ''
        LiveKit Agent Framework plugin for ${name}
      '';
      homepage = "https://github.com/livekit/agents/";
      license = lib.licenses.asl20;
      maintainers = with lib.maintainers; [ breakds ];
      platforms = lib.platforms.all;
    };
  };
}
