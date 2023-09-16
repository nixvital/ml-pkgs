# Note that currently this package need to be put in an environment
# where the `julia` executable is available. Also installing the julia
# packages will be the responsibility of this package (instead of
# nix), which kind of undesirable.

{ lib
, buildPythonPackage
, fetchFromGitHub
, julia
}:

buildPythonPackage rec {
  pname = "julia";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "JuliaPy";
    repo = "pyjulia";
    rev = "v${version}";
    hash = "sha256-yb/nYn0fRPcQF5JNzoRJa4udBFi7wkiRpd0iIjxz1Uc=";
  };

  nativeBuildInputs = [
    julia
  ];

  doCheck = false;

  pythonImportsCheck = [
    "julia"
  ];

  meta = with lib; {
    homepage = "https://github.com/JuliaPy/pyjulia";
    description = ''
      python interface to julia
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; (linux ++ darwin);
  };
}
