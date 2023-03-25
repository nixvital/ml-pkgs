{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
}:

buildPythonPackage rec {
  pname = "jaraco.context";
  version = "4.3.0";

  src = fetchFromGitHub {
    owner = "jaraco";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-YdbkpKv7k62uyhmjKoxeA9uf5BWnRD/rK+z46FJN4xk=";
  };

  format = "pyproject";

  buildInputs = [
    setuptools
  ];

  doCheck = true;

  pythonImportsCheck = [ "jaraco.context" ];

  meta = with lib; {
    description = ''
      Available as part of the Tidelift Subscription
    '';
    homepage = "https://github.com/jaraco/jaraco.context";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
