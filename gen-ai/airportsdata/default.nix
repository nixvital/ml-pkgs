{ lib, buildPythonPackage, fetchFromGitHub, setuptools }:

let
  pname = "airportsdata";
  version = "20241001";

in buildPythonPackage {
  inherit pname version;
  pyproject = true;

  src = fetchFromGitHub {
    owner = "mborsetti";
    repo = "airportsdata";
    rev = "v${version}";
    hash = "sha256-3LKr/9Fin1wVBbx+ZjlFLVYsrnSN8i7WXt3eaug/fwo=";
  };

  build-system = [ setuptools ];

  meta = with lib; {
    description =
      "Extensive database of current data for nearly every airport and landing strip in the world, with over 28,000 entries";
    homepage = "https://github.com/mborsetti/airportsdata";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
