{ lib, fetchFromGitHub, buildGoModule, temporal-ui }:

let pname = "temporal-ui-server";
    version = "2.37.0";

in buildGoModule {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "temporalio";
    repo = "ui-server";
    rev = "v${version}";
    hash = "sha256-C/SBF6uO8/7JRBLyxPH17Pk/N/Gg2nRdL+ejWbW2+sA=";
  };

  vendorHash = "sha256-WC+apki3BuLv/vLFJiF2MzCxiXfcFnSqo6JJyOnRYw4=";
  subPackages  = [ "cmd/server" ];

  postInstall = ''
    mkdir -p $out/share/ui-server
    ln -s ${temporal-ui}/server/ui/assets $out/share/ui-server/assets
  '';

  meta = with lib; {
    description = "Temporal Web UI Go server (BFF for the SPA)";
    homepage    = "https://github.com/temporalio/ui-server";
    license     = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
