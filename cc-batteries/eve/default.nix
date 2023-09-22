{ lib, stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "eve";
  version = "2023.09.21";

  src = fetchFromGitHub {
    owner = "jfalcou";
    repo = "eve";
    rev = "049af38256308ca8b166724c769b575637f6545a";
    hash = "sha256-pkw9yunZBMSJenloN8eiW0t2QL/0I+hoO9joQzDmigw=";
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags = [
    "-DEVE_BUILD_TEST=OFF"
    "-DEVE_BUILD_BENCHMARKS=OFF"
    "-DEVE_BUILD_DOCUMENTATION=OFF"
  ];

  meta = with lib; {
    description = "EVE - the Expressive Vector Engine in C++20.";
    homepage = "https://github.com/jfalcou/eve";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
