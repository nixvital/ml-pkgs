{ stdenv
, lib
, buildPythonPackage
, fetchFromGitHub


# build-system
, setuptools
}:

buildPythonPackage rec {
  pname = "aim-ui";
  version = "3.23.0";

  src = fetchFromGitHub {
    owner = "aimhubio";
    repo = "aim";
    rev = "v${version}";
    hash = "sha256-cOmOczsu/kCTac/GXSSHbZJ8DpmeOZy2+UH/98WLgMM=";
  };

  sourceRoot = "${src.name}/aim/web/ui";

  # setuptoolsBuildPhase needs dependencies to be passed through nativeBuildInputs
  nativeBuildInputs = [
    setuptools
  ];

  meta = with lib; {
    description = "UI for aim";
    homepage = "https://github.com/aimhubio/aim/tree/main/aim/web/ui";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
