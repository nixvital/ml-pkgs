# Credit to https://github.com/foolnotion/nur-pkg/blob/master/pkgs/ned14-status-code/default.nix

{ lib, stdenv, fetchFromGitHub, cmake, git }:

stdenv.mkDerivation rec {
  pname = "ned14-status-code";
  version = "2023.09";

  src = fetchFromGitHub {
    owner = "ned14";
    repo = "status-code";
    rev = "ff93ad2fda3d11d5a45195f92543103682c7c451";
    hash = "sha256-XJzcNbsUcJ2yt1byK0izNiJY8qGsAv20N8LSd8MqNwY=";
  };

  nativeBuildInputs = [ cmake ];

  meta = with lib; {
    description = "Proposed SG14 status_code for the C++ standard";
    homepage = "https://github.com/ned14/status-code";
    license = licenses.asl20;
    platforms = platforms.all;
    maintainers = with maintainers; [ breakds ];
  };
}
