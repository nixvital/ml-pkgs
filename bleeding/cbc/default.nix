{ lib
, stdenv
, fetchFromGitHub
, zlib
, bzip2
, pkg-config
, coin-utils
, osi
, clp  
, cgl
}:

let pname = "cbc";
    version = "2.10.11";

in stdenv.mkDerivation rec {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "coin-or";
    repo = "Cbc";
    rev = "releases/${version}";
    hash = "sha256-//kerGyPCGpTvh/WpfGhPWUcj768Uavvl6n+fHUOsCE=";
  };

  # or-tools has a hard dependency on Cbc static libraries, so we build both
  configureFlags = [ "-C" "--enable-static" ]
                   ++ lib.optionals stdenv.cc.isClang [ "CXXFLAGS=-std=c++14" ];

  enableParallelBuilding = true;

  hardeningDisable = [ "format" ];

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ zlib bzip2 coin-utils cgl osi clp ];

  # FIXME: move share/coin/Data to a separate output?

  meta = with lib; {
    homepage = "https://projects.coin-or.org/Cbc";
    license = lib.licenses.epl20;
    maintainers = [ breakds ];
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
    description = "Mixed integer programming solver";
  };
}
