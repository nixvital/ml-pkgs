{ lib, stdenv, fetchFromGitHub, cmake, c-ares, openssl }:

let
  pname = "libcoro";
  version = "0.13.0";

in stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "jbaldwin";
    repo = "libcoro";
    rev = "v${version}";
    hash = "sha256-F891UYFX+0tzHHr4T4et7wI8cPp0If6ksb6iDgAvYCk=";
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
