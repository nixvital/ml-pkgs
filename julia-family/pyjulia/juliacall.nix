{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, juliapkg
}:

let version = "0.9.23";

in buildPythonPackage {
  pname = "juliacall";
  inherit version;
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "JuliaPy";
    repo = "PythonCall.jl";
    rev = "v${version}";
    hash = "sha256-1JND3jjFbaCWgX6hK/EehG4Cl6G3sgKzXrcDRp0ETFM=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    juliapkg
  ];

  meta = with lib; {
    description = "Python and Julia in harmony";
    homepage = "https://github.com/JuliaPy/PythonCall.jl";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
