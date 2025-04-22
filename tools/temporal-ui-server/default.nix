{ lib, fetchFromGitHub, buildGoModule }:

let pname = "temporal-ui-server";
    version = "2.37.1";

in buildGoModule {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "temporalio";
    repo = "ui-server";
    rev = "v${version}";
    hash = "sha256-G5O5jsCnionQ3RREKPlfUKHeIoJSVxFI5CC2xtKGW58=";
  };

  vendorHash = "sha256-WC+apki3BuLv/vLFJiF2MzCxiXfcFnSqo6JJyOnRYw4=";

  meta = with lib; {
    description = "Temporal Web UI Go server (BFF for the SPA)";
    homepage    = "https://github.com/temporalio/ui-server";
    license     = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
