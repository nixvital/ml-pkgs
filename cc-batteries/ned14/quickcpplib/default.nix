# Credit to https://github.com/foolnotion/nur-pkg/blob/master/pkgs/ned14-quickcpplib/default.nix

{ lib, stdenv, fetchFromGitHub, cmake, git }:

stdenv.mkDerivation rec {
  pname = "ned14-quickcpplib";
  version = "2023.08.18";

  src = fetchFromGitHub {
    owner = "ned14";
    repo = "quickcpplib";
    rev = "9aaddae850e2c6dd8a66a9833d1172d1515e9dbf";
    hash = "sha256-AWP/N3AMlohWmMpliG8C2EGfwvGb9lNRkS1KErk77fk=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ cmake git ];

  meta = with lib; {
    description = "Library to eliminate all the tedious hassle when making state-of-the-art C++ 14 - 23 libraries.";
    homepage = "https://github.com/ned14/quickcpplib";
    license = licenses.asl20;
    platforms = platforms.all;
    maintainers = with maintainers; [ breakds ];
  };
}
