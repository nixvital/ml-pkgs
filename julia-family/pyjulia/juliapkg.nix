{ lib
, buildPythonPackage
, fetchFromGitHub
, hatchling
, semver
}:

let version = "0.1.15";

in buildPythonPackage {
  pname = "juliapkg";
  inherit version;
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "JuliaPy";
    repo = "pyjuliapkg";
    rev = "v${version}";
    hash = "sha256-lorMN5cTbncuRSqGwWYt8glhIbgNfL0oeRHZ3+1F1s0=";
  };

  build-system = [
    hatchling
  ];

  dependencies = [
    semver
  ];

  meta = with lib; {
    description = "Manage your Julia dependencies from Python";
    homepage = "https://github.com/JuliaPy/pyjuliapkg";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
