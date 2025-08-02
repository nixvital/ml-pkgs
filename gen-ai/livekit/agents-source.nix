rec {
  version = "1.2.2";

  src = {
    owner = "livekit";
    repo = "agents";
    tag = "livekit-agents@${version}";
    hash = "sha256-9rw3554YBQiBjIIja0yN8iwlbtn3M2nj5de+xhnisR8=";
  };

  livekitPlugin = {
    lib,
    buildPythonPackage,
    fetchFromGitHub,
    hatchling,
    livekit-agents,
    name,
    extraDeps ? [],
  }: buildPythonPackage {
    pname = "livekit-agents-plugins-${name}";
    inherit version;
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
