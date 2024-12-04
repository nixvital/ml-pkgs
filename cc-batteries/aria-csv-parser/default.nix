# Credit to https://github.com/foolnotion/nur-pkg/blob/master/pkgs/aria-csv/default.nix

{ cmake, lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "aria-csv";
  version = "2024.10.27";

  src = fetchFromGitHub {
    owner = "AriaFallah";
    repo = "csv-parser";
    rev = "43961a918f150088dd0c288b0c9c551e0be795f8";
    hash = "sha256-X8YbSNU9i1pNEKzwm+hjQJdIhPX6o06MIDKHBwQorAE=";
  };

  nativeBuildInputs = [ cmake ];

  meta = with lib; {
    description = "Fast, header-only, C++11 CSV parser.";
    homepage = "https://github.com/AriaFallah/csv-parser";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ breakds ];
  };
}
