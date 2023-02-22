{ buildPythonPackage
, fetchFromGitHub
, pycryptodomex
, urllib3
, lxml
, filelock
}:

buildPythonPackage rec {
  pname = "blobfile";
  version = "2.0.1";

  src = fetchFromGitHub {
    owner = "christopher-hesse";
    repo = "blobfile";
    rev = "v${version}";
    sha256 = "sha256-EUU/ZORqri3EIUUAho6cNdRgH+we13AgHyTjsY6tCWg=";
  };

  doCheck = false;

  propagatedBuildInputs = [
    pycryptodomex
    urllib3
    lxml
    filelock
  ];
}
