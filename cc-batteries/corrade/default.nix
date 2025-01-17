{ lib, stdenv, fetchFromGitHub, cmake, }:

stdenv.mkDerivation rec {
  pname = "corrade";
  version = "unstable-2025-01-09";

  src = fetchFromGitHub {
    owner = "mosra";
    repo = "corrade";
    rev = "9be0550da90817b67ebf87b7b3e1fe71af6d0f90";
    hash = "sha256-7oDdpxk3LN/ZnUvZKJEVhwj/3/T/SDYw+ZqB24wc7gU=";
  };

  nativeBuildInputs = [ cmake ];

  meta = with lib; {
    description = "C++11 multiplatform utility library";
    homepage = "https://github.com/mosra/corrade";
    license = with licenses; [ mit unlicense ];
    maintainers = with maintainers; [ SomeoneSerge ];
    mainProgram = "corrade";
    platforms = platforms.all;
  };
}
