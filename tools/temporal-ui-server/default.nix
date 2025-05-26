{ lib, fetchFromGitHub, buildGoModule }:

let pname = "temporal-ui-server";
    version = "2.37.3";

in buildGoModule {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "temporalio";
    repo = "ui-server";
    rev = "v${version}";
    hash = "sha256-FsW+5FIe7ouKreLh0gdb/s9ChaOkByWRHXjiWts4Gf0=";
  };

  vendorHash = "sha256-Skv+n0Da0Wgi8yjiHDcZsYwIWK4pbzdgsnrpurXudJ0=";

  meta = with lib; {
    description = "Temporal Web UI Go server (BFF for the SPA)";
    homepage    = "https://github.com/temporalio/ui-server";
    license     = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
