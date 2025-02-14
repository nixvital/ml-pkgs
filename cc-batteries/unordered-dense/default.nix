# Credit to https://github.com/foolnotion/nur-pkg/blob/master/pkgs/unordered_dense/default.nix

{ lib, stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "unordered_dense";
  version = "4.4.0";

  src = fetchFromGitHub {
    owner = "martinus";
    repo = "unordered_dense";
    rev = "v${version}";
    hash = "sha256-tCsfPOPz7AFqV7HOumtE3WwwOwLckjYd+9PA5uLlhpE=";
  };

  nativeBuildInputs = [ cmake ];

  meta = with lib; {
    description =
      "A fast & densely stored hashmap and hashset based on robin-hood backward shift deletion";
    homepage = "https://github.com/martinus/unordered_dense";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ breakds ];
  };
}
