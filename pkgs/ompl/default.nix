{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, eigen
, boost
}:

stdenv.mkDerivation rec {
  pname = "ompl";
  version = "1.6.0";

  src = fetchFromGitHub {
    owner = "ompl";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-6jsB7uZThGvnMACmGE2k1v0aLnudJsWNduAJ2VAH2Oo=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  propagatedBuildInputs = [
    eigen
    boost
  ];

  meta = with lib; {
    homepage = "https://ompl.kavrakilab.org/";
    description = "The Open Motion Planning Library (OMPL)";
    license = licenses.bsd3;
    platforms = platforms.unix;
  };
}
