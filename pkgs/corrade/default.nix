{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:

stdenv.mkDerivation rec {
  pname = "corrade";
  version = "unstable-2024-03-05";

  src = fetchFromGitHub {
    owner = "mosra";
    repo = "corrade";
    rev = "295bbba1f49887da060465f88b8501965f6acd7d";
    hash = "sha256-8ucuEn/oGgbPitL15CDjmo+s1OAVI8bqcwppUWmLp4c=";
  };

  nativeBuildInputs = [ cmake ];

  meta = with lib; {
    description = "C++11 multiplatform utility library";
    homepage = "https://github.com/mosra/corrade";
    license = with licenses; [
      mit
      unlicense
    ];
    maintainers = with maintainers; [ SomeoneSerge ];
    mainProgram = "corrade";
    platforms = platforms.all;
  };
}
