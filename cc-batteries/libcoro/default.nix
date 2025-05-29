{ lib, stdenv, fetchFromGitHub, cmake, c-ares, openssl }:

let
  pname = "libcoro";
  version = "master-pr#327";

in stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "jbaldwin";
    repo = "libcoro";
    rev = "8648acfc6df1c2c93580aa720b523fad5df6a79f";
    hash = "sha256-ThBZ0Zu3/0jYquvPm8EHtqelJk4ap1tjqJEJW0EtRak=";
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
