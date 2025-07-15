{ lib, stdenv, fetchFromGitHub, cmake, c-ares, openssl }:

let
  pname = "libcoro";
  version = "master-pr#361";

in stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "jbaldwin";
    repo = "libcoro";
    rev = "f45ca948b175fd4e37192f5010a5c6bf94dd7b97";
    hash = "sha256-B27fi/IRwsJ38mXA9E+v0ucfgrqbIPD1komeIXnjT18=";
  };

  nativeBuildInputs = [ cmake ];
  propagatedBuildInputs = [ c-ares openssl.dev ];

  cmakeFlags = [
    (lib.cmakeBool "LIBCORO_EXTERNAL_DEPENDENCIES" true)
    (lib.cmakeBool "LIBCORO_BUILD_SHARED_LIBS" true)
  ];

  outputs = [ "out" "dev" ];

  meta = with lib; {
    description = "C++20 coroutine library";
    homepage = "https://github.com/jbaldwin/libcoro";
    license = licenses.asl20;
    platforms = platforms.all;
    maintainers = with maintainers; [ breakds ];
  };
}
