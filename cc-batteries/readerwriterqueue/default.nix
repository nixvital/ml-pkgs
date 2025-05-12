{ lib, stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation (finalAttrs: {
  pname = "readerwriterqueue";
  version = "1.0.7";

  src = fetchFromGitHub {
    owner = "cameron314";
    repo = "readerwriterqueue";
    rev = "v${finalAttrs.version}";
    hash = "sha256-FUCgW22g7tuaMPERYf53BlXwHA4rESE/7C0yx7c6xzc=";
  };

  nativeBuildInputs = [ cmake ];
  
  meta = with lib; {
    description = "A fast single-producer single-consumer lock-free queue for C++";
    homepage = "https://github.com/cameron314/readerwriterqueue";
    license = licenses.bsd2;
    platforms = platforms.all;
    maintainers = with maintainers; [ breakds ];
  };
})
